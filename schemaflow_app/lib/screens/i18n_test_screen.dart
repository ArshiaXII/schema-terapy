import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../core/theme/app_theme.dart';

/// Test screen to verify i18n setup is working
class I18nTestScreen extends StatelessWidget {
  const I18nTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.appTitle),
        backgroundColor: AppTheme.primaryTeal,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Internationalization Test',
              style: AppTheme.displayMedium,
            ),
            
            const SizedBox(height: AppTheme.spacingL),
            
            Text(
              'App Title: ${localizations.appTitle}',
              style: AppTheme.titleLarge,
            ),
            
            const SizedBox(height: AppTheme.spacingM),
            
            Text(
              'Start Test Button: ${localizations.startTestButton}',
              style: AppTheme.titleLarge,
            ),
            
            const SizedBox(height: AppTheme.spacingXL),
            
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Button pressed: ${localizations.startTestButton}'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryTeal,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingL,
                  vertical: AppTheme.spacingM,
                ),
              ),
              child: Text(localizations.startTestButton),
            ),
            
            const SizedBox(height: AppTheme.spacingXL),
            
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingL),
              decoration: BoxDecoration(
                color: AppTheme.backgroundCard,
                borderRadius: BorderRadius.circular(AppTheme.radiusL),
                border: Border.all(color: AppTheme.primaryTeal.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Localization Info',
                    style: AppTheme.titleMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: AppTheme.spacingM),
                  
                  Text(
                    'Current Locale: ${Localizations.localeOf(context)}',
                    style: AppTheme.bodyMedium,
                  ),
                  
                  const SizedBox(height: AppTheme.spacingS),
                  
                  Text(
                    'Supported Locales: en, tr',
                    style: AppTheme.bodyMedium,
                  ),
                  
                  const SizedBox(height: AppTheme.spacingS),
                  
                  Text(
                    'Default Language: English',
                    style: AppTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
