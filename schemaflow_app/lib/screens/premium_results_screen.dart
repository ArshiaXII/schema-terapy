import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/schema_therapy_data.dart';
import '../core/providers/user_provider.dart';
import '../core/theme/app_theme.dart';
import '../services/export_service.dart';
import '../l10n/app_localizations.dart';
import '../widgets/page_transitions.dart';
import '../widgets/success_animation.dart';
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
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary card
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingXL),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppTheme.primaryTeal.withOpacity(0.1),
                    AppTheme.accentGreen.withOpacity(0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(AppTheme.radiusL),
                border: Border.all(
                  color: AppTheme.primaryTeal.withOpacity(0.15),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryTeal.withOpacity(0.1),
                    blurRadius: 20,
                    spreadRadius: 1,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.assessmentSummary,
                    style: AppTheme.titleLarge.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingXL),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Questions',
                              style: AppTheme.bodySmall.copyWith(
                                color: AppTheme.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${result.totalQuestions}',
                              style: AppTheme.titleLarge.copyWith(
                                color: AppTheme.primaryTeal,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Completed',
                              style: AppTheme.bodySmall.copyWith(
                                color: AppTheme.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              result.completedAt.toString().split('.')[0],
                              style: AppTheme.bodySmall.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
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
                padding: const EdgeInsets.only(bottom: AppTheme.spacingM),
                child: Container(
                  padding: const EdgeInsets.all(AppTheme.spacingL),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.95),
                        Colors.white.withOpacity(0.85),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(AppTheme.radiusL),
                    border: Border.all(
                      color: schema.color.withOpacity(0.15),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: schema.color.withOpacity(0.12),
                        blurRadius: 20,
                        spreadRadius: 1,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  schema.color.withOpacity(0.15),
                                  schema.color.withOpacity(0.08),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(AppTheme.radiusM),
                              border: Border.all(
                                color: schema.color.withOpacity(0.2),
                                width: 1.5,
                              ),
                            ),
                            child: Icon(schema.icon, color: schema.color, size: 28),
                          ),
                          const SizedBox(width: AppTheme.spacingM),
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
                                  style: AppTheme.titleMedium.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppTheme.spacingS,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: schema.color.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    'Score: ${score.toStringAsFixed(1)}/6',
                                    style: AppTheme.labelSmall.copyWith(
                                      color: schema.color,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppTheme.spacingL),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: (score - 1) / 5,
                          minHeight: 8,
                          backgroundColor: schema.color.withOpacity(0.1),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            schema.color,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacingL),
                      Text(
                        Localizations.localeOf(context).languageCode == 'tr'
                            ? schema.descriptionTr
                            : schema.descriptionEn,
                        style: AppTheme.bodySmall.copyWith(
                          color: AppTheme.textSecondary,
                          height: 1.6,
                        ),
                      ),
                    ],
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
              leading: const Icon(Icons.picture_as_pdf),
              title: const Text('Export as PDF'),
              onTap: () async {
                Navigator.pop(context);
                _showLoadingDialog(context);
                final file = await ExportService.exportToPDF(
                  result,
                  userName: userProvider.currentUser?.name ?? 'User',
                );
                if (mounted) Navigator.pop(context);
                if (file != null && mounted) {
                  _showSuccessMessage(context, 'PDF exported successfully!');
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.download),
              title: const Text('Export as CSV File'),
              onTap: () async {
                Navigator.pop(context);
                _showLoadingDialog(context);
                final file = await ExportService.exportToCSVFile(
                  result,
                  userName: userProvider.currentUser?.name ?? 'User',
                );
                if (mounted) Navigator.pop(context);
                if (file != null && mounted) {
                  _showSuccessMessage(context, 'CSV exported successfully!');
                }
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
            const Divider(),
            ListTile(
              leading: const Icon(Icons.share_outlined),
              title: const Text('Share to X (Twitter)'),
              onTap: () async {
                Navigator.pop(context);
                await _shareToX(context, result, userProvider);
              },
            ),
            ListTile(
              leading: const Icon(Icons.share_outlined),
              title: const Text('Share to Instagram'),
              onTap: () async {
                Navigator.pop(context);
                await _shareToInstagram(context, result, userProvider);
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Share as Template'),
              onTap: () {
                Navigator.pop(context);
                _showShareTemplate(context, result, userProvider);
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Share results to X (Twitter)
  Future<void> _shareToX(
    BuildContext context,
    PremiumQuestionnaireResult result,
    UserProvider userProvider,
  ) async {
    try {
      final summary = ExportService.generateShareableSummary(
        result,
        userName: userProvider.currentUser?.name ?? 'User',
      );

      // Create X share URL
      final text = Uri.encodeComponent(
        'I just completed my Schema Therapy assessment on MySchema! 🧠\n\n$summary\n\n#SchemaTherapy #MentalHealth #MySchema'
      );
      final xUrl = 'https://twitter.com/intent/tweet?text=$text';

      if (await canLaunchUrl(Uri.parse(xUrl))) {
        await launchUrl(Uri.parse(xUrl), mode: LaunchMode.externalApplication);
        _showSuccessMessage(context, 'Opening X to share your results!');
      } else {
        _showErrorMessage(context, 'Could not open X. Please try again.');
      }
    } catch (e) {
      _showErrorMessage(context, 'Error sharing to X: $e');
    }
  }

  /// Share results to Instagram
  Future<void> _shareToInstagram(
    BuildContext context,
    PremiumQuestionnaireResult result,
    UserProvider userProvider,
  ) async {
    try {
      final summary = ExportService.generateShareableSummary(
        result,
        userName: userProvider.currentUser?.name ?? 'User',
      );

      // Instagram doesn't support direct URL sharing, so we'll copy to clipboard
      // and show instructions
      _copyToClipboard(context, summary);

      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Share to Instagram'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Your summary has been copied to clipboard!'),
                const SizedBox(height: 12),
                const Text('Steps to share:'),
                const SizedBox(height: 8),
                const Text('1. Open Instagram'),
                const Text('2. Create a new Story or Post'),
                const Text('3. Add your schema results image'),
                const Text('4. Paste the summary in the caption'),
                const Text('5. Share with #SchemaTherapy #MySchema'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      _showErrorMessage(context, 'Error preparing Instagram share: $e');
    }
  }

  /// Show shareable template options
  void _showShareTemplate(
    BuildContext context,
    PremiumQuestionnaireResult result,
    UserProvider userProvider,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Share Your Schema Results'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Choose a template to share your schema results:'),
            const SizedBox(height: 16),
            _buildTemplateOption(
              context,
              'Simple Summary',
              'Clean and minimal design',
              () => _generateTemplate(context, result, 'simple'),
            ),
            const SizedBox(height: 8),
            _buildTemplateOption(
              context,
              'Detailed Analysis',
              'Complete schema breakdown',
              () => _generateTemplate(context, result, 'detailed'),
            ),
            const SizedBox(height: 8),
            _buildTemplateOption(
              context,
              'Visual Chart',
              'Schema scores visualization',
              () => _generateTemplate(context, result, 'chart'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  /// Build template option widget
  Widget _buildTemplateOption(
    BuildContext context,
    String title,
    String description,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  /// Generate shareable template
  void _generateTemplate(
    BuildContext context,
    PremiumQuestionnaireResult result,
    String templateType,
  ) {
    Navigator.pop(context);

    String template = '';

    if (templateType == 'simple') {
      template = ExportService.generateShareableSummary(
        result,
        userName: 'User',
      );
    } else if (templateType == 'detailed') {
      template = ExportService.exportAsText(
        result,
        userName: 'User',
      );
    } else if (templateType == 'chart') {
      template = 'My Schema Therapy Results:\n\n';
      result.schemaScores.forEach((schemaId, score) {
        final schema = SchemaTherapyDatabase.getSchemaById(schemaId);
        if (schema != null) {
          template += '${schema.nameEn}: ${'█' * (score.toInt())} ${score.toStringAsFixed(1)}/6\n';
        }
      });
    }

    _copyToClipboard(context, template);
    _showSuccessMessage(context, 'Template copied! Ready to share.');
  }

  void _showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
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

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              const Text('Exporting...'),
            ],
          ),
        ),
      ),
    );
  }

  void _showSuccessMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
