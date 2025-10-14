import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_theme.dart';
import '../core/providers/user_provider.dart';
import '../l10n/app_localizations.dart';
import '../services/revenuecat_service.dart';

import 'results_screen.dart';

/// Analysis feature model for pay-per-analysis paywall
class AnalysisFeature {
  final IconData icon;
  final String title;
  final String description;

  const AnalysisFeature({
    required this.icon,
    required this.title,
    required this.description,
  });
}

/// Paywall screen for pay-per-analysis purchase
/// Shows the one-time purchase option for the full analysis report
class PaywallScreen extends StatefulWidget {
  final String? dominantSchema;
  final String? fullAnalysisText;

  const PaywallScreen({
    super.key,
    this.dominantSchema,
    this.fullAnalysisText,
  });

  @override
  State<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends State<PaywallScreen>
    with TickerProviderStateMixin {
  bool _isPurchasing = false;
  SubscriptionType _selectedPlan = SubscriptionType.none; // Default to one-time purchase

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<AnalysisFeature> _features = [
    AnalysisFeature(
      icon: CupertinoIcons.doc_text_search,
      title: 'Complete Schema Analysis',
      description: 'Full detailed report on your dominant psychological pattern',
    ),
    AnalysisFeature(
      icon: CupertinoIcons.heart_circle,
      title: 'Relationship Impact Assessment',
      description: 'How your schema affects your relationships and connections',
    ),
    AnalysisFeature(
      icon: CupertinoIcons.clock_fill,
      title: 'Origins & Development',
      description: 'Understanding how this pattern formed in your past',
    ),
    AnalysisFeature(
      icon: CupertinoIcons.lightbulb,
      title: 'Personalized Growth Strategies',
      description: 'Specific steps and exercises for healing and growth',
    ),
    AnalysisFeature(
      icon: CupertinoIcons.chat_bubble_2,
      title: 'AI Chat Session',
      description: 'Discuss your results with our AI therapist for deeper insights',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
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

  Future<void> _purchaseAnalysis() async {
    setState(() => _isPurchasing = true);
    try {
      // Check if already unlocked
      final alreadyUnlocked = await RevenueCatService.instance.hasEntitlement();
      if (!mounted) return;

      if (alreadyUnlocked) {
        // Already has access, navigate to results
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ResultsScreen(
              dominantSchema: widget.dominantSchema,
              fullAnalysisText: widget.fullAnalysisText,
            ),
          ),
        );
        return;
      }

      // Show message that purchase should be done through App Store
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.paywallPurchaseNote),
          backgroundColor: AppTheme.primaryNavy,
          duration: const Duration(seconds: 3),
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${AppLocalizations.of(context)!.paywallPurchaseFailedPrefix}$e'),
            backgroundColor: AppTheme.errorRed,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isPurchasing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(CupertinoIcons.xmark),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppTheme.spacingL),
            child: Column(
              children: [
                // Header
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: _buildHeader(),
                ),

                const SizedBox(height: AppTheme.spacingXL),

                // Features list
                SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: _buildFeaturesList(),
                  ),
                ),

                const SizedBox(height: AppTheme.spacingXL),

                // Purchase summary
                SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: _buildPurchaseSummary(),
                  ),
                ),

                const SizedBox(height: AppTheme.spacingXL),

                // Purchase button
                SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: _buildPurchaseButton(),
                  ),
                ),

                const SizedBox(height: AppTheme.spacingL),

                // Restore purchase
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: _buildRestorePurchase(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
            ),
            shape: BoxShape.circle,
            boxShadow: AppTheme.shadowMedium,
          ),
          child: const Icon(
            CupertinoIcons.star_circle,
            size: 40,
            color: Colors.white,
          ),
        ),

        const SizedBox(height: AppTheme.spacingL),

        Text(
          AppLocalizations.of(context)!.paywallHeaderTitle,
          style: AppTheme.displayMedium,
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: AppTheme.spacingS),

        Text(
          AppLocalizations.of(context)!.paywallHeaderSubtitle,
          style: AppTheme.bodyLarge.copyWith(
            color: AppTheme.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildFeaturesList() {
    final l10n = AppLocalizations.of(context)!;
    final features = [
      AnalysisFeature(
        icon: CupertinoIcons.doc_text_search,
        title: l10n.paywallFeatureCompleteTitle,
        description: l10n.paywallFeatureCompleteDesc,
      ),
      AnalysisFeature(
        icon: CupertinoIcons.heart_circle,
        title: l10n.paywallFeatureRelationshipTitle,
        description: l10n.paywallFeatureRelationshipDesc,
      ),
      AnalysisFeature(
        icon: CupertinoIcons.clock_fill,
        title: l10n.paywallFeatureOriginsTitle,
        description: l10n.paywallFeatureOriginsDesc,
      ),
      AnalysisFeature(
        icon: CupertinoIcons.lightbulb,
        title: l10n.paywallFeatureGrowthTitle,
        description: l10n.paywallFeatureGrowthDesc,
      ),
      AnalysisFeature(
        icon: CupertinoIcons.chat_bubble_2,
        title: l10n.paywallFeatureAiChatTitle,
        description: l10n.paywallFeatureAiChatDesc,
      ),
    ];
    return Column(
      children: features.map((feature) => _buildFeatureItem(feature)).toList(),
    );
  }

  Widget _buildFeatureItem(AnalysisFeature feature) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingM),
      padding: const EdgeInsets.all(AppTheme.spacingL),
      decoration: AppTheme.cardDecoration,
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppTheme.accentGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusM),
            ),
            child: Icon(
              CupertinoIcons.checkmark_circle_fill,
              color: AppTheme.accentGreen,
              size: 24,
            ),
          ),

          const SizedBox(width: AppTheme.spacingL),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  feature.title,
                  style: AppTheme.titleMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingXS),
                Text(
                  feature.description,
                  style: AppTheme.bodyMedium.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPurchaseSummary() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingL),
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
          color: AppTheme.primaryTeal.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppTheme.spacingS),
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(AppTheme.radiusM),
                ),
                child: const Icon(
                  CupertinoIcons.doc_text_search,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: AppTheme.spacingM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.paywallSummaryTitle,
                      style: AppTheme.headlineMedium,
                    ),
                    const SizedBox(height: AppTheme.spacingXS),
                    Text(
                      AppLocalizations.of(context)!.paywallSummarySubtitle,
                      style: AppTheme.bodyMedium.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                AppLocalizations.of(context)!.paywallPrice,
                style: AppTheme.headlineLarge.copyWith(
                  color: AppTheme.primaryTeal,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppTheme.spacingL),

          Container(
            padding: const EdgeInsets.all(AppTheme.spacingM),
            decoration: BoxDecoration(
              color: AppTheme.backgroundCard,
              borderRadius: BorderRadius.circular(AppTheme.radiusM),
            ),
            child: Row(
              children: [
                const Icon(
                  CupertinoIcons.info_circle_fill,
                  color: AppTheme.accentGreen,
                  size: 16,
                ),
                const SizedBox(width: AppTheme.spacingS),
                Expanded(
                  child: Text(
                    AppLocalizations.of(context)!.paywallSummaryNote,
                    style: AppTheme.bodySmall.copyWith(
                      color: AppTheme.textSecondary,
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

  Widget _buildPlanCard({
    required SubscriptionType type,
    required String title,
    required String price,
    required String period,
    String? savings,
    bool isRecommended = false,
  }) {
    final isSelected = _selectedPlan == type;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPlan = type;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(AppTheme.spacingL),
        decoration: BoxDecoration(
          color: AppTheme.backgroundCard,
          borderRadius: BorderRadius.circular(AppTheme.radiusL),
          border: Border.all(
            color: isSelected
                ? AppTheme.primaryTeal
                : AppTheme.textTertiary.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected ? AppTheme.shadowMedium : AppTheme.shadowLight,
        ),
        child: Stack(
          children: [
            // Recommended badge
            if (isRecommended)
              Positioned(
                top: -8,
                right: -8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.spacingS,
                    vertical: AppTheme.spacingXS,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.warningOrange,
                    borderRadius: BorderRadius.circular(AppTheme.radiusS),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.paywallRecommendedBadge,
                    style: AppTheme.labelSmall.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

            Row(
              children: [
                // Selection indicator
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? AppTheme.primaryTeal
                          : AppTheme.textTertiary,
                      width: 2,
                    ),
                    color: isSelected ? AppTheme.primaryTeal : Colors.transparent,
                  ),
                  child: isSelected
                      ? const Icon(
                          CupertinoIcons.checkmark,
                          size: 16,
                          color: Colors.white,
                        )
                      : null,
                ),

                const SizedBox(width: AppTheme.spacingL),

                // Plan details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            title,
                            style: AppTheme.titleMedium.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (savings != null) ...[
                            const SizedBox(width: AppTheme.spacingS),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppTheme.spacingS,
                                vertical: AppTheme.spacingXS,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.accentGreen.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(AppTheme.radiusS),
                              ),
                              child: Text(
                                savings,
                                style: AppTheme.labelSmall.copyWith(
                                  color: AppTheme.accentGreen,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: AppTheme.spacingXS),
                      Row(
                        children: [
                          Text(
                            price,
                            style: AppTheme.headlineMedium.copyWith(
                              color: AppTheme.primaryTeal,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: AppTheme.spacingXS),
                          Text(
                            period,
                            style: AppTheme.bodyMedium.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPurchaseButton() {
    return SizedBox(
      width: double.infinity,
      height: 64,
      child: ElevatedButton(
        onPressed: _isPurchasing ? null : _purchaseAnalysis,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryTeal,
          foregroundColor: Colors.white,
          elevation: 8,
          shadowColor: AppTheme.primaryTeal.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusL),
          ),
        ),
        child: _isPurchasing
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    CupertinoIcons.creditcard_fill,
                    size: 20,
                  ),
                  const SizedBox(width: AppTheme.spacingS),
                  Flexible(
                    child: Text(
                      AppLocalizations.of(context)!.paywallConfirmCta,
                      style: AppTheme.titleMedium.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildRestorePurchase() {
    return TextButton(
      onPressed: () async {
        final restored = await RevenueCatService.instance.restorePurchasesAndCheck();
        if (!mounted) return;
        if (restored) {
          // Optionally navigate directly to results if entitlement now active
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => ResultsScreen(
                dominantSchema: widget.dominantSchema,
                fullAnalysisText: widget.fullAnalysisText,
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context)!.paywallRestoreSoon)),
          );
        }
      },
      style: AppTheme.textButtonStyle,
      child: Text(
        AppLocalizations.of(context)!.paywallRestorePurchase,
        style: AppTheme.bodyMedium.copyWith(
          color: AppTheme.textSecondary,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}


