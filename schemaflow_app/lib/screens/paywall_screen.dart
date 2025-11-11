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

class _PaywallScreenState extends State<PaywallScreen> {
  bool _isPurchasing = false;
  SubscriptionType _selectedPlan = SubscriptionType.none; // Default to one-time purchase

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
  void dispose() {
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

      // Get available packages
      final packages = await RevenueCatService.instance.getPackages();
      if (!mounted) return;

      if (packages.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.paywallNoPurchaseAvailable),
            backgroundColor: AppTheme.warningOrange,
          ),
        );
        return;
      }

      // Find the one-time purchase package (first available)
      final package = packages.first;

      // Initiate purchase
      final success = await RevenueCatService.instance.purchasePackage(package);
      if (!mounted) return;

      if (success) {
        // Purchase successful, navigate to results
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
          SnackBar(
            content: Text(AppLocalizations.of(context)!.paywallPurchaseFailed),
            backgroundColor: AppTheme.errorRed,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      // Handle purchase errors
      if (e.toString().contains('cancelled') || e.toString().contains('Cancelled')) {
        // User cancelled, don't show error
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${AppLocalizations.of(context)!.paywallPurchaseFailedPrefix}${e.toString()}'),
          backgroundColor: AppTheme.errorRed,
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
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppTheme.primaryTeal.withOpacity(0.08),
            border: Border.all(
              color: AppTheme.primaryTeal.withOpacity(0.15),
              width: 1.5,
            ),
          ),
          child: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              CupertinoIcons.xmark,
              color: AppTheme.primaryTeal.withOpacity(0.7),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white.withOpacity(0.98),
              AppTheme.primaryTeal.withOpacity(0.02),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingL,
              vertical: AppTheme.spacingM,
            ),
            child: Column(
              children: [
                // Header
                _buildHeader(),

                const SizedBox(height: AppTheme.spacingXL),

                // Features list
                _buildFeaturesList(),

                const SizedBox(height: AppTheme.spacingXL),

                // Purchase summary
                _buildPurchaseSummary(),

                const SizedBox(height: AppTheme.spacingXL),

                // Purchase button
                _buildPurchaseButton(),

                const SizedBox(height: AppTheme.spacingL),

                // Restore purchase
                _buildRestorePurchase(),
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
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.primaryTeal.withOpacity(0.12),
                AppTheme.accentGreen.withOpacity(0.08),
              ],
            ),
            shape: BoxShape.circle,
            border: Border.all(
              color: AppTheme.primaryTeal.withOpacity(0.15),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryTeal.withOpacity(0.08),
                blurRadius: 25,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Icon(
            CupertinoIcons.star_circle,
            size: 50,
            color: AppTheme.primaryTeal.withOpacity(0.6),
          ),
        ),

        const SizedBox(height: AppTheme.spacingXL),

        Text(
          AppLocalizations.of(context)!.paywallHeaderTitle,
          style: AppTheme.displayMedium.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
            color: AppTheme.textPrimary,
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: AppTheme.spacingM),

        Text(
          AppLocalizations.of(context)!.paywallHeaderSubtitle,
          style: AppTheme.bodyLarge.copyWith(
            color: AppTheme.textSecondary,
            fontWeight: FontWeight.w400,
            height: 1.6,
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
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.95),
            AppTheme.primaryTeal.withOpacity(0.02),
          ],
        ),
        borderRadius: BorderRadius.circular(AppTheme.radiusM),
        border: Border.all(
          color: AppTheme.primaryTeal.withOpacity(0.08),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryTeal.withOpacity(0.04),
            blurRadius: 12,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.accentGreen.withOpacity(0.12),
                  AppTheme.accentGreen.withOpacity(0.06),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(AppTheme.radiusM),
              border: Border.all(
                color: AppTheme.accentGreen.withOpacity(0.15),
                width: 1.5,
              ),
            ),
            child: Icon(
              CupertinoIcons.checkmark_circle_fill,
              color: AppTheme.accentGreen.withOpacity(0.7),
              size: 26,
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
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  feature.description,
                  style: AppTheme.bodyMedium.copyWith(
                    color: AppTheme.textSecondary.withOpacity(0.8),
                    height: 1.5,
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
      padding: const EdgeInsets.all(AppTheme.spacingXL),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primaryTeal.withOpacity(0.06),
            AppTheme.accentGreen.withOpacity(0.03),
          ],
        ),
        borderRadius: BorderRadius.circular(AppTheme.radiusL),
        border: Border.all(
          color: AppTheme.primaryTeal.withOpacity(0.1),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryTeal.withOpacity(0.05),
            blurRadius: 20,
            spreadRadius: 0,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppTheme.spacingM),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.primaryTeal.withOpacity(0.15),
                      AppTheme.accentGreen.withOpacity(0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(AppTheme.radiusM),
                  border: Border.all(
                    color: AppTheme.primaryTeal.withOpacity(0.15),
                    width: 1,
                  ),
                ),
                child: Icon(
                  CupertinoIcons.doc_text_search,
                  color: AppTheme.primaryTeal.withOpacity(0.7),
                  size: 28,
                ),
              ),
              const SizedBox(width: AppTheme.spacingL),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.paywallSummaryTitle,
                      style: AppTheme.headlineMedium.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      AppLocalizations.of(context)!.paywallSummarySubtitle,
                      style: AppTheme.bodyMedium.copyWith(
                        color: AppTheme.textSecondary.withOpacity(0.8),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    AppLocalizations.of(context)!.paywallPrice,
                    style: AppTheme.headlineLarge.copyWith(
                      color: AppTheme.primaryTeal.withOpacity(0.8),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'One-time',
                    style: AppTheme.bodySmall.copyWith(
                      color: AppTheme.textSecondary.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: AppTheme.spacingXL),

          Container(
            padding: const EdgeInsets.all(AppTheme.spacingM),
            decoration: BoxDecoration(
              color: AppTheme.accentGreen.withOpacity(0.05),
              borderRadius: BorderRadius.circular(AppTheme.radiusM),
              border: Border.all(
                color: AppTheme.accentGreen.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.info_circle_fill,
                  color: AppTheme.accentGreen.withOpacity(0.6),
                  size: 18,
                ),
                const SizedBox(width: AppTheme.spacingS),
                Expanded(
                  child: Text(
                    AppLocalizations.of(context)!.paywallSummaryNote,
                    style: AppTheme.bodySmall.copyWith(
                      color: AppTheme.textSecondary.withOpacity(0.75),
                      height: 1.5,
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
      height: 60,
      child: ElevatedButton(
        onPressed: _isPurchasing ? null : _purchaseAnalysis,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryTeal.withOpacity(0.85),
          foregroundColor: Colors.white,
          elevation: 6,
          shadowColor: AppTheme.primaryTeal.withOpacity(0.2),
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
                  strokeWidth: 2.5,
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
                        color: Colors.white.withOpacity(0.95),
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
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
          color: AppTheme.textSecondary.withOpacity(0.7),
          decoration: TextDecoration.underline,
          decorationColor: AppTheme.textSecondary.withOpacity(0.5),
        ),
      ),
    );
  }
}


