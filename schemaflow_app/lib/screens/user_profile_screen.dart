import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_theme.dart';
import '../core/providers/user_provider.dart';
import '../l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../core/widgets/language_switcher.dart';
import 'auth_screen.dart';

/// User profile screen for account and subscription management
class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
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

  Future<void> _signOut() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          AppLocalizations.of(context)!.profileSignOutTitle,
          style: AppTheme.titleLarge,
        ),
        content: Text(
          'Are you sure you want to sign out?',
          style: AppTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: AppTheme.errorRed,
            ),
            child: Text(AppLocalizations.of(context)!.commonSignOut),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      try {
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        await userProvider.signOut();

        if (mounted) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const AuthScreen()),
            (route) => false,
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${AppLocalizations.of(context)!.profileFailedSignOutPrefix}$e'),
              backgroundColor: AppTheme.errorRed,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.profileTitle,
          style: AppTheme.titleLarge,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppTheme.spacingL),
            child: Consumer<UserProvider>(
              builder: (context, userProvider, child) {
                final user = userProvider.currentUser;
                if (user == null) return const SizedBox.shrink();

                return Column(
                  children: [
                    // Profile header
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: _buildProfileHeader(user),
                    ),

                    const SizedBox(height: AppTheme.spacingXL),

                    // Subscription status
                    SlideTransition(
                      position: _slideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: _buildSubscriptionCard(user),
                      ),
                    ),

                    const SizedBox(height: AppTheme.spacingL),

                    // Profile options
                    SlideTransition(
                      position: _slideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: _buildProfileOptions(user),
                      ),
                    ),

                    const SizedBox(height: AppTheme.spacingL),

                    // Sign out button
                    SlideTransition(
                      position: _slideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: _buildSignOutButton(),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(User user) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingXL),
      decoration: AppTheme.elevatedCardDecoration,
      child: Column(
        children: [
          // Avatar
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
              shape: BoxShape.circle,
              boxShadow: AppTheme.shadowMedium,
            ),
            child: Center(
              child: Text(
                user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U',
                style: AppTheme.displayMedium.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),

          const SizedBox(height: AppTheme.spacingL),

          // Name
          Text(
            user.name,
            style: AppTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: AppTheme.spacingS),

          // Email
          Text(
            user.email,
            style: AppTheme.bodyMedium.copyWith(
              color: AppTheme.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionCard(User user) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingL),
      decoration: AppTheme.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                user.isPremium
                    ? CupertinoIcons.star_circle_fill
                    : CupertinoIcons.star_circle,
                color: user.isPremium
                    ? AppTheme.warningOrange
                    : AppTheme.textSecondary,
                size: 24,
              ),
              const SizedBox(width: AppTheme.spacingS),
              Text(
                AppLocalizations.of(context)!.profileSubscriptionStatus,
                style: AppTheme.titleMedium,
              ),
            ],
          ),

          const SizedBox(height: AppTheme.spacingL),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.profileCurrentPlan,
                    style: AppTheme.bodySmall.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingXS),
                  Text(
                    user.subscriptionDisplayName,
                    style: AppTheme.titleMedium.copyWith(
                      color: user.isPremium
                          ? AppTheme.warningOrange
                          : AppTheme.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              if (user.subscriptionStartDate != null) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.profileMemberSince,
                      style: AppTheme.bodySmall.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingXS),
                    Text(
                      _formatDate(user.subscriptionStartDate!),
                      style: AppTheme.bodyMedium.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),

          if (!user.isPremium) ...[
            const SizedBox(height: AppTheme.spacingL),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Navigate to subscription screen
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(AppLocalizations.of(context)!.profileUpgradeSoon)),
                  );
                },
                style: AppTheme.primaryButtonStyle,
                child: Text(AppLocalizations.of(context)!.profileUpgradePremium),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildProfileOptions(User user) {
    return Container(
      decoration: AppTheme.cardDecoration,
      child: Column(
        children: [
          _buildOptionTile(
            icon: CupertinoIcons.person_circle,
            title: AppLocalizations.of(context)!.profileEditTitle,
            subtitle: AppLocalizations.of(context)!.profileEditSubtitle,
            onTap: () {
              // TODO: Navigate to edit profile screen
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(AppLocalizations.of(context)!.profileEditSoon)),
              );
            },
          ),

          const Divider(height: 1),

          if (user.isPremium) ...[
            _buildOptionTile(
              icon: CupertinoIcons.creditcard,
              title: AppLocalizations.of(context)!.profileManageSubTitle,
              subtitle: AppLocalizations.of(context)!.profileManageSubSubtitle,
              onTap: () {
                // TODO: Navigate to subscription management
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(AppLocalizations.of(context)!.profileManageSubSoon)),
                );
              },
            ),

            const Divider(height: 1),
          ],

          // Language section
          _buildLanguageSection(),

          const Divider(height: 1),

          _buildOptionTile(
            icon: CupertinoIcons.question_circle,
            title: AppLocalizations.of(context)!.profileHelpTitle,
            subtitle: AppLocalizations.of(context)!.profileHelpSubtitle,
            onTap: () {
              // TODO: Navigate to help screen
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(AppLocalizations.of(context)!.profileHelpSoon)),
              );
            },
          ),

          const Divider(height: 1),

          _buildOptionTile(
            icon: CupertinoIcons.doc_text,
            title: AppLocalizations.of(context)!.profilePrivacyTitle,
            subtitle: AppLocalizations.of(context)!.profilePrivacySubtitle,
            onTap: () {
              // TODO: Navigate to privacy policy
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(AppLocalizations.of(context)!.profilePrivacySoon)),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageSection() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                CupertinoIcons.globe,
                color: AppTheme.primaryTeal,
                size: 20,
              ),
              const SizedBox(width: AppTheme.spacingM),
              Text(
                AppLocalizations.of(context)!.profileLanguageTitle,
                style: AppTheme.titleMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppTheme.spacingM),

          const LanguageSwitcher(showTitle: false),
        ],
      ),
    );
  }

  Widget _buildOptionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.all(AppTheme.spacingL),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppTheme.primaryTeal.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppTheme.radiusM),
        ),
        child: Icon(
          icon,
          color: AppTheme.primaryTeal,
          size: 20,
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
        size: 16,
      ),
      onTap: onTap,
    );
  }

  Widget _buildSignOutButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: _signOut,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppTheme.errorRed,
          side: const BorderSide(color: AppTheme.errorRed),
          padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingL),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusM),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              CupertinoIcons.square_arrow_right,
              size: 20,
            ),
            const SizedBox(width: AppTheme.spacingS),
            Text(
              AppLocalizations.of(context)!.profileSignOutButton,
              style: AppTheme.titleMedium.copyWith(
                color: AppTheme.errorRed,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    return DateFormat('MMM yyyy', locale).format(date);
  }
}
