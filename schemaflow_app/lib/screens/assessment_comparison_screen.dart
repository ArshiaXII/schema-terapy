import 'package:flutter/material.dart';
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
  late UserProvider userProvider;
  int selectedSchemaId = 1;

  @override
  void initState() {
    super.initState();
    // In a real app, get userProvider from context
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Assessment Progress'),
        backgroundColor: AppTheme.primaryTeal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Timeline of assessments
              Text(
                'Your Assessment History',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              // Assessment timeline
              _buildAssessmentTimeline(context),
              const SizedBox(height: 32),
              // Schema comparison chart
              Text(
                'Schema Score Trends',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              _buildSchemaComparison(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAssessmentTimeline(BuildContext context) {
    // This would be populated from userProvider.assessmentHistory
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            'No assessment history yet',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Complete assessments to see your progress over time',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[500],
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildSchemaComparison(BuildContext context) {
    final schemas = SchemaTherapyDatabase.allSchemas;

    return Column(
      children: schemas.take(5).map((schema) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      schema.nameEn,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  Text(
                    '3.5/6.0',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: 3.5 / 6.0,
                  minHeight: 8,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(schema.color),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

