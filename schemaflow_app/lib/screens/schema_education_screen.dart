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
  int _selectedTabIndex = 0;

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
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(schema.nameEn),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Premium Header Section
            _buildPremiumHeader(context, isSmallScreen),

            // Difficulty & Domain Info Cards
            _buildInfoCards(context, isSmallScreen),

            // Tab Navigation
            _buildTabNavigation(context),

            // Tab Content
            _buildTabContent(context, isSmallScreen),
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumHeader(BuildContext context, bool isSmallScreen) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            schema.color,
            schema.color.withOpacity(0.8),
          ],
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(isSmallScreen ? 24 : 32),
            child: Column(
              children: [
                // Large Icon with shadow
                Container(
                  width: isSmallScreen ? 100 : 120,
                  height: isSmallScreen ? 100 : 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.2),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    schema.icon,
                    size: isSmallScreen ? 60 : 70,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                // Schema Name
                Text(
                  schema.nameEn,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                // Domain Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    _getDomainName(schema.domain),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
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

  Widget _buildInfoCards(BuildContext context, bool isSmallScreen) {
    return Padding(
      padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
      child: Row(
        children: [
          Expanded(
            child: _buildInfoCard(
              context,
              'Difficulty to Heal',
              '${schema.difficultyToHeal}/5',
              schema.color,
              Icons.trending_up,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildInfoCard(
              context,
              'Impact Level',
              _getImpactLevel(schema.difficultyToHeal),
              schema.color.withOpacity(0.7),
              Icons.warning_rounded,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    String label,
    String value,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusM),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: color),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabNavigation(BuildContext context) {
    final tabs = ['Overview', 'Origins', 'Effects', 'Healing'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            tabs.length,
            (index) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: () => setState(() => _selectedTabIndex = index),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: _selectedTabIndex == index
                        ? schema.color
                        : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: schema.color.withOpacity(0.3),
                      width: 1.5,
                    ),
                    boxShadow: _selectedTabIndex == index
                        ? [
                            BoxShadow(
                              color: schema.color.withOpacity(0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : [],
                  ),
                  child: Text(
                    tabs[index],
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: _selectedTabIndex == index
                              ? Colors.white
                              : Colors.grey[700],
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent(BuildContext context, bool isSmallScreen) {
    return Padding(
      padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
      child: Column(
        children: [
          if (_selectedTabIndex == 0) _buildOverviewTab(context),
          if (_selectedTabIndex == 1) _buildOriginsTab(context),
          if (_selectedTabIndex == 2) _buildEffectsTab(context),
          if (_selectedTabIndex == 3) _buildHealingTab(context),
        ],
      ),
    );
  }

  Widget _buildOverviewTab(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildContentCard(
          context,
          'What is ${schema.nameEn}?',
          schema.descriptionEn,
          schema.color,
        ),
      ],
    );
  }

  Widget _buildOriginsTab(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildContentCard(
          context,
          'Childhood Origins',
          schema.childhoodOriginEn,
          schema.color,
        ),
      ],
    );
  }

  Widget _buildEffectsTab(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'How This Schema Affects You',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
        ),
        const SizedBox(height: 16),
        ...schema.effectsEn.asMap().entries.map((entry) {
          final index = entry.key;
          final effect = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppTheme.radiusM),
                border: Border.all(
                  color: schema.color.withOpacity(0.2),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: schema.color.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: schema.color.withOpacity(0.15),
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: schema.color,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      effect,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            height: 1.6,
                            color: Colors.grey[700],
                          ),
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

  Widget _buildHealingTab(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildContentCard(
          context,
          'Path to Healing',
          schema.healingApproachEn,
          schema.color,
        ),
      ],
    );
  }

  Widget _buildContentCard(
    BuildContext context,
    String title,
    String content,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusM),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.8,
                  color: Colors.grey[700],
                  fontSize: 15,
                ),
          ),
        ],
      ),
    );
  }

  String _getDomainName(SchemaDomain domain) {
    switch (domain) {
      case SchemaDomain.disconnectionRejection:
        return 'Disconnection & Rejection';
      case SchemaDomain.impairedAutonomy:
        return 'Impaired Autonomy';
      case SchemaDomain.impairedLimits:
        return 'Impaired Limits';
      case SchemaDomain.otherDirectedness:
        return 'Other-Directedness';
      case SchemaDomain.overVigilanceInhibition:
        return 'Over-vigilance & Inhibition';
    }
  }

  String _getImpactLevel(int difficulty) {
    if (difficulty <= 2) return 'Low';
    if (difficulty <= 3) return 'Medium';
    if (difficulty <= 4) return 'High';
    return 'Very High';
  }
}

