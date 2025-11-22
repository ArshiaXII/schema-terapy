import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_theme.dart';
import '../core/providers/user_provider.dart';
import '../l10n/app_localizations.dart';
import '../widgets/page_transitions.dart';
import '../widgets/animated_feature_card.dart';
import 'questionnaire_screen.dart';
import 'results_screen.dart';
import 'user_profile_screen.dart';
import 'premium_questionnaire_screen.dart';
import 'schema_education_screen.dart';
import 'assessment_comparison_screen.dart';
import 'therapy_recommendations_screen.dart';
import 'schema_chat_screen.dart';
import '../models/schema_therapy_data.dart';

/// Home screen - main dashboard after login
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOut),
      ),
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
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppTheme.spacingL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome section
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: _buildWelcomeSection(),
                ),
                
                const SizedBox(height: AppTheme.spacingXL),
                
                // Main action card
                SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: _buildMainActionCard(),
                  ),
                ),
                
                const SizedBox(height: AppTheme.spacingXL),
                
                // Quick stats or features
                SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: _buildQuickStats(),
                  ),
                ),
                
                const SizedBox(height: AppTheme.spacingXL),
                
                // Past reports section
                SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: _buildPastReportsSection(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              CupertinoIcons.person_crop_circle_badge_checkmark,
              size: 18,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: AppTheme.spacingS),
          Text(
            AppLocalizations.of(context)!.appTitle,
            style: AppTheme.titleLarge.copyWith(
              color: AppTheme.primaryTeal,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const UserProfileScreen(),
              ),
            );
          },
          icon: const Icon(
            CupertinoIcons.person_circle,
            color: AppTheme.primaryTeal,
          ),
        ),
      ],
    );
  }

  Widget _buildWelcomeSection() {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        final user = userProvider.currentUser;
        final l = AppLocalizations.of(context)!;
        final firstName = user?.name.split(' ').first ?? l.userDefaultName;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting with gradient text
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [AppTheme.primaryTeal, AppTheme.accentGreen],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: Text(
                l.greetingHello(firstName),
                style: AppTheme.displayMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spacingM),
            // Subtitle with better styling
            Row(
              children: [
                Container(
                  width: 4,
                  height: 24,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppTheme.primaryTeal, AppTheme.accentGreen],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: AppTheme.spacingM),
                Expanded(
                  child: Text(
                    l.homeExplorePrompt,
                    style: AppTheme.bodyLarge.copyWith(
                      color: AppTheme.textSecondary,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildMainActionCard() {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        final hasCompleted = userProvider.hasCompletedQuestionnaire;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppTheme.spacingXL),
          decoration: BoxDecoration(
            gradient: hasCompleted
                ? const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF5DB075), Color(0xFF7BC88A)],
                  )
                : AppTheme.primaryGradient,
            borderRadius: BorderRadius.circular(AppTheme.radiusL),
            boxShadow: [
              BoxShadow(
                color: hasCompleted
                    ? const Color(0xFF5DB075).withOpacity(0.4)
                    : AppTheme.primaryTeal.withOpacity(0.4),
                blurRadius: 30,
                spreadRadius: 2,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          child: Column(
            children: [
              // Animated icon container
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.15),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: Icon(
                  hasCompleted
                      ? CupertinoIcons.doc_text_search
                      : CupertinoIcons.play_circle,
                  size: 40,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: AppTheme.spacingXL),

              Text(
                hasCompleted
                    ? AppLocalizations.of(context)!.analysisReady
                    : AppLocalizations.of(context)!.analysisAwaits,
                style: AppTheme.headlineMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppTheme.spacingM),

              Text(
                hasCompleted
                    ? AppLocalizations.of(context)!.homeCompletedDescription
                    : AppLocalizations.of(context)!.homePromptDescription,
                style: AppTheme.bodyMedium.copyWith(
                  color: Colors.white.withOpacity(0.85),
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppTheme.spacingXL),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (hasCompleted) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ResultsScreen(),
                        ),
                      );
                    } else {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const QuestionnaireScreen(),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: hasCompleted
                        ? AppTheme.accentGreen
                        : AppTheme.primaryTeal,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      vertical: AppTheme.spacingL,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppTheme.radiusM),
                    ),
                  ),
                  child: Text(
                    hasCompleted ? AppLocalizations.of(context)!.viewResults : AppLocalizations.of(context)!.beginQuestionnaire,
                    style: AppTheme.titleMedium.copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildQuickStats() {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        return Row(
          children: [
            Expanded(
              child: _buildStatCard(
                icon: CupertinoIcons.chart_bar_circle,
                title: AppLocalizations.of(context)!.progress,
                value: userProvider.hasCompletedQuestionnaire ? '100%' : '0%',
                color: AppTheme.accentGreen,
              ),
            ),
            const SizedBox(width: AppTheme.spacingM),
            Expanded(
              child: _buildStatCard(
                icon: CupertinoIcons.star_circle,
                title: AppLocalizations.of(context)!.status,
                value: userProvider.isPremium ? AppLocalizations.of(context)!.premium : AppLocalizations.of(context)!.free,
                color: userProvider.isPremium 
                    ? AppTheme.warningOrange 
                    : AppTheme.textSecondary,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingL),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withOpacity(0.08),
            color.withOpacity(0.03),
          ],
        ),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(AppTheme.radiusM),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withOpacity(0.15),
              border: Border.all(
                color: color.withOpacity(0.3),
                width: 1.5,
              ),
            ),
            child: Icon(
              icon,
              size: 24,
              color: color,
            ),
          ),
          const SizedBox(height: AppTheme.spacingM),
          Text(
            value,
            style: AppTheme.titleLarge.copyWith(
              color: color,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: AppTheme.spacingXS),
          Text(
            title,
            style: AppTheme.bodySmall.copyWith(
              color: AppTheme.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPastReportsSection() {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.yourJourney,
              style: AppTheme.headlineMedium,
            ),
            const SizedBox(height: AppTheme.spacingL),
            
            if (userProvider.hasCompletedQuestionnaire) ...[
              _buildReportCard(
                title: AppLocalizations.of(context)!.schemaAnalysisReport,
                subtitle: AppLocalizations.of(context)!.completedToday,
                icon: CupertinoIcons.doc_text_search,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ResultsScreen(),
                    ),
                  );
                },
              ),
            ] else ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppTheme.spacingXL),
                decoration: AppTheme.cardDecoration,
                child: Column(
                  children: [
                    Icon(
                      CupertinoIcons.doc_text,
                      size: 48,
                      color: AppTheme.textTertiary.withOpacity(0.5),
                    ),
                    const SizedBox(height: AppTheme.spacingL),
                    Text(
                      AppLocalizations.of(context)!.noReportsYet,
                      style: AppTheme.titleMedium.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingS),
                    Text(
                      AppLocalizations.of(context)!.completeFirstQuestionnaire,
                      style: AppTheme.bodyMedium.copyWith(
                        color: AppTheme.textTertiary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],

            // Premium Features Section
            if (userProvider.isPremium) ...[
              const SizedBox(height: AppTheme.spacingXL),
              Text(
                AppLocalizations.of(context)!.premiumFeatures,
                style: AppTheme.headlineMedium,
              ),
              const SizedBox(height: AppTheme.spacingL),
              _buildPremiumFeaturesGrid(context),
            ],
          ],
        );
      },
    );
  }

  Widget _buildPremiumFeaturesGrid(BuildContext context) {
    final userProvider = context.read<UserProvider>();
    final premiumResult = userProvider.premiumQuestionnaireResult;
    final l10n = AppLocalizations.of(context)!;

    final features = [
      {
        'title': l10n.detailedAssessmentTitle,
        'subtitle': l10n.detailedAssessmentSubtitle,
        'color': AppTheme.primaryTeal,
        'icon': CupertinoIcons.doc_text_search,
        'delayMs': 0,
        'onTap': () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const PremiumQuestionnaireScreen(),
            ),
          );
        },
      },
      {
        'title': l10n.schemaEducationTitle,
        'subtitle': l10n.schemaEducationSubtitle,
        'color': AppTheme.accentGreen,
        'icon': CupertinoIcons.book,
        'delayMs': 100,
        'onTap': () {
          Navigator.of(context).push(
            FadePageRoute(
              builder: (context) => const SchemaEducationScreen(schemaId: 1),
            ),
          );
        },
      },
      {
        'title': l10n.progressTrackingTitle,
        'subtitle': l10n.progressTrackingSubtitle,
        'color': AppTheme.warningOrange,
        'icon': CupertinoIcons.chart_bar,
        'delayMs': 200,
        'onTap': () {
          Navigator.of(context).push(
            SlidePageRoute(
              builder: (context) => const AssessmentComparisonScreen(),
            ),
          );
        },
      },
      {
        'title': l10n.recommendationsTitle,
        'subtitle': l10n.recommendationsSubtitle,
        'color': Colors.purple,
        'icon': CupertinoIcons.lightbulb,
        'delayMs': 300,
        'onTap': () {
          if (premiumResult != null) {
            Navigator.of(context).push(
              SlidePageRoute(
                builder: (context) => TherapyRecommendationsScreen(
                  schemaScores: premiumResult.schemaScores,
                ),
              ),
            );
          }
        },
      },
      {
        'title': l10n.schemaChatTitle,
        'subtitle': l10n.schemaChatSubtitle,
        'color': Colors.blue,
        'icon': CupertinoIcons.chat_bubble_text,
        'delayMs': 400,
        'onTap': () {
          if (premiumResult != null && premiumResult.schemaScores.isNotEmpty) {
            // Get the dominant schema
            final dominantSchemaId = premiumResult.schemaScores.entries
                .reduce((a, b) => a.value > b.value ? a : b)
                .key;
            final schema = SchemaTherapyDatabase.getSchemaById(dominantSchemaId);

            if (schema != null) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SchemaChatScreen(
                    schema: schema,
                    schemaScores: premiumResult.schemaScores,
                  ),
                ),
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(l10n.completeDetailedAssessmentFirst),
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
      },
    ];

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: AppTheme.spacingM,
      crossAxisSpacing: AppTheme.spacingM,
      childAspectRatio: 1.0,
      children: List.generate(features.length, (index) {
        final feature = features[index];
        return AnimatedFeatureCard(
          title: feature['title'] as String,
          subtitle: feature['subtitle'] as String,
          color: feature['color'] as Color,
          icon: feature['icon'] as IconData,
          delayMs: feature['delayMs'] as int,
          onTap: feature['onTap'] as VoidCallback,
        );
      }),
    );
  }



  Widget _buildReportCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingM),
      decoration: AppTheme.cardDecoration,
      child: ListTile(
        contentPadding: const EdgeInsets.all(AppTheme.spacingL),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppTheme.primaryTeal.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppTheme.radiusM),
          ),
          child: Icon(
            icon,
            color: AppTheme.primaryTeal,
          ),
        ),
        title: Text(
          title,
          style: AppTheme.titleMedium,
        ),
        subtitle: Text(
          subtitle,
          style: AppTheme.bodySmall.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
        trailing: const Icon(
          CupertinoIcons.chevron_right,
          color: AppTheme.textTertiary,
        ),
        onTap: onTap,
      ),
    );
  }
}
