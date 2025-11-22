import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_theme.dart';
import '../core/providers/user_provider.dart';
import '../core/widgets/language_switcher.dart';
import '../l10n/app_localizations.dart';
import 'home_screen.dart';

/// Authentication screen for login and sign up
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  bool _isSignUp = false;
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _toggleAuthMode() {
    setState(() {
      _isSignUp = !_isSignUp;
    });
    _animationController.reset();
    _animationController.forward();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      
      if (_isSignUp) {
        await userProvider.signUp(
          _nameController.text.trim(),
          _emailController.text.trim(),
          _passwordController.text,
        );
      } else {
        await userProvider.signIn(
          _emailController.text.trim(),
          _passwordController.text,
        );
      }

      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: AppTheme.errorRed,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Main content
              SingleChildScrollView(
                padding: const EdgeInsets.all(AppTheme.spacingXL),
                child: Column(
                  children: [
                    SizedBox(height: screenSize.height * 0.1),

                    // App logo and title
                    _buildHeader(),
                
                SizedBox(height: screenSize.height * 0.08),
                
                // Auth form
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: _buildAuthForm(),
                ),
                
                const SizedBox(height: AppTheme.spacingXL),
                
                // Social login options
                _buildSocialLogin(),
                
                const SizedBox(height: AppTheme.spacingL),
                
                // Toggle auth mode
                _buildAuthToggle(),
                  ],
                ),
              ),

              // Language switcher in top-right corner
              Positioned(
                top: AppTheme.spacingM,
                right: AppTheme.spacingM,
                child: const CompactLanguageSwitcher(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        // App icon
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
            shape: BoxShape.circle,
            boxShadow: AppTheme.shadowMedium,
          ),
          child: const Icon(
            CupertinoIcons.person_crop_circle_badge_checkmark,
            size: 40,
            color: Colors.white,
          ),
        ),
        
        const SizedBox(height: AppTheme.spacingL),
        
        // App name
        Text(
          AppLocalizations.of(context)!.appTitle,
          style: AppTheme.displayLarge.copyWith(
            color: AppTheme.primaryTeal,
          ),
        ),
        
        const SizedBox(height: AppTheme.spacingS),
        
        // Tagline
        Text(
          AppLocalizations.of(context)!.appTagline,
          style: AppTheme.bodyLarge.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildAuthForm() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingXL),
      decoration: AppTheme.elevatedCardDecoration,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Form title
            Text(
              _isSignUp ? AppLocalizations.of(context)!.authCreateAccount : AppLocalizations.of(context)!.authWelcomeBack,
              style: AppTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: AppTheme.spacingXL),
            
            // Name field (only for sign up)
            if (_isSignUp) ...[
              TextFormField(
                controller: _nameController,
                decoration: AppTheme.inputDecoration(
                  labelText: AppLocalizations.of(context)!.authFullNameLabel,
                  prefixIcon: const Icon(CupertinoIcons.person),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return AppLocalizations.of(context)!.authPleaseEnterName;
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppTheme.spacingL),
            ],
            
            // Email field
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: AppTheme.inputDecoration(
                labelText: AppLocalizations.of(context)!.authEmailLabel,
                prefixIcon: const Icon(CupertinoIcons.mail),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return AppLocalizations.of(context)!.authPleaseEnterEmail;
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                  return AppLocalizations.of(context)!.authPleaseEnterValidEmail;
                }
                return null;
              },
            ),
            
            const SizedBox(height: AppTheme.spacingL),
            
            // Password field
            TextFormField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              decoration: AppTheme.inputDecoration(
                labelText: AppLocalizations.of(context)!.authPasswordLabel,
                prefixIcon: const Icon(CupertinoIcons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible 
                        ? CupertinoIcons.eye_slash 
                        : CupertinoIcons.eye,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of(context)!.authPleaseEnterPassword;
                }
                if (_isSignUp && value.length < 6) {
                  return AppLocalizations.of(context)!.authPasswordMin;
                }
                return null;
              },
            ),
            
            const SizedBox(height: AppTheme.spacingXL),
            
            // Submit button
            SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _submitForm,
                style: AppTheme.primaryButtonStyle,
                child: _isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        _isSignUp ? AppLocalizations.of(context)!.authCreateAccount : AppLocalizations.of(context)!.authSignIn,
                        style: AppTheme.titleMedium.copyWith(
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialLogin() {
    return Column(
      children: [
        Text(
          AppLocalizations.of(context)!.authOrContinueWith,
          style: AppTheme.bodyMedium.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
        
        const SizedBox(height: AppTheme.spacingL),
        
        Row(
          children: [
            // Google sign in
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  // TODO: Implement Google sign in
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(AppLocalizations.of(context)!.authGoogleSoon)),
                  );
                },
                style: AppTheme.secondaryButtonStyle,
                icon: const Icon(CupertinoIcons.globe, size: 20),
                label: Text(AppLocalizations.of(context)!.authGoogle),
              ),
            ),
            
            const SizedBox(width: AppTheme.spacingM),
            
            // Apple sign in
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  // TODO: Implement Apple sign in
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(AppLocalizations.of(context)!.authAppleSoon)),
                  );
                },
                style: AppTheme.secondaryButtonStyle,
                icon: const Icon(CupertinoIcons.device_phone_portrait, size: 20),
                label: Text(AppLocalizations.of(context)!.authApple),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAuthToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _isSignUp
              ? AppLocalizations.of(context)!.authAlreadyHaveAccount
              : AppLocalizations.of(context)!.authDontHaveAccount,
          style: AppTheme.bodyMedium.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
        TextButton(
          onPressed: _toggleAuthMode,
          style: AppTheme.textButtonStyle,
          child: Text(
            _isSignUp ? AppLocalizations.of(context)!.authSignIn : AppLocalizations.of(context)!.authSignUp,
            style: AppTheme.bodyMedium.copyWith(
              color: AppTheme.primaryTeal,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
