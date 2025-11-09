import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/schema_therapy_data.dart';
import '../core/providers/user_provider.dart';
import '../core/theme/app_theme.dart';
import '../services/export_service.dart';
import 'schema_education_screen.dart';
import 'therapy_recommendations_screen.dart';
import 'assessment_comparison_screen.dart';

class PremiumResultsScreen extends StatefulWidget {
  const PremiumResultsScreen({Key? key}) : super(key: key);

  @override
  State<PremiumResultsScreen> createState() => _PremiumResultsScreenState();
}

class _PremiumResultsScreenState extends State<PremiumResultsScreen> {
  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final result = userProvider.premiumQuestionnaireResult;

    if (result == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Results')),
        body: const Center(child: Text('No results available')),
      );
    }

    // Sort schemas by score (highest first)
    final sortedSchemas = result.schemaScores.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.yourResults),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.assessmentSummary,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '${AppLocalizations.of(context)!.totalQuestions}: ${result.totalQuestions}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${AppLocalizations.of(context)!.completedAt}: ${result.completedAt.toString().split('.')[0]}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Top schemas
            Text(
              AppLocalizations.of(context)!.dominantSchemas,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ...sortedSchemas.take(5).map((entry) {
              final schema = SchemaTherapyDatabase.getSchemaById(entry.key);
              if (schema == null) return const SizedBox.shrink();

              final score = entry.value;
              final percentage = ((score - 1) / 5 * 100).toStringAsFixed(0);

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(schema.icon, color: schema.color, size: 28),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    Localizations.localeOf(context)
                                                .languageCode ==
                                            'tr'
                                        ? schema.nameTr
                                        : schema.nameEn,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium,
                                  ),
                                  Text(
                                    'Score: ${score.toStringAsFixed(1)}/6',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: (score - 1) / 5,
                            minHeight: 8,
                            backgroundColor: Colors.grey[300],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              schema.color,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          Localizations.localeOf(context).languageCode == 'tr'
                              ? schema.descriptionTr
                              : schema.descriptionEn,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
            const SizedBox(height: 24),
            // Domain breakdown
            Text(
              AppLocalizations.of(context)!.domainBreakdown,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ...result.domainScores.entries.map((entry) {
              final domainId = entry.key;
              final score = entry.value;
              final domainNames = [
                'Disconnection & Rejection',
                'Impaired Autonomy',
                'Impaired Limits',
                'Other-Directedness',
                'Over-vigilance & Inhibition',
              ];

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          domainNames[domainId - 1],
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          '${score.toStringAsFixed(1)}/6',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: (score - 1) / 5,
                        minHeight: 6,
                        backgroundColor: Colors.grey[300],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            const SizedBox(height: 24),
            // Therapy Recommendations
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => TherapyRecommendationsScreen(
                        schemaScores: result.schemaScores,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.lightbulb_outline),
                label: const Text('Therapy Recommendations'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.accentGreen,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Progress Tracking
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  userProvider.addAssessmentToHistory(result);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AssessmentComparisonScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.trending_up),
                label: const Text('View Progress'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryTeal,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Export Results
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _showExportOptions(context, result, userProvider),
                icon: const Icon(Icons.download),
                label: const Text('Export Results'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(AppLocalizations.of(context)!.backToHome),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showExportOptions(
    BuildContext context,
    PremiumQuestionnaireResult result,
    UserProvider userProvider,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Export Results',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.description),
              title: const Text('Export as Text'),
              onTap: () {
                final text = ExportService.exportAsText(
                  result,
                  userName: userProvider.currentUser?.name ?? 'User',
                );
                _copyToClipboard(context, text);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.table_chart),
              title: const Text('Export as CSV'),
              onTap: () {
                final csv = ExportService.exportAsCSV(
                  result,
                  userName: userProvider.currentUser?.name ?? 'User',
                );
                _copyToClipboard(context, csv);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Share Summary'),
              onTap: () {
                final summary = ExportService.generateShareableSummary(
                  result,
                  userName: userProvider.currentUser?.name ?? 'User',
                );
                _copyToClipboard(context, summary);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _copyToClipboard(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Copied to clipboard!'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
