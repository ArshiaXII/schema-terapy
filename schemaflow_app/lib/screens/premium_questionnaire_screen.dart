import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/premium_questions.dart';
import '../models/schema_therapy_data.dart';
import '../core/providers/user_provider.dart';
import '../services/api_service.dart';
import '../services/schema_analysis_service.dart';
import '../core/theme/app_theme.dart';
import '../l10n/app_localizations.dart';
import '../widgets/page_transitions.dart';
import '../widgets/success_animation.dart';
import 'premium_results_screen.dart';

class PremiumQuestionnaireScreen extends StatefulWidget {
  const PremiumQuestionnaireScreen({Key? key}) : super(key: key);

  @override
  State<PremiumQuestionnaireScreen> createState() =>
      _PremiumQuestionnaireScreenState();
}

class _PremiumQuestionnaireScreenState extends State<PremiumQuestionnaireScreen> {
  late PageController _pageController;
  int _currentQuestion = 0;
  final Map<int, int> _answers = {}; // questionId -> score (1-6)
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextQuestion() {
    if (_currentQuestion < PremiumQuestionsDatabase.allQuestions.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousQuestion() {
    if (_currentQuestion > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _submitQuestionnaire() async {
    if (_answers.length != PremiumQuestionsDatabase.allQuestions.length) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.pleaseAnswerAllQuestions),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Validate answers
      final validation = SchemaAnalysisService.validateAnswers(
        _answers,
        PremiumQuestionsDatabase.allQuestions.length,
      );

      if (!validation.isValid) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Validation Error: ${validation.errorMessage}'),
            backgroundColor: Colors.red,
          ),
        );
        setState(() => _isLoading = false);
        return;
      }

      // Calculate schema scores using SchemaAnalysisService
      final schemaScores = SchemaAnalysisService.calculateSchemaScores(_answers);

      // Calculate domain scores
      final finalDomainScores = SchemaAnalysisService.calculateDomainScores(schemaScores);

      // Save results
      final result = PremiumQuestionnaireResult(
        schemaScores: schemaScores,
        domainScores: finalDomainScores,
        completedAt: DateTime.now(),
        totalQuestions: PremiumQuestionsDatabase.allQuestions.length,
      );

      // Update user provider
      if (mounted) {
        context.read<UserProvider>().setPremiumQuestionnaireResult(result);

        // Navigate to results with animation
        Navigator.of(context).pushReplacement(
          ScalePageRoute(
            builder: (context) => const PremiumResultsScreen(),
            duration: const Duration(milliseconds: 500),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final questions = PremiumQuestionsDatabase.allQuestions;
    final isLastQuestion = _currentQuestion == questions.length - 1;
    final isAnswered = _answers.containsKey(questions[_currentQuestion].id);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.detailedAssessment),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Progress bar
          LinearProgressIndicator(
            value: (_currentQuestion + 1) / questions.length,
            minHeight: 4,
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _currentQuestion = index);
              },
              physics: const NeverScrollableScrollPhysics(),
              itemCount: questions.length,
              itemBuilder: (context, index) {
                final question = questions[index];
                final selectedScore = _answers[question.id];

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Question number
                      Text(
                        '${AppLocalizations.of(context)!.question} ${index + 1}/${questions.length}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 16),
                      // Question text
                      Text(
                        Localizations.localeOf(context).languageCode == 'tr'
                            ? question.textTr
                            : question.textEn,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 32),
                      // Scale (1-6)
                      Column(
                        children: List.generate(6, (i) {
                          final score = i + 1;
                          final isSelected = selectedScore == score;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _answers[question.id] = score;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: isSelected
                                        ? Theme.of(context).primaryColor
                                        : Colors.grey[300]!,
                                    width: isSelected ? 2 : 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                  color: isSelected
                                      ? Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.1)
                                      : Colors.transparent,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        _getScaleLabel(context, score),
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: isSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    if (isSelected)
                                      Icon(
                                        Icons.check_circle,
                                        color:
                                            Theme.of(context).primaryColor,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          // Navigation buttons
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _currentQuestion > 0 ? _previousQuestion : null,
                    icon: const Icon(Icons.arrow_back),
                    label: Text(AppLocalizations.of(context)!.previous),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: isAnswered
                        ? (isLastQuestion ? _submitQuestionnaire : _nextQuestion)
                        : null,
                    icon: Icon(isLastQuestion ? Icons.check : Icons.arrow_forward),
                    label: Text(
                      isLastQuestion
                          ? AppLocalizations.of(context)!.submit
                          : AppLocalizations.of(context)!.next,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getScaleLabel(BuildContext context, int score) {
    final labels = [
      AppLocalizations.of(context)!.completelyDisagree,
      AppLocalizations.of(context)!.mostlyDisagree,
      AppLocalizations.of(context)!.slightlyDisagree,
      AppLocalizations.of(context)!.slightlyAgree,
      AppLocalizations.of(context)!.mostlyAgree,
      AppLocalizations.of(context)!.completelyAgree,
    ];
    return labels[score - 1];
  }
}

