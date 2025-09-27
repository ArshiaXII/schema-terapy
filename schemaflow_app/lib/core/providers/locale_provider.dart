import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provider for managing app locale/language state
class LocaleProvider extends ChangeNotifier {
  static const String _localeKey = 'app_locale';
  
  Locale _locale = const Locale('en'); // Default to English
  
  Locale get locale => _locale;
  
  /// Get the current language code
  String get languageCode => _locale.languageCode;
  
  /// Get the current language display name
  String get languageDisplayName {
    switch (_locale.languageCode) {
      case 'en':
        return 'English';
      case 'tr':
        return 'Türkçe';
      default:
        return 'English';
    }
  }
  
  /// Get the current language short code for UI display
  String get languageShortCode {
    switch (_locale.languageCode) {
      case 'en':
        return 'EN';
      case 'tr':
        return 'TR';
      default:
        return 'EN';
    }
  }
  
  /// Initialize the locale provider and load saved locale
  Future<void> initialize() async {
    await _loadSavedLocale();
  }
  
  /// Load the saved locale from SharedPreferences
  Future<void> _loadSavedLocale() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedLanguageCode = prefs.getString(_localeKey);
      
      if (savedLanguageCode != null) {
        _locale = Locale(savedLanguageCode);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loading saved locale: $e');
      // Keep default locale if loading fails
    }
  }
  
  /// Save the current locale to SharedPreferences
  Future<void> _saveLocale() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_localeKey, _locale.languageCode);
    } catch (e) {
      debugPrint('Error saving locale: $e');
    }
  }
  
  /// Set the locale to English
  Future<void> setEnglish() async {
    await setLocale(const Locale('en'));
  }
  
  /// Set the locale to Turkish
  Future<void> setTurkish() async {
    await setLocale(const Locale('tr'));
  }
  
  /// Set a specific locale
  Future<void> setLocale(Locale newLocale) async {
    if (_locale == newLocale) return;
    
    _locale = newLocale;
    await _saveLocale();
    notifyListeners();
  }
  
  /// Toggle between English and Turkish
  Future<void> toggleLanguage() async {
    if (_locale.languageCode == 'en') {
      await setTurkish();
    } else {
      await setEnglish();
    }
  }
  
  /// Get list of supported locales
  static List<Locale> get supportedLocales => const [
    Locale('en'),
    Locale('tr'),
  ];
  
  /// Get list of language options for UI
  static List<LanguageOption> get languageOptions => [
    const LanguageOption(
      code: 'en',
      name: 'English',
      nativeName: 'English',
      flag: '🇺🇸',
    ),
    const LanguageOption(
      code: 'tr',
      name: 'Turkish',
      nativeName: 'Türkçe',
      flag: '🇹🇷',
    ),
  ];
  
  /// Check if the current locale is English
  bool get isEnglish => _locale.languageCode == 'en';
  
  /// Check if the current locale is Turkish
  bool get isTurkish => _locale.languageCode == 'tr';
}

/// Model for language options
class LanguageOption {
  final String code;
  final String name;
  final String nativeName;
  final String flag;

  const LanguageOption({
    required this.code,
    required this.name,
    required this.nativeName,
    required this.flag,
  });
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LanguageOption &&
          runtimeType == other.runtimeType &&
          code == other.code;

  @override
  int get hashCode => code.hashCode;
}
