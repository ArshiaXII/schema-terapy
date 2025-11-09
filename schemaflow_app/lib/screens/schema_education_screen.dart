import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../core/theme/app_theme.dart';
import '../l10n/app_localizations.dart';
import '../models/schema_therapy_data.dart';

/// Schema Education Screen - Detailed information about each schema
class SchemaEducationScreen extends StatefulWidget {
  final int schemaId;

  const SchemaEducationScreen({
    super.key,
    required this.schemaId,
  });

  @override
  State<SchemaEducationScreen> createState() => _SchemaEducationScreenState();
}

class _SchemaEducationScreenState extends State<SchemaEducationScreen> {
  late SchemaTherapySchema schema;

  @override
  void initState() {
    super.initState();
    schema = SchemaTherapyDatabase.getSchemaById(widget.schemaId) ??
        SchemaTherapyDatabase.allSchemas.first;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: Text(schema.nameEn),
        backgroundColor: schema.color,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with icon and color
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(isSmallScreen ? 20 : 30),
              decoration: BoxDecoration(
                color: schema.color,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    schema.icon,
                    size: isSmallScreen ? 60 : 80,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    schema.nameEn,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Difficulty: ${schema.difficultyToHeal}/5',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white70,
                        ),
                  ),
                ],
              ),
            ),
            // Content sections
            Padding(
              padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Description
                  _buildSection(
                    context,
                    'Description',
                    schema.descriptionEn,
                  ),
                  const SizedBox(height: 24),
                  // Childhood Origins
                  _buildSection(
                    context,
                    'Childhood Origins',
                    schema.childhoodOriginEn,
                  ),
                  const SizedBox(height: 24),
                  // Effects
                  _buildEffectsList(context, schema.effectsEn),
                  const SizedBox(height: 24),
                  // Healing Approach
                  _buildSection(
                    context,
                    'Healing Approach',
                    schema.healingApproachEn,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryTeal,
              ),
        ),
        const SizedBox(height: 12),
        Text(
          content,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                height: 1.6,
                color: Colors.grey[700],
              ),
        ),
      ],
    );
  }

  Widget _buildEffectsList(BuildContext context, List<String> effects) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Effects',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryTeal,
              ),
        ),
        const SizedBox(height: 12),
        ...effects.map((effect) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: schema.color,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      effect,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            height: 1.5,
                            color: Colors.grey[700],
                          ),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}

