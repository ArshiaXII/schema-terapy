import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../core/theme/app_theme.dart';
import '../l10n/app_localizations.dart';

import 'paywall_screen.dart';

/// Teaser Result Screen - Shows a preview of the analysis to encourage purchase
///
/// This is the critical conversion screen that shows users a taste of their
/// analysis to motivate them to purchase the full report.
class TeaserResultScreen extends StatefulWidget {
  final String dominantSchema;
  final String fullAnalysisText;

  const TeaserResultScreen({
    super.key,
    required this.dominantSchema,
    required this.fullAnalysisText,
  });

  @override
  State<TeaserResultScreen> createState() => _TeaserResultScreenState();
}

class _TeaserResultScreenState extends State<TeaserResultScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startAnimations();
  }

  void _setupAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));
  }

  void _startAnimations() {
    _fadeController.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      _slideController.forward();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  /// Extract the first 3-4 sentences from the full analysis for teaser
  String _getTeaserText() {
    final sentences = widget.fullAnalysisText.split('. ');
    if (sentences.length <= 3) {
      return widget.fullAnalysisText;
    }

    // Take first 3 sentences and add ellipsis
    final teaserSentences = sentences.take(3).toList();
    return '${teaserSentences.join('. ')}...';
  }

  /// Get a user-friendly display name for the schema
  String _getSchemaDisplayName() {
    // Convert technical schema names to user-friendly versions
    final schemaDisplayNames = {
      'Terk Edilme': 'Abandonment Schema',
      'Kusurluluk': 'Defectiveness Schema',
      'Güvensizlik': 'Mistrust Schema',
      'Sosyal İzolasyon': 'Social Isolation Schema',
      'Duygusal Yoksunluk': 'Emotional Deprivation Schema',
      'Başarısızlık': 'Failure Schema',
      'Bağımlılık': 'Dependence Schema',
      'Zarar Görme': 'Vulnerability Schema',
      'İç İçe Geçme': 'Enmeshment Schema',
      'Teslim Olma': 'Subjugation Schema',
    };

    return schemaDisplayNames[widget.dominantSchema] ?? widget.dominantSchema;
  }

  void _navigateToPaywall() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PaywallScreen(
          dominantSchema: widget.dominantSchema,
          fullAnalysisText: widget.fullAnalysisText,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 375;

    return Scaffold(
      backgroundColor: AppTheme.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: AppTheme.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          AppLocalizations.of(context)!.teaserAppBarTitle,
          style: AppTheme.headlineMedium.copyWith(
            color: AppTheme.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(isSmallScreen ? AppTheme.spacingM : AppTheme.spacingL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                _buildHeaderSection(isSmallScreen),

                SizedBox(height: isSmallScreen ? AppTheme.spacingL : AppTheme.spacingXL),

                // Dominant Schema Card
                _buildDominantSchemaCard(isSmallScreen),

                SizedBox(height: isSmallScreen ? AppTheme.spacingL : AppTheme.spacingXL),

                // Teaser Analysis Section
                _buildTeaserSection(isSmallScreen),

                SizedBox(height: isSmallScreen ? AppTheme.spacingL : AppTheme.spacingXL),

                // Call to Action Section
                _buildCallToActionSection(isSmallScreen),

                SizedBox(height: isSmallScreen ? AppTheme.spacingXL : AppTheme.spacingXXL),

                // Purchase Button
                _buildPurchaseButton(isSmallScreen),

                const SizedBox(height: AppTheme.spacingXL),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection(bool isSmallScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacingM,
            vertical: AppTheme.spacingS,
          ),
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
            borderRadius: BorderRadius.circular(AppTheme.radiusM),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                CupertinoIcons.sparkles,
                color: Colors.white,
                size: 16,
              ),
              const SizedBox(width: AppTheme.spacingS),
              Text(
                AppLocalizations.of(context)!.teaserBadgeInitial,
                style: AppTheme.bodyMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: isSmallScreen ? AppTheme.spacingM : AppTheme.spacingL),

        Text(
          AppLocalizations.of(context)!.teaserHeaderTitle,
          style: isSmallScreen
            ? AppTheme.headlineLarge
            : AppTheme.headlineLarge.copyWith(fontSize: 32),
          textAlign: TextAlign.left,
        ),

        const SizedBox(height: AppTheme.spacingS),

        Text(
          AppLocalizations.of(context)!.teaserHeaderSubtitle,
          style: AppTheme.bodyLarge.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildDominantSchemaCard(bool isSmallScreen) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isSmallScreen ? AppTheme.spacingL : AppTheme.spacingXL),
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
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  CupertinoIcons.person_crop_circle_badge_checkmark,
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
                      AppLocalizations.of(context)!.teaserPrimaryTendency,
                      style: AppTheme.bodyMedium.copyWith(
                        color: AppTheme.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingXS),
                    Text(
                      _getSchemaDisplayName(),
                      style: isSmallScreen
                        ? AppTheme.headlineMedium
                        : AppTheme.headlineMedium.copyWith(fontSize: 22),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTeaserSection(bool isSmallScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.teaserSectionTitle,
          style: AppTheme.headlineMedium,
        ),

        const SizedBox(height: AppTheme.spacingM),

        Container(
          width: double.infinity,
          padding: EdgeInsets.all(isSmallScreen ? AppTheme.spacingM : AppTheme.spacingL),
          decoration: BoxDecoration(
            color: AppTheme.backgroundCard,
            borderRadius: BorderRadius.circular(AppTheme.radiusL),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _getTeaserText(),
                style: AppTheme.bodyLarge.copyWith(
                  height: 1.6,
                  color: AppTheme.textPrimary,
                ),
              ),

              const SizedBox(height: AppTheme.spacingM),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingM,
                  vertical: AppTheme.spacingS,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      AppTheme.backgroundCard.withOpacity(0.9),
                      AppTheme.backgroundCard,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      CupertinoIcons.lock_fill,
                      color: AppTheme.textSecondary,
                      size: 14,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        AppLocalizations.of(context)!.teaserUnlockNote,
                        style: AppTheme.bodyMedium.copyWith(
                          color: AppTheme.textSecondary,
                          fontStyle: FontStyle.italic,
                          fontSize: 13,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCallToActionSection(bool isSmallScreen) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isSmallScreen ? AppTheme.spacingL : AppTheme.spacingXL),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.accentGreen.withOpacity(0.1),
            AppTheme.primaryTeal.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(AppTheme.radiusL),
        border: Border.all(
          color: AppTheme.accentGreen.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                CupertinoIcons.star_fill,
                color: AppTheme.accentGreen,
                size: 20,
              ),
              const SizedBox(width: AppTheme.spacingS),
              Text(
                AppLocalizations.of(context)!.teaserCtaHeading,
                style: AppTheme.headlineSmall.copyWith(
                  color: AppTheme.accentGreen,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppTheme.spacingM),

          Text(
            AppLocalizations.of(context)!.teaserCtaIntro,
            style: AppTheme.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: AppTheme.spacingM),

          ...[
            AppLocalizations.of(context)!.teaserBenefit1,
            AppLocalizations.of(context)!.teaserBenefit2,
            AppLocalizations.of(context)!.teaserBenefit3,
            AppLocalizations.of(context)!.teaserBenefit4,
            AppLocalizations.of(context)!.teaserBenefit5,
          ].map((benefit) => Padding(
            padding: const EdgeInsets.only(bottom: AppTheme.spacingS),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  CupertinoIcons.checkmark_circle_fill,
                  color: AppTheme.accentGreen,
                  size: 16,
                ),
                const SizedBox(width: AppTheme.spacingS),
                Expanded(
                  child: Text(
                    benefit,
                    style: AppTheme.bodyMedium.copyWith(
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildPurchaseButton(bool isSmallScreen) {
    return SizedBox(
      width: double.infinity,
      height: isSmallScreen ? 56 : 64,
      child: ElevatedButton(
        onPressed: _navigateToPaywall,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryTeal,
          foregroundColor: Colors.white,
          elevation: 8,
          shadowColor: AppTheme.primaryTeal.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusL),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              CupertinoIcons.lock_open_fill,
              size: 20,
            ),
            const SizedBox(width: AppTheme.spacingS),
            Flexible(
              child: Text(
                AppLocalizations.of(context)!.paywallUnlockCta(AppLocalizations.of(context)!.paywallPrice),
                style: isSmallScreen
                  ? AppTheme.bodyLarge.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )
                  : AppTheme.headlineSmall.copyWith(
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
}
