import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/theme/app_theme.dart';
import '../core/providers/user_provider.dart';
import '../l10n/app_localizations.dart';
import '../models/schema_therapy_data.dart';
import '../models/therapy_recommendations_data.dart';
import '../services/export_service.dart';

/// Therapy Recommendations Screen - Personalized therapy recommendations
class TherapyRecommendationsScreen extends StatefulWidget {
  final Map<int, double> schemaScores;

  const TherapyRecommendationsScreen({
    super.key,
    required this.schemaScores,
  });

  @override
  State<TherapyRecommendationsScreen> createState() =>
      _TherapyRecommendationsScreenState();
}

class _TherapyRecommendationsScreenState
    extends State<TherapyRecommendationsScreen> {
  late List<SchemaTherapySchema> topSchemas;

  @override
  void initState() {
    super.initState();
    // Get top 5 schemas by score
    topSchemas = widget.schemaScores.entries
        .map((e) => SchemaTherapyDatabase.getSchemaById(e.key))
        .whereType<SchemaTherapySchema>()
        .toList()
      ..sort((a, b) =>
          (widget.schemaScores[b.id] ?? 0)
              .compareTo(widget.schemaScores[a.id] ?? 0));
    topSchemas = topSchemas.take(5).toList();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.therapyRecommendations),
        backgroundColor: AppTheme.primaryTeal,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              if (value == 'export') {
                _showExportOptions(context);
              } else if (value == 'share_x') {
                _shareToX(context);
              } else if (value == 'share_instagram') {
                _shareToInstagram(context);
              } else if (value == 'share_template') {
                _showShareTemplate(context);
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'export',
                child: Row(
                  children: [
                    const Icon(Icons.download, size: 20),
                    const SizedBox(width: 12),
                    Text(l10n.exportResults),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'share_x',
                child: Row(
                  children: [
                    const Icon(Icons.share, size: 20),
                    const SizedBox(width: 12),
                    Text(l10n.shareToX),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'share_instagram',
                child: Row(
                  children: [
                    const Icon(Icons.camera_alt, size: 20),
                    const SizedBox(width: 12),
                    Text(l10n.shareToInstagram),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'share_template',
                child: Row(
                  children: [
                    const Icon(Icons.style, size: 20),
                    const SizedBox(width: 12),
                    Text(l10n.shareAsTemplate),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Introduction
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.primaryTeal.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppTheme.primaryTeal.withOpacity(0.3),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.personalizedTherapyPlan,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryTeal,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.basedOnAssessmentResults,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[700],
                            height: 1.5,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Recommendations for each top schema
              ...topSchemas.asMap().entries.map((entry) {
                final index = entry.key + 1;
                final schema = entry.value;
                final score = widget.schemaScores[schema.id] ?? 0;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: _buildRecommendationCard(
                    context,
                    index,
                    schema,
                    score,
                    l10n,
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecommendationCard(
    BuildContext context,
    int index,
    SchemaTherapySchema schema,
    double score,
    AppLocalizations l10n,
  ) {
    // Get detailed recommendations from database
    final recommendation = TherapyRecommendationsDatabase.getRecommendation(schema.id);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: schema.color.withOpacity(0.3)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with rank and schema name
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: schema.color,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      '#$index',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        schema.nameEn,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        '${l10n.score}: ${score.toStringAsFixed(1)}/6.0',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Detailed recommendations (5 points)
            if (recommendation != null) ...[
              Text(
                'Detailed Recommendations:',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryTeal,
                    ),
              ),
              const SizedBox(height: 8),
              ...recommendation.recommendations.asMap().entries.map((entry) {
                final num = entry.key + 1;
                final text = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: schema.color.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Text(
                            '$num',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: schema.color,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          text,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.grey[700],
                                height: 1.5,
                              ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              const SizedBox(height: 12),
            ],

            // Suggested exercises
            Text(
              l10n.suggestedPractices,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryTeal,
                  ),
            ),
            const SizedBox(height: 8),
            ...(recommendation?.exercises ?? _getSuggestedExercises(schema, l10n)).map((exercise) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      size: 16,
                      color: schema.color,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        exercise,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey[700],
                              height: 1.4,
                            ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  List<String> _getSuggestedExercises(SchemaTherapySchema schema, AppLocalizations l10n) {
    // Fallback exercises if recommendation not found
    return [
      l10n.mindfulnessMeditation,
      l10n.journalingAboutSchemaTriggers,
      l10n.cognitiveRestructuring,
      l10n.behavioralExperiments,
      l10n.schemaImageryRescripting,
    ];
  }

  /// Generate recommendations summary for sharing
  String _generateRecommendationsSummary() {
    final buffer = StringBuffer();
    buffer.writeln('🧠 MySchema - Therapy Recommendations');
    buffer.writeln();
    buffer.writeln('Based on my assessment results:');
    buffer.writeln();

    for (var i = 0; i < topSchemas.length; i++) {
      final schema = topSchemas[i];
      final score = widget.schemaScores[schema.id] ?? 0;
      buffer.writeln('${i + 1}. ${schema.nameEn}');
      buffer.writeln('   Score: ${score.toStringAsFixed(1)}/6.0');
      buffer.writeln('   ${schema.descriptionEn}');
      buffer.writeln();
    }

    buffer.writeln('Get personalized therapy recommendations on MySchema!');
    buffer.writeln('#SchemaTherapy #MentalHealth #MySchema');

    return buffer.toString();
  }

  /// Show export options
  void _showExportOptions(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    // Create a dummy result for export
    final dummyResult = PremiumQuestionnaireResult(
      schemaScores: widget.schemaScores,
      domainScores: {},
      totalQuestions: 0,
      completedAt: DateTime.now(),
    );

    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.exportResults,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.description),
              title: Text(l10n.exportAsText),
              onTap: () {
                final text = ExportService.exportAsText(
                  dummyResult,
                  userName: userProvider.currentUser?.name ?? 'User',
                );
                _copyToClipboard(context, text);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.table_chart),
              title: Text(l10n.exportAsCSV),
              onTap: () {
                final csv = ExportService.exportAsCSV(
                  dummyResult,
                  userName: userProvider.currentUser?.name ?? 'User',
                );
                _copyToClipboard(context, csv);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.picture_as_pdf),
              title: Text(l10n.exportAsPDF),
              onTap: () async {
                Navigator.pop(context);
                _showLoadingDialog(context);
                final file = await ExportService.exportToPDF(
                  dummyResult,
                  userName: userProvider.currentUser?.name ?? 'User',
                );
                if (mounted) Navigator.pop(context);
                if (file != null && mounted) {
                  _showSuccessMessage(context, l10n.pdfExportedSuccessfully);
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.download),
              title: Text(l10n.exportAsCSVFile),
              onTap: () async {
                Navigator.pop(context);
                _showLoadingDialog(context);
                final file = await ExportService.exportToCSVFile(
                  dummyResult,
                  userName: userProvider.currentUser?.name ?? 'User',
                );
                if (mounted) Navigator.pop(context);
                if (file != null && mounted) {
                  _showSuccessMessage(context, l10n.csvExportedSuccessfully);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Share recommendations to X (Twitter)
  Future<void> _shareToX(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    try {
      final summary = _generateRecommendationsSummary();
      final text = Uri.encodeComponent(summary);
      final xUrl = 'https://twitter.com/intent/tweet?text=$text';

      if (await canLaunchUrl(Uri.parse(xUrl))) {
        await launchUrl(Uri.parse(xUrl), mode: LaunchMode.externalApplication);
        _showSuccessMessage(context, l10n.openingXToShare);
      } else {
        _showErrorMessage(context, l10n.couldNotOpenX);
      }
    } catch (e) {
      _showErrorMessage(context, '${l10n.errorSharingToX}: $e');
    }
  }

  /// Share recommendations to Instagram
  void _shareToInstagram(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final summary = _generateRecommendationsSummary();

    _copyToClipboard(context, summary);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.shareToInstagramInstructions),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.summaryHasBeenCopied),
            const SizedBox(height: 16),
            Text(
              l10n.stepsToShare,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(l10n.openInstagram),
            Text(l10n.createNewStory),
            Text(l10n.addSchemaImage),
            Text(l10n.pasteCaption),
            Text(l10n.shareWithHashtags),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
        ],
      ),
    );
  }

  /// Show shareable template options
  void _showShareTemplate(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.shareYourSchemaResults),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.chooseTemplate),
            const SizedBox(height: 16),
            _buildTemplateOption(
              context,
              l10n.simpleSummary,
              l10n.cleanAndMinimal,
              () => _generateTemplate(context, 'simple'),
            ),
            _buildTemplateOption(
              context,
              l10n.detailedAnalysis,
              l10n.completeSchemaBreakdown,
              () => _generateTemplate(context, 'detailed'),
            ),
            _buildTemplateOption(
              context,
              l10n.visualChart,
              l10n.schemaScoresVisualization,
              () => _generateTemplate(context, 'chart'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
        ],
      ),
    );
  }

  /// Build template option widget
  Widget _buildTemplateOption(
    BuildContext context,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: AppTheme.primaryTeal.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryTeal,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Generate shareable template
  void _generateTemplate(BuildContext context, String templateType) {
    final l10n = AppLocalizations.of(context)!;
    Navigator.pop(context);

    String template = '';

    if (templateType == 'simple') {
      template = _generateRecommendationsSummary();
    } else if (templateType == 'detailed') {
      final buffer = StringBuffer();
      buffer.writeln('🧠 MySchema - Detailed Therapy Recommendations');
      buffer.writeln();

      for (var i = 0; i < topSchemas.length; i++) {
        final schema = topSchemas[i];
        final score = widget.schemaScores[schema.id] ?? 0;
        buffer.writeln('${i + 1}. ${schema.nameEn}');
        buffer.writeln('   Score: ${score.toStringAsFixed(1)}/6.0');
        buffer.writeln('   Description: ${schema.descriptionEn}');
        buffer.writeln();
      }

      buffer.writeln('Get personalized therapy recommendations on MySchema!');
      buffer.writeln('#SchemaTherapy #MentalHealth #MySchema');
      template = buffer.toString();
    } else if (templateType == 'chart') {
      final buffer = StringBuffer();
      buffer.writeln('📊 My Schema Therapy Results:');
      buffer.writeln();

      for (var i = 0; i < topSchemas.length; i++) {
        final schema = topSchemas[i];
        final score = widget.schemaScores[schema.id] ?? 0;
        final barLength = score.toInt();
        buffer.writeln('${i + 1}. ${schema.nameEn}');
        buffer.writeln('   ${'█' * barLength}${'░' * (6 - barLength)} ${score.toStringAsFixed(1)}/6');
        buffer.writeln();
      }

      buffer.writeln('Discover your schemas: https://myschema.app');
      buffer.writeln('#SchemaTherapy #MentalHealth #MySchema');
      template = buffer.toString();
    }

    _copyToClipboard(context, template);
    _showSuccessMessage(context, l10n.templateCopied);
  }

  /// Copy text to clipboard
  void _copyToClipboard(BuildContext context, String text) {
    final l10n = AppLocalizations.of(context)!;
    final scaffold = ScaffoldMessenger.of(context);

    // Copy to clipboard using Flutter's clipboard
    Clipboard.setData(ClipboardData(text: text)).then((_) {
      scaffold.showSnackBar(
        SnackBar(
          content: Text(l10n.copiedToClipboard),
          duration: const Duration(seconds: 2),
        ),
      );
    });
  }

  /// Show loading dialog
  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        content: SizedBox(
          height: 50,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

  /// Show success message
  void _showSuccessMessage(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  /// Show error message
  void _showErrorMessage(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

