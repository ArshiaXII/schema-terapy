import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../core/theme/app_theme.dart';
import '../core/providers/user_provider.dart';
import '../services/api_service.dart';
import 'teaser_result_screen.dart';

/// Questionnaire screen for schema assessment
class QuestionnaireScreen extends StatefulWidget {
  const QuestionnaireScreen({super.key});

  @override
  State<QuestionnaireScreen> createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> 
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  
  int _currentQuestionIndex = 0;
  final Map<int, double> _answers = {};
  bool _isSubmitting = false;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Free test questions - exactly 10 questions for teaser analysis
  final List<QuestionnaireQuestion> _questions = [
    QuestionnaireQuestion(
      id: 1,
      textKey: "question1",
      categoryKey: "categoryAbandonment",
    ),
    QuestionnaireQuestion(
      id: 2,
      textKey: "question2",
      categoryKey: "categoryDefectiveness",
    ),
    QuestionnaireQuestion(
      id: 3,
      textKey: "question3",
      categoryKey: "categoryMistrust",
    ),
    QuestionnaireQuestion(
      id: 4,
      textKey: "question4",
      categoryKey: "categorySocialIsolation",
    ),
    QuestionnaireQuestion(
      id: 5,
      textKey: "question5",
      categoryKey: "categoryEmotionalDeprivation",
    ),
    QuestionnaireQuestion(
      id: 6,
      textKey: "question6",
      categoryKey: "categoryFailure",
    ),
    QuestionnaireQuestion(
      id: 7,
      textKey: "question7",
      categoryKey: "categoryDependence",
    ),
    QuestionnaireQuestion(
      id: 8,
      textKey: "question8",
      categoryKey: "categoryVulnerability",
    ),
    QuestionnaireQuestion(
      id: 9,
      textKey: "question9",
      categoryKey: "categoryEnmeshment",
    ),
    QuestionnaireQuestion(
      id: 10,
      textKey: "question10",
      categoryKey: "categorySubjugation",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.3, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  double get _progress => (_currentQuestionIndex + 1) / _questions.length;

  bool get _canProceed => _answers.containsKey(_currentQuestionIndex);

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _animationController.reset();
      _animationController.forward();
    } else {
      _submitQuestionnaire();
    }
  }

  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _animationController.reset();
      _animationController.forward();
    }
  }

  Future<void> _submitQuestionnaire() async {
    setState(() {
      _isSubmitting = true;
    });

    try {
      // Calculate the dominant schema from the 10 questions
      final dominantSchema = _calculateDominantSchema();

      print('🧠 Calculated dominant schema: $dominantSchema');
      print('🔄 Starting API analysis for teaser...');

      // Call the API to analyze the single dominant schema
      try {
        final apiService = ApiService();
        final analysisResult = await apiService.analyzeSchemas([dominantSchema]);

        print('✅ API Analysis Result received');
        print('📋 Analysis length: ${analysisResult.length} characters');

        if (mounted) {
          // Navigate to the teaser result screen with the dominant schema and analysis
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => TeaserResultScreen(
                dominantSchema: dominantSchema,
                fullAnalysisText: analysisResult,
              ),
            ),
          );
        }

      } catch (apiError) {
        print('❌ API Error: $apiError');

        // Fallback: Navigate to teaser with mock analysis if API fails
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => TeaserResultScreen(
                dominantSchema: dominantSchema,
                fullAnalysisText: _getMockAnalysis(context, dominantSchema),
              ),
            ),
          );
        }
      }

    } catch (e) {
      print('❌ Error in questionnaire submission: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error processing your responses. Please try again.'),
            backgroundColor: AppTheme.errorRed,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  /// Calculate the dominant schema based on the 10 free test questions
  String _calculateDominantSchema() {
    final schemaScores = <String, double>{};

    // Calculate scores for each schema category
    for (int i = 0; i < _questions.length; i++) {
      final question = _questions[i];
      final answer = _answers[i] ?? 1.0;
      final category = question.englishCategory;

      // Add the answer score to the schema category
      schemaScores[category] = (schemaScores[category] ?? 0.0) + answer;
    }

    // Find the schema with the highest score
    String dominantSchema = schemaScores.keys.first;
    double highestScore = schemaScores[dominantSchema] ?? 0.0;

    for (final entry in schemaScores.entries) {
      if (entry.value > highestScore) {
        highestScore = entry.value;
        dominantSchema = entry.key;
      }
    }

    print('📊 Schema scores: $schemaScores');
    print('🎯 Dominant schema: $dominantSchema (score: $highestScore)');

    return dominantSchema;
  }

  /// Provide mock analysis text if API fails (localized)
  String _getMockAnalysis(BuildContext context, String schema) {
    final l = AppLocalizations.of(context)!;
    return l.mockAnalysisFallback;
  }

  Map<String, dynamic> _calculateResults() {
    // Legacy method - keeping for compatibility
    final categories = <String, List<double>>{};

    for (int i = 0; i < _questions.length; i++) {
      final question = _questions[i];
      final answer = _answers[i] ?? 1.0;

      if (!categories.containsKey(question.englishCategory)) {
        categories[question.englishCategory] = [];
      }
      categories[question.englishCategory]!.add(answer);
    }

    final scores = <String, double>{};
    for (final entry in categories.entries) {
      final average = entry.value.reduce((a, b) => a + b) / entry.value.length;
      scores[entry.key] = average;
    }

    return {
      'scores': scores,
      'completedAt': DateTime.now().toIso8601String(),
      'totalQuestions': _questions.length,
      'dominantSchemas': scores.entries
          .where((e) => e.value >= 4.0)
          .map((e) => e.key)
          .toList(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        child: _isSubmitting ? _buildSubmittingView() : _buildQuestionView(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: _currentQuestionIndex > 0
          ? IconButton(
              onPressed: _previousQuestion,
              icon: const Icon(CupertinoIcons.chevron_left),
            )
          : null,
      title: Text(
        AppLocalizations.of(context)!.questionProgress(
          _currentQuestionIndex + 1,
          _questions.length,
        ),
        style: AppTheme.titleMedium,
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(8),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: AppTheme.spacingL),
          child: LinearProgressIndicator(
            value: _progress,
            backgroundColor: AppTheme.textTertiary.withOpacity(0.2),
            valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryTeal),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionView() {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _questions.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(AppTheme.spacingL),
                child: Column(
                  children: [
                    const SizedBox(height: AppTheme.spacingXL),
                    
                    // Question card
                    Expanded(
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: _buildQuestionCard(_questions[index]),
                        ),
                      ),
                    ),
                    
                    // Answer slider
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: _buildAnswerSlider(index),
                    ),
                    
                    const SizedBox(height: AppTheme.spacingXL),
                  ],
                ),
              );
            },
          ),
        ),
        
        // Navigation buttons
        _buildNavigationButtons(),
      ],
    );
  }

  Widget _buildQuestionCard(QuestionnaireQuestion question) {
    final localizations = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppTheme.spacingXL),
      decoration: AppTheme.elevatedCardDecoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.quote_bubble,
            size: 48,
            color: AppTheme.primaryTeal.withOpacity(0.7),
          ),

          const SizedBox(height: AppTheme.spacingXL),

          Text(
            question.getText(localizations),
            style: AppTheme.headlineMedium.copyWith(
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: AppTheme.spacingL),
          
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingM,
              vertical: AppTheme.spacingS,
            ),
            decoration: BoxDecoration(
              color: AppTheme.primaryTeal.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusS),
            ),
            child: Text(
              question.getCategory(localizations),
              style: AppTheme.labelMedium.copyWith(
                color: AppTheme.primaryTeal,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerSlider(int questionIndex) {
    final localizations = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingL),
      decoration: AppTheme.cardDecoration,
      child: Column(
        children: [
          Text(
            localizations.howMuchApplies,
            style: AppTheme.titleMedium,
          ),

          const SizedBox(height: AppTheme.spacingL),

          Row(
            children: [
              Text(
                localizations.notAtAll,
                style: AppTheme.bodySmall.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
              Expanded(
                child: Slider(
                  value: _answers[questionIndex] ?? 1.0,
                  min: 1.0,
                  max: 6.0,
                  divisions: 5,
                  activeColor: AppTheme.primaryTeal,
                  inactiveColor: AppTheme.textTertiary.withOpacity(0.3),
                  onChanged: (value) {
                    setState(() {
                      _answers[questionIndex] = value;
                    });
                  },
                ),
              ),
              Text(
                localizations.completely,
                style: AppTheme.bodySmall.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
          
          Text(
            '${(_answers[questionIndex] ?? 1.0).round()}',
            style: AppTheme.headlineMedium.copyWith(
              color: AppTheme.primaryTeal,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingL),
      child: Row(
        children: [
          if (_currentQuestionIndex > 0) ...[
            Expanded(
              child: OutlinedButton(
                onPressed: _previousQuestion,
                style: AppTheme.secondaryButtonStyle,
                child: const Text('Back'),
              ),
            ),
            const SizedBox(width: AppTheme.spacingM),
          ],
          
          Expanded(
            flex: _currentQuestionIndex > 0 ? 1 : 2,
            child: ElevatedButton(
              onPressed: _canProceed ? _nextQuestion : null,
              style: AppTheme.primaryButtonStyle,
              child: Text(
                _currentQuestionIndex == _questions.length - 1
                    ? AppLocalizations.of(context)!.complete
                    : AppLocalizations.of(context)!.next,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmittingView() {
    final localizations = AppLocalizations.of(context)!;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              CupertinoIcons.person_crop_circle_badge_checkmark,
              size: 40,
              color: Colors.white,
            ),
          ),
          
          const SizedBox(height: AppTheme.spacingXL),
          
          const CircularProgressIndicator(
            color: AppTheme.primaryTeal,
          ),
          
          const SizedBox(height: AppTheme.spacingL),
          
          Text(
            localizations.analyzingAnswers,
            style: AppTheme.headlineMedium,
          ),

          const SizedBox(height: AppTheme.spacingS),

          Text(
            localizations.analysisMayTakeTime,
            style: AppTheme.bodyMedium.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

/// Data model for questionnaire questions
class QuestionnaireQuestion {
  final int id;
  final String textKey;
  final String categoryKey;

  const QuestionnaireQuestion({
    required this.id,
    required this.textKey,
    required this.categoryKey,
  });

  /// Get localized text for this question
  String getText(AppLocalizations localizations) {
    switch (textKey) {
      case 'question1': return localizations.question1;
      case 'question2': return localizations.question2;
      case 'question3': return localizations.question3;
      case 'question4': return localizations.question4;
      case 'question5': return localizations.question5;
      case 'question6': return localizations.question6;
      case 'question7': return localizations.question7;
      case 'question8': return localizations.question8;
      case 'question9': return localizations.question9;
      case 'question10': return localizations.question10;
      default: return textKey;
    }
  }

  /// Get localized category for this question
  String getCategory(AppLocalizations localizations) {
    switch (categoryKey) {
      case 'categoryAbandonment': return localizations.categoryAbandonment;
      case 'categoryDefectiveness': return localizations.categoryDefectiveness;
      case 'categoryMistrust': return localizations.categoryMistrust;
      case 'categorySocialIsolation': return localizations.categorySocialIsolation;
      case 'categoryEmotionalDeprivation': return localizations.categoryEmotionalDeprivation;
      case 'categoryFailure': return localizations.categoryFailure;
      case 'categoryDependence': return localizations.categoryDependence;
      case 'categoryVulnerability': return localizations.categoryVulnerability;
      case 'categoryEnmeshment': return localizations.categoryEnmeshment;
      case 'categorySubjugation': return localizations.categorySubjugation;
      default: return categoryKey;
    }
  }

  /// Get English category name for internal calculations and API calls
  String get englishCategory {
    switch (categoryKey) {
      case 'categoryAbandonment': return 'Abandonment';
      case 'categoryDefectiveness': return 'Defectiveness';
      case 'categoryMistrust': return 'Mistrust';
      case 'categorySocialIsolation': return 'Social Isolation';
      case 'categoryEmotionalDeprivation': return 'Emotional Deprivation';
      case 'categoryFailure': return 'Failure';
      case 'categoryDependence': return 'Dependence';
      case 'categoryVulnerability': return 'Vulnerability';
      case 'categoryEnmeshment': return 'Enmeshment';
      case 'categorySubjugation': return 'Subjugation';
      default: return categoryKey;
    }
  }
}
