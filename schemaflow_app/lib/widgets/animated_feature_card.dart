import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/theme/app_theme.dart';

/// Animated premium feature card with flowing animations and visual graphics
class AnimatedFeatureCard extends StatefulWidget {
  final String title;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;
  final int delayMs;

  const AnimatedFeatureCard({
    Key? key,
    required this.title,
    required this.color,
    required this.icon,
    required this.onTap,
    this.delayMs = 0,
  }) : super(key: key);

  @override
  State<AnimatedFeatureCard> createState() => _AnimatedFeatureCardState();
}

class _AnimatedFeatureCardState extends State<AnimatedFeatureCard>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _floatController;
  late AnimationController _shimmerController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _floatAnimation;
  late Animation<double> _shimmerAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();

    // Scale animation with delay
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _scaleController,
        curve: const Interval(0.0, 0.8, curve: Curves.elasticOut),
      ),
    );

    // Floating animation (continuous)
    _floatController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: 0.0, end: 8.0).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    // Shimmer animation (continuous)
    _shimmerController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();

    _shimmerAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _shimmerController, curve: Curves.easeInOut),
    );

    // Start animation with delay
    Future.delayed(Duration(milliseconds: widget.delayMs), () {
      if (mounted) {
        _scaleController.forward();
      }
    });
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _floatController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedBuilder(
            animation: _floatAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, -_floatAnimation.value),
                child: child,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    widget.color.withOpacity(0.9),
                    widget.color.withOpacity(0.6),
                  ],
                ),
                borderRadius: BorderRadius.circular(AppTheme.radiusM),
                boxShadow: [
                  BoxShadow(
                    color: widget.color.withOpacity(_isHovered ? 0.6 : 0.3),
                    blurRadius: _isHovered ? 30 : 15,
                    offset: Offset(0, _isHovered ? 15 : 8),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Animated background graphics
                  _buildAnimatedBackground(),

                  // Content
                  Positioned.fill(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Animated icon with pulse
                        _buildAnimatedIcon(),
                        const SizedBox(height: AppTheme.spacingS),
                        // Title
                        Text(
                          widget.title,
                          style: AppTheme.bodyMedium.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
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

  Widget _buildAnimatedBackground() {
    return Positioned.fill(
      child: AnimatedBuilder(
        animation: _shimmerAnimation,
        builder: (context, child) {
          return CustomPaint(
            painter: AnimatedBackgroundPainter(
              color: Colors.white.withOpacity(0.1),
              shimmerValue: _shimmerAnimation.value,
            ),
          );
        },
      ),
    );
  }

  Widget _buildAnimatedIcon() {
    return AnimatedBuilder(
      animation: _shimmerAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: 1.0 + (_shimmerAnimation.value * 0.1),
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.2),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(_shimmerAnimation.value * 0.3),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Icon(
              widget.icon,
              size: 28,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}

/// Custom painter for animated background graphics
class AnimatedBackgroundPainter extends CustomPainter {
  final Color color;
  final double shimmerValue;

  AnimatedBackgroundPainter({
    required this.color,
    required this.shimmerValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2;

    // Draw animated circles
    final centerX = size.width * 0.8;
    final centerY = size.height * 0.2;

    // Outer circle
    canvas.drawCircle(
      Offset(centerX, centerY),
      30 + (shimmerValue * 10),
      paint..style = PaintingStyle.stroke,
    );

    // Inner circle
    canvas.drawCircle(
      Offset(centerX, centerY),
      15 + (shimmerValue * 5),
      paint..style = PaintingStyle.stroke,
    );

    // Animated dots
    for (int i = 0; i < 3; i++) {
      final angle = (shimmerValue * 2 * 3.14159) + (i * 2.09);
      final x = centerX + (40 * (1 + shimmerValue * 0.3)) * Math.cos(angle);
      final y = centerY + (40 * (1 + shimmerValue * 0.3)) * Math.sin(angle);

      canvas.drawCircle(
        Offset(x, y),
        3 + (shimmerValue * 2),
        paint..style = PaintingStyle.fill,
      );
    }

    // Bottom left decorative elements
    final bottomLeftX = size.width * 0.15;
    final bottomLeftY = size.height * 0.85;

    canvas.drawCircle(
      Offset(bottomLeftX, bottomLeftY),
      8 + (shimmerValue * 4),
      paint..style = PaintingStyle.fill,
    );

    canvas.drawCircle(
      Offset(bottomLeftX + 20, bottomLeftY - 15),
      5 + (shimmerValue * 2),
      paint..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(AnimatedBackgroundPainter oldDelegate) {
    return oldDelegate.shimmerValue != shimmerValue;
  }
}

// Math helper
class Math {
  static double cos(double x) => math.cos(x);
  static double sin(double x) => math.sin(x);
}

