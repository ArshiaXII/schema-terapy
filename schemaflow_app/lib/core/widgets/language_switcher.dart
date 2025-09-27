import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../providers/locale_provider.dart';
import '../theme/app_theme.dart';

/// Compact language switcher for AppBar
class CompactLanguageSwitcher extends StatelessWidget {
  final Color? textColor;
  final Color? backgroundColor;
  
  const CompactLanguageSwitcher({
    super.key,
    this.textColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(
      builder: (context, localeProvider, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: (textColor ?? Colors.white).withOpacity(0.3),
              width: 1,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: localeProvider.languageCode,
              icon: Icon(
                CupertinoIcons.chevron_down,
                size: 14,
                color: textColor ?? Colors.white,
              ),
              style: TextStyle(
                color: textColor ?? Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              dropdownColor: AppTheme.backgroundCard,
              items: LocaleProvider.languageOptions.map((option) {
                return DropdownMenuItem<String>(
                  value: option.code,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        option.flag,
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        option.code.toUpperCase(),
                        style: TextStyle(
                          color: AppTheme.textPrimary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (String? newLanguageCode) {
                if (newLanguageCode != null) {
                  localeProvider.setLocale(Locale(newLanguageCode));
                }
              },
            ),
          ),
        );
      },
    );
  }
}

/// Full language switcher for settings/profile screens
class LanguageSwitcher extends StatelessWidget {
  final String? title;
  final bool showTitle;
  
  const LanguageSwitcher({
    super.key,
    this.title,
    this.showTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(
      builder: (context, localeProvider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showTitle) ...[
              Text(
                title ?? 'Language / Dil',
                style: AppTheme.titleMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppTheme.spacingM),
            ],
            
            Container(
              decoration: BoxDecoration(
                color: AppTheme.backgroundCard,
                borderRadius: BorderRadius.circular(AppTheme.radiusL),
                border: Border.all(
                  color: AppTheme.textTertiary.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Column(
                children: LocaleProvider.languageOptions.map((option) {
                  final isSelected = localeProvider.languageCode == option.code;
                  final isLast = option == LocaleProvider.languageOptions.last;
                  
                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        localeProvider.setLocale(Locale(option.code));
                      },
                      borderRadius: BorderRadius.vertical(
                        top: option == LocaleProvider.languageOptions.first
                            ? const Radius.circular(AppTheme.radiusL)
                            : Radius.zero,
                        bottom: isLast
                            ? const Radius.circular(AppTheme.radiusL)
                            : Radius.zero,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(AppTheme.spacingL),
                        decoration: BoxDecoration(
                          border: !isLast
                              ? Border(
                                  bottom: BorderSide(
                                    color: AppTheme.textTertiary.withOpacity(0.2),
                                    width: 1,
                                  ),
                                )
                              : null,
                        ),
                        child: Row(
                          children: [
                            // Flag
                            Text(
                              option.flag,
                              style: const TextStyle(fontSize: 24),
                            ),
                            
                            const SizedBox(width: AppTheme.spacingM),
                            
                            // Language info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    option.name,
                                    style: AppTheme.titleMedium.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: isSelected 
                                          ? AppTheme.primaryTeal 
                                          : AppTheme.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    option.nativeName,
                                    style: AppTheme.bodyMedium.copyWith(
                                      color: AppTheme.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            // Selection indicator
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected
                                      ? AppTheme.primaryTeal
                                      : AppTheme.textTertiary,
                                  width: 2,
                                ),
                                color: isSelected 
                                    ? AppTheme.primaryTeal 
                                    : Colors.transparent,
                              ),
                              child: isSelected
                                  ? const Icon(
                                      CupertinoIcons.checkmark,
                                      size: 12,
                                      color: Colors.white,
                                    )
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Simple toggle button for language switching
class LanguageToggleButton extends StatelessWidget {
  final Color? backgroundColor;
  final Color? textColor;
  
  const LanguageToggleButton({
    super.key,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(
      builder: (context, localeProvider, child) {
        return GestureDetector(
          onTap: () => localeProvider.toggleLanguage(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: backgroundColor ?? AppTheme.primaryTeal.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppTheme.primaryTeal.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  CupertinoIcons.globe,
                  size: 16,
                  color: textColor ?? AppTheme.primaryTeal,
                ),
                const SizedBox(width: 6),
                Text(
                  localeProvider.languageShortCode,
                  style: TextStyle(
                    color: textColor ?? AppTheme.primaryTeal,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
