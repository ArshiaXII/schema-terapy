import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../l10n/app_localizations.dart';
import '../models/schema_therapy_data.dart';
import '../models/therapy_recommendations_data.dart';

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
}

