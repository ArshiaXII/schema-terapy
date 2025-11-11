import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/foundation.dart' show kDebugMode; // for debug-only routing
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'core/providers/user_provider.dart';
import 'core/providers/locale_provider.dart';
import 'screens/onboarding_screen.dart';
import 'screens/auth_screen.dart';
import 'screens/home_screen.dart';
import 'screens/i18n_test_screen.dart';
import 'screens/paywall_screen.dart'; // debug preview entry
import 'l10n/app_localizations.dart';

import 'services/revenuecat_service.dart';
import 'core/providers/user_provider.dart' show SubscriptionType;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const MySchemaApp());
}

/// Main MySchema application
class MySchemaApp extends StatelessWidget {
  const MySchemaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ],
      child: Consumer<LocaleProvider>(
        builder: (context, LocaleProvider localeProvider, child) {
          return MaterialApp(
            title: 'MySchema',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,

            // Localization configuration
            locale: localeProvider.locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'), // English (default)
              Locale('tr'), // Turkish
            ],

            home: const AppInitializer(),
          );
        },
      ),
    );
  }
}

/// Handles app initialization and routing
class AppInitializer extends StatefulWidget {
  const AppInitializer({super.key});

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> {
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      // Initialize locale provider
      final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
      await localeProvider.initialize();

      // Initialize user session
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      // Initialize RevenueCat (reads from --dart-define, falls back to your Public iOS SDK key)
      const rcKey = String.fromEnvironment(
        'RC_IOS_PUBLIC_SDK_KEY',
        defaultValue: 'appl_rRdLqrVhpQnByIbzOahBqtWcpML',
      );
      try {
        await RevenueCatService.instance.init(apiKey: rcKey);
      } catch (e) {
        debugPrint('RevenueCat init failed: $e');
      }

      await userProvider.initializeUser();

      // Add any other initialization logic here
      // e.g., check for app updates, load cached data, etc.

      setState(() {
        _isInitialized = true;
      });
    } catch (e) {
      debugPrint('App initialization failed: $e');
      setState(() {
        _isInitialized = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const SplashScreen();
    }

    return Consumer<UserProvider>(
      builder: (context, UserProvider userProvider, child) {
        if (userProvider.isLoading) {
          return const SplashScreen();
        }

        // Debug-only direct screen preview via URL query, e.g. ?screen=paywall
        if (kDebugMode) {
          final params = Uri.base.queryParameters;
          final screen = params['screen'];
          if (screen == 'paywall') {
            return const PaywallScreen(
              dominantSchema: 'Perfectionist',
              fullAnalysisText:
                  'Preview mode: this is a placeholder analysis used for screenshots.',
            );
          }
          // Debug mode: skip authentication and go directly to home screen
          if (screen == 'home' || screen == null) {
            // Auto-login for testing
            if (!userProvider.isAuthenticated) {
              Future.microtask(() async {
                await userProvider.signIn('test@example.com', 'password');
                // Subscribe to premium for testing
                await userProvider.subscribeToPremium(SubscriptionType.yearly);
              });
            }
            return const HomeScreen();
          }
        }

        if (userProvider.isAuthenticated) {
          return const HomeScreen();
        }

        // For first-time users, show onboarding
        // In a real app, you'd check if they've seen onboarding before
        return const OnboardingScreen();
      },
    );
  }
}

/// Splash screen shown during app initialization
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 0.8, curve: Curves.elasticOut),
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
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App icon
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.psychology_outlined,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),

                  SizedBox(height: AppTheme.spacingXL),

                  // App name
                  Text(
                    AppLocalizations.of(context)?.appTitle ?? 'MySchema',
                    style: AppTheme.displayLarge.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: AppTheme.spacingS),

                  // Tagline
                  Text(
                    AppLocalizations.of(context)?.appTagline ?? 'Your Path to Self-Understanding',
                    style: AppTheme.bodyLarge.copyWith(
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),

                  SizedBox(height: AppTheme.spacingXXL),

                  // Loading indicator
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white.withOpacity(0.8),
                      ),
                      strokeWidth: 3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
