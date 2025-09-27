import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_theme.dart';
import '../l10n/app_localizations.dart';

import '../core/providers/user_provider.dart';
import 'chat_screen.dart';

/// Results screen showing detailed schema analysis
class ResultsScreen extends StatefulWidget {
  final String? dominantSchema;
  final String? fullAnalysisText;

  const ResultsScreen({
    super.key,
    this.dominantSchema,
    this.fullAnalysisText,
  });

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Mock schema results - replace with actual data from API
  final List<SchemaResult> _schemaResults = [
    SchemaResult(
      name: 'Perfectionism/Unrelenting Standards',
      score: 5.2,
      severity: SchemaSeverity.high,
      icon: CupertinoIcons.star_circle,
      overview: '''
You have very high standards for yourself and others. You believe that whatever you do must be perfect or near-perfect, and you have difficulty accepting "good enough." This schema often develops in childhood when parents set extremely high expectations.
      ''',
      effects: '''
• Chronic stress and anxiety about performance
• Difficulty completing tasks due to perfectionist paralysis
• Strained relationships due to high expectations of others
• Burnout from overworking and never feeling satisfied
• Procrastination when tasks seem too overwhelming
      ''',
      nextSteps: '''
• Practice setting "good enough" standards for less important tasks
• Challenge all-or-nothing thinking patterns
• Learn to celebrate progress rather than only perfection
• Set realistic deadlines and stick to them
• Practice self-compassion when you make mistakes
      ''',
    ),
    SchemaResult(
      name: 'Abandonment/Instability',
      score: 4.8,
      severity: SchemaSeverity.high,
      icon: CupertinoIcons.heart_slash,
      overview: '''
You have a persistent fear that people you care about will leave you or that relationships are inherently unstable. This creates anxiety in close relationships and may lead to clingy or avoidant behaviors.
      ''',
      effects: '''
• Intense fear when loved ones are unavailable
• Jealousy and possessiveness in relationships
• Difficulty trusting that relationships will last
• Either clinging too tightly or pushing people away
• Constant need for reassurance from partners
      ''',
      nextSteps: '''
• Work on building secure attachment patterns
• Practice tolerating uncertainty in relationships
• Develop a support network beyond one primary person
• Learn to self-soothe when feeling abandoned
• Communicate your needs clearly rather than testing relationships
      ''',
    ),
    SchemaResult(
      name: 'Defectiveness/Shame',
      score: 3.4,
      severity: SchemaSeverity.moderate,
      icon: CupertinoIcons.person_badge_minus,
      overview: '''
You sometimes feel that you are fundamentally flawed or defective in some way. This can lead to shame, self-criticism, and a belief that you are unworthy of love if others truly knew you.
      ''',
      effects: '''
• Persistent feelings of shame and inadequacy
• Hiding your "true self" from others
• Self-sabotage in relationships and opportunities
• Difficulty accepting compliments or positive feedback
• Comparing yourself unfavorably to others
      ''',
      nextSteps: '''
• Practice self-compassion and challenge inner critic
• Share vulnerabilities with trusted friends or therapist
• Keep a daily log of positive qualities and achievements
• Work on accepting all parts of yourself, including flaws
• Engage in activities that make you feel competent and valued
      ''',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        child: CustomScrollView(
          slivers: [
            // Profile summary
            SliverToBoxAdapter(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: _buildProfileSummary(),
              ),
            ),

            // Schema results
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: _buildSchemaCard(_schemaResults[index]),
                    ),
                  );
                },
                childCount: _schemaResults.length,
              ),
            ),

            // Bottom spacing
            const SliverToBoxAdapter(
              child: SizedBox(height: AppTheme.spacingXXL),
            ),
          ],
        ),
      ),
      floatingActionButton: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          if (!userProvider.canUseChatFeature) return const SizedBox.shrink();

          return FloatingActionButton.extended(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ChatScreen(),
                ),
              );
            },
            backgroundColor: AppTheme.primaryTeal,
            foregroundColor: Colors.white,
            icon: const Icon(CupertinoIcons.chat_bubble_2),
            label: Text(AppLocalizations.of(context)!.resultsFabChatWithAi),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        AppLocalizations.of(context)!.resultsAppBarTitle,
        style: AppTheme.titleLarge,
      ),
      actions: [
        IconButton(
          onPressed: () {
            // TODO: Implement share functionality
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(AppLocalizations.of(context)!.resultsShareSoon)),
            );
          },
          icon: const Icon(CupertinoIcons.share),
        ),
      ],
    );
  }

  Widget _buildProfileSummary() {
    return Container(
      margin: const EdgeInsets.all(AppTheme.spacingL),
      padding: const EdgeInsets.all(AppTheme.spacingXL),
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.circular(AppTheme.radiusL),
        boxShadow: AppTheme.shadowMedium,
      ),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              CupertinoIcons.person_crop_circle_badge_checkmark,
              size: 40,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: AppTheme.spacingL),

          Text(
            AppLocalizations.of(context)!.resultsProfileTitle,
            style: AppTheme.headlineLarge.copyWith(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: AppTheme.spacingS),

          Text(
            AppLocalizations.of(context)!.resultsProfileSubtitle,
            style: AppTheme.bodyLarge.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: AppTheme.spacingL),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingL,
              vertical: AppTheme.spacingS,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(AppTheme.radiusM),
            ),
            child: Text(
              AppLocalizations.of(context)!.resultsCompletedToday,
              style: AppTheme.bodyMedium.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSchemaCard(SchemaResult schema) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingL,
        vertical: AppTheme.spacingS,
      ),
      decoration: AppTheme.elevatedCardDecoration,
      child: ExpansionTile(
        tilePadding: const EdgeInsets.all(AppTheme.spacingL),
        childrenPadding: const EdgeInsets.only(
          left: AppTheme.spacingL,
          right: AppTheme.spacingL,
          bottom: AppTheme.spacingL,
        ),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: _getSeverityColor(schema.severity).withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppTheme.radiusM),
          ),
          child: Icon(
            schema.icon,
            color: _getSeverityColor(schema.severity),
            size: 24,
          ),
        ),
        title: Text(
          schema.name,
          style: AppTheme.titleMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppTheme.spacingS),
            Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.resultsScoreLabel(schema.score),
                  style: AppTheme.bodySmall.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
                const SizedBox(width: AppTheme.spacingS),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.spacingS,
                    vertical: AppTheme.spacingXS,
                  ),
                  decoration: BoxDecoration(
                    color: _getSeverityColor(schema.severity).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radiusS),
                  ),
                  child: Text(
                    _getSeverityText(schema.severity),
                    style: AppTheme.labelSmall.copyWith(
                      color: _getSeverityColor(schema.severity),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        children: [
          _buildSchemaSection(AppLocalizations.of(context)!.resultsSectionOverview, schema.overview),
          _buildSchemaSection(AppLocalizations.of(context)!.resultsSectionEffects, schema.effects),
          _buildSchemaSection(AppLocalizations.of(context)!.resultsSectionNextSteps, schema.nextSteps),
        ],
      ),
    );
  }

  Widget _buildSchemaSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppTheme.spacingL),
        Text(
          title,
          style: AppTheme.titleMedium.copyWith(
            color: AppTheme.primaryTeal,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppTheme.spacingS),
        Text(
          content.trim(),
          style: AppTheme.bodyMedium.copyWith(
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Color _getSeverityColor(SchemaSeverity severity) {
    switch (severity) {
      case SchemaSeverity.low:
        return AppTheme.accentGreen;
      case SchemaSeverity.moderate:
        return AppTheme.warningOrange;
      case SchemaSeverity.high:
        return AppTheme.errorRed;
    }
  }

  String _getSeverityText(SchemaSeverity severity) {
    final l10n = AppLocalizations.of(context)!;
    switch (severity) {
      case SchemaSeverity.low:
        return l10n.resultsSeverityLow;
      case SchemaSeverity.moderate:
        return l10n.resultsSeverityModerate;
      case SchemaSeverity.high:
        return l10n.resultsSeverityHigh;
    }
  }
}

/// Enum for schema severity levels
enum SchemaSeverity { low, moderate, high }

/// Data model for schema results
class SchemaResult {
  final String name;
  final double score;
  final SchemaSeverity severity;
  final IconData icon;
  final String overview;
  final String effects;
  final String nextSteps;

  const SchemaResult({
    required this.name,
    required this.score,
    required this.severity,
    required this.icon,
    required this.overview,
    required this.effects,
    required this.nextSteps,
  });
}
