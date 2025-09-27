import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_theme.dart';
import '../core/providers/user_provider.dart';
import '../l10n/app_localizations.dart';
import 'questionnaire_screen.dart';
import 'results_screen.dart';
import 'user_profile_screen.dart';

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
            Text(
              l.greetingHello(firstName),
              style: AppTheme.displayMedium,
            ),
            const SizedBox(height: AppTheme.spacingS),
            Text(
              l.homeExplorePrompt,
              style: AppTheme.bodyLarge.copyWith(
                color: AppTheme.textSecondary,
              ),
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
            boxShadow: AppTheme.shadowMedium,
          ),
          child: Column(
            children: [
              Icon(
                hasCompleted 
                    ? CupertinoIcons.doc_text_search 
                    : CupertinoIcons.play_circle,
                size: 48,
                color: Colors.white,
              ),
              
              const SizedBox(height: AppTheme.spacingL),
              
              Text(
                hasCompleted
                    ? AppLocalizations.of(context)!.analysisReady
                    : AppLocalizations.of(context)!.analysisAwaits,
                style: AppTheme.headlineMedium.copyWith(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: AppTheme.spacingS),
              
              Text(
                hasCompleted
                    ? AppLocalizations.of(context)!.homeCompletedDescription
                    : AppLocalizations.of(context)!.homePromptDescription,
                style: AppTheme.bodyMedium.copyWith(
                  color: Colors.white.withOpacity(0.9),
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
                      fontWeight: FontWeight.w600,
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
      decoration: AppTheme.cardDecoration,
      child: Column(
        children: [
          Icon(
            icon,
            size: 32,
            color: color,
          ),
          const SizedBox(height: AppTheme.spacingS),
          Text(
            value,
            style: AppTheme.titleLarge.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: AppTheme.bodySmall.copyWith(
              color: AppTheme.textSecondary,
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
          ],
        );
      },
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
