import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_theme.dart';
import '../l10n/app_localizations.dart';
import '../core/providers/user_provider.dart';
import '../models/schema_therapy_data.dart';

/// Assessment Comparison Screen - Compare multiple assessments over time
class AssessmentComparisonScreen extends StatefulWidget {
  const AssessmentComparisonScreen({super.key});

  @override
  State<AssessmentComparisonScreen> createState() =>
      _AssessmentComparisonScreenState();
}

class _AssessmentComparisonScreenState extends State<AssessmentComparisonScreen> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.progressTracking),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          final history = userProvider.assessmentHistory;

          if (history.isEmpty) {
            return _buildEmptyState(context);
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tab Navigation
                _buildTabNavigation(context),
                const SizedBox(height: 20),

                // Tab Content
                if (_selectedTabIndex == 0)
                  _buildTimelineView(context, history, isSmallScreen)
                else if (_selectedTabIndex == 1)
                  _buildTrendsView(context, history, isSmallScreen)
                else if (_selectedTabIndex == 2)
                  _buildComparisonView(context, history, isSmallScreen)
                else
                  _buildStatsView(context, history, isSmallScreen),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.chart_bar,
              size: 64,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 16),
            Text(
              'No Assessment History',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Complete the Detailed Assessment to start tracking your progress',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabNavigation(BuildContext context) {
    final tabs = [
      ('Timeline', CupertinoIcons.calendar),
      ('Trends', CupertinoIcons.chart_bar_alt_fill),
      ('Comparison', CupertinoIcons.square_compare),
      ('Statistics', CupertinoIcons.info_circle),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = _selectedTabIndex == index;
          return Padding(
            padding: EdgeInsets.only(right: index < tabs.length - 1 ? 8 : 0),
            child: GestureDetector(
              onTap: () => setState(() => _selectedTabIndex = index),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.primaryTeal : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? AppTheme.primaryTeal
                        : Colors.grey[300]!,
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      tabs[index].$2,
                      size: 16,
                      color: isSelected ? Colors.white : Colors.grey[700],
                    ),
                    const SizedBox(width: 6),
                    Text(
                      tabs[index].$1,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : Colors.grey[700],
                          ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildTimelineView(
    BuildContext context,
    List<AssessmentHistory> history,
    bool isSmallScreen,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Assessment History',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        ...List.generate(history.length, (index) {
          final assessment = history[index];
          final topSchema = assessment.schemaScores.entries
              .reduce((a, b) => a.value > b.value ? a : b);
          final schema = SchemaTherapyDatabase.getSchemaById(topSchema.key);

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey[200]!,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[100]!,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: schema?.color.withOpacity(0.2),
                        ),
                        child: Icon(
                          schema?.icon,
                          color: schema?.color,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Assessment #${history.length - index}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[700],
                                  ),
                            ),
                            Text(
                              _formatDate(assessment.completedAt),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: Colors.grey[500],
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: schema?.color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${topSchema.value.toStringAsFixed(1)}/6',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: schema?.color,
                              ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Top Schema: ${schema?.nameEn ?? "Unknown"}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildTrendsView(
    BuildContext context,
    List<AssessmentHistory> history,
    bool isSmallScreen,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Schema Score Trends',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        // Get all unique schemas from history
        ...SchemaTherapyDatabase.allSchemas.take(6).map((schema) {
          final scores = history
              .map((h) => h.schemaScores[schema.id] ?? 0.0)
              .toList();
          final latestScore = scores.isNotEmpty ? scores.last : 0.0;
          final previousScore = scores.length > 1 ? scores[scores.length - 2] : 0.0;
          final trend = latestScore - previousScore;

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey[200]!,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        schema.icon,
                        color: schema.color,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          schema.nameEn,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${latestScore.toStringAsFixed(1)}/6',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: schema.color,
                                ),
                          ),
                          Row(
                            children: [
                              Icon(
                                trend > 0
                                    ? CupertinoIcons.arrow_up
                                    : trend < 0
                                        ? CupertinoIcons.arrow_down
                                        : CupertinoIcons.minus,
                                size: 12,
                                color: trend > 0
                                    ? Colors.red
                                    : trend < 0
                                        ? Colors.green
                                        : Colors.grey,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${trend.abs().toStringAsFixed(1)}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: trend > 0
                                          ? Colors.red
                                          : trend < 0
                                              ? Colors.green
                                              : Colors.grey,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Progress bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: latestScore / 6,
                      minHeight: 6,
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation<Color>(schema.color),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildComparisonView(
    BuildContext context,
    List<AssessmentHistory> history,
    bool isSmallScreen,
  ) {
    if (history.length < 2) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.info_circle,
                size: 48,
                color: Colors.grey[300],
              ),
              const SizedBox(height: 16),
              Text(
                'Need at least 2 assessments',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
            ],
          ),
        ),
      );
    }

    final latest = history.last;
    final previous = history[history.length - 2];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Latest vs Previous Assessment',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        ...SchemaTherapyDatabase.allSchemas.take(6).map((schema) {
          final latestScore = latest.schemaScores[schema.id] ?? 0.0;
          final previousScore = previous.schemaScores[schema.id] ?? 0.0;
          final diff = latestScore - previousScore;

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey[200]!,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    schema.icon,
                    color: schema.color,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          schema.nameEn,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              '${previousScore.toStringAsFixed(1)}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              CupertinoIcons.arrow_right,
                              size: 14,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${latestScore.toStringAsFixed(1)}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: schema.color,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: diff > 0
                          ? Colors.red.withOpacity(0.1)
                          : diff < 0
                              ? Colors.green.withOpacity(0.1)
                              : Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          diff > 0
                              ? CupertinoIcons.arrow_up
                              : diff < 0
                                  ? CupertinoIcons.arrow_down
                                  : CupertinoIcons.minus,
                          size: 12,
                          color: diff > 0
                              ? Colors.red
                              : diff < 0
                                  ? Colors.green
                                  : Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${diff.abs().toStringAsFixed(1)}',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: diff > 0
                                    ? Colors.red
                                    : diff < 0
                                        ? Colors.green
                                        : Colors.grey,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildStatsView(
    BuildContext context,
    List<AssessmentHistory> history,
    bool isSmallScreen,
  ) {
    final latest = history.last;
    final allSchemas = SchemaTherapyDatabase.allSchemas;

    // Calculate statistics
    final avgScore = latest.schemaScores.values.isEmpty
        ? 0.0
        : latest.schemaScores.values.reduce((a, b) => a + b) /
            latest.schemaScores.values.length;

    final topSchema = latest.schemaScores.entries
        .reduce((a, b) => a.value > b.value ? a : b);
    final topSchemaObj = SchemaTherapyDatabase.getSchemaById(topSchema.key);

    final lowestSchema = latest.schemaScores.entries
        .reduce((a, b) => a.value < b.value ? a : b);
    final lowestSchemaObj = SchemaTherapyDatabase.getSchemaById(lowestSchema.key);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Assessment Statistics',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        // Overall stats
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                context,
                'Total Assessments',
                history.length.toString(),
                CupertinoIcons.checkmark_circle,
                AppTheme.primaryTeal,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                context,
                'Average Score',
                avgScore.toStringAsFixed(1),
                CupertinoIcons.chart_bar,
                AppTheme.accentGreen,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Top and lowest schemas
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey[200]!,
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Highest Schema',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    topSchemaObj?.icon,
                    color: topSchemaObj?.color,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      topSchemaObj?.nameEn ?? 'Unknown',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: topSchemaObj?.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${topSchema.value.toStringAsFixed(1)}/6',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: topSchemaObj?.color,
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Lowest Schema',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    lowestSchemaObj?.icon,
                    color: lowestSchemaObj?.color,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      lowestSchemaObj?.nameEn ?? 'Unknown',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: lowestSchemaObj?.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${lowestSchema.value.toStringAsFixed(1)}/6',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: lowestSchemaObj?.color,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final dateOnly = DateTime(date.year, date.month, date.day);

    if (dateOnly == today) {
      return 'Today at ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else if (dateOnly == yesterday) {
      return 'Yesterday at ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

}

