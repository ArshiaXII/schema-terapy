import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;
import '../core/theme/app_theme.dart';

/// Modern animated premium feature card with glassmorphism and smooth flowing animations
class AnimatedFeatureCard extends StatefulWidget {
  final String title;
  final String? subtitle;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;
  final int delayMs;

  const AnimatedFeatureCard({
    Key? key,
    required this.title,
    this.subtitle,
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
  late AnimationController _entranceController;
  late AnimationController _floatController;
  late AnimationController _glowController;
  late AnimationController _rotateController;

  bool _isHovered = false;

  @override
  void initState() {
    super.initState();

    // Entrance animation
    _entranceController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Floating animation
    _floatController = AnimationController(
      duration: const Duration(milliseconds: 4000),
      vsync: this,
    )..repeat(reverse: true);

    // Glow animation
    _glowController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    )..repeat(reverse: true);

    // Rotate animation
    _rotateController = AnimationController(
      duration: const Duration(milliseconds: 8000),
      vsync: this,
    )..repeat();

    // Start entrance animation with delay
    Future.delayed(Duration(milliseconds: widget.delayMs), () {
      if (mounted) {
        _entranceController.forward();
      }
    });
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _floatController.dispose();
    _glowController.dispose();
    _rotateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(begin: 0.8, end: 1.0).animate(
        CurvedAnimation(parent: _entranceController, curve: Curves.easeOutCubic),
      ),
      child: FadeTransition(
        opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: _entranceController, curve: Curves.easeOut),
        ),
        child: MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: GestureDetector(
            onTap: widget.onTap,
            child: AnimatedBuilder(
              animation: Listenable.merge([
                _floatController,
                _glowController,
                _rotateController,
              ]),
              builder: (context, child) {
                final floatValue = Tween<double>(begin: 0.0, end: 16.0)
                    .evaluate(CurvedAnimation(
                        parent: _floatController, curve: Curves.easeInOutCubic));

                final glowValue = Tween<double>(begin: 0.3, end: 0.8)
                    .evaluate(CurvedAnimation(
                        parent: _glowController, curve: Curves.easeInOutQuad));

                final scaleValue = _isHovered ? 1.05 : 1.0;

                return Transform.translate(
                  offset: Offset(0, -floatValue),
                  child: Transform.scale(
                    scale: scaleValue,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppTheme.radiusM),
                        boxShadow: [
                          // Main glow shadow
                          BoxShadow(
                            color: widget.color.withOpacity(
                              _isHovered ? 0.6 : glowValue * 0.4,
                            ),
                            blurRadius: _isHovered ? 50 : 30,
                            spreadRadius: _isHovered ? 4 : 2,
                            offset: Offset(0, _isHovered ? 25 : 15),
                          ),
                          // Secondary glow
                          BoxShadow(
                            color: widget.color.withOpacity(glowValue * 0.15),
                            blurRadius: 40,
                            spreadRadius: 8,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppTheme.radiusM),
                        child: Stack(
                          children: [
                            // Glassmorphism background
                            BackdropFilter(
                              filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      widget.color.withOpacity(_isHovered ? 0.25 : 0.15),
                                      widget.color.withOpacity(_isHovered ? 0.15 : 0.08),
                                    ],
                                  ),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(
                                      _isHovered ? 0.4 : 0.2,
                                    ),
                                    width: 1.5,
                                  ),
                                ),
                              ),
                            ),
                            // Animated background painter
                            Positioned.fill(
                              child: CustomPaint(
                                painter: ModernBackgroundPainter(
                                  color: Colors.white,
                                  rotateValue: _rotateController.value,
                                  glowValue: glowValue,
                                ),
                              ),
                            ),
                            // Content
                            Positioned.fill(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Animated icon with glow
                                  Transform.scale(
                                    scale: 1.0 + (glowValue * 0.1),
                                    child: Container(
                                      width: 70,
                                      height: 70,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white.withOpacity(0.1),
                                        border: Border.all(
                                          color: Colors.white.withOpacity(
                                            glowValue * 0.5,
                                          ),
                                          width: 2.5,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.white.withOpacity(
                                              glowValue * 0.5,
                                            ),
                                            blurRadius: 30,
                                            spreadRadius: 10,
                                          ),
                                        ],
                                      ),
                                      child: Transform.rotate(
                                        angle: _rotateController.value * 0.2,
                                        child: Icon(
                                          widget.icon,
                                          size: 36,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: AppTheme.spacingM),
                                  // Title
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: AppTheme.spacingM,
                                    ),
                                    child: Text(
                                      widget.title,
                                      style: AppTheme.bodyLarge.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.3,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  // Subtitle if provided
                                  if (widget.subtitle != null) ...[
                                    const SizedBox(height: AppTheme.spacingXS),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: AppTheme.spacingM,
                                      ),
                                      child: Text(
                                        widget.subtitle!,
                                        style: AppTheme.bodySmall.copyWith(
                                          color: Colors.white.withOpacity(0.7),
                                          fontWeight: FontWeight.w400,
                                        ),
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

/// Modern custom painter for smooth animated background
class ModernBackgroundPainter extends CustomPainter {
  final Color color;
  final double rotateValue;
  final double glowValue;

  ModernBackgroundPainter({
    required this.color,
    required this.rotateValue,
    required this.glowValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Subtle animated gradient overlay
    final gradientPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withOpacity(0.05 + (glowValue * 0.05)),
          Colors.white.withOpacity(0.02),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), gradientPaint);

    // Animated decorative circles - top right
    final topRightX = size.width * 0.85;
    final topRightY = size.height * 0.15;

    final circlePaint = Paint()
      ..color = Colors.white.withOpacity(0.08 + (glowValue * 0.07))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // Rotating circles
    canvas.save();
    canvas.translate(topRightX, topRightY);
    canvas.rotate(rotateValue * 2 * math.pi);

    canvas.drawCircle(Offset.zero, 25, circlePaint);
    canvas.drawCircle(Offset.zero, 35, circlePaint);

    canvas.restore();

    // Animated dots around the circle
    final dotPaint = Paint()
      ..color = Colors.white.withOpacity(0.12 + (glowValue * 0.08))
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 6; i++) {
      final angle = (rotateValue * 2 * math.pi) + (i * math.pi / 3);
      final x = topRightX + (45 * math.cos(angle));
      final y = topRightY + (45 * math.sin(angle));

      canvas.drawCircle(
        Offset(x, y),
        2.5 + (glowValue * 1.5),
        dotPaint,
      );
    }

    // Bottom left accent
    final bottomLeftX = size.width * 0.1;
    final bottomLeftY = size.height * 0.9;

    final accentPaint = Paint()
      ..color = Colors.white.withOpacity(0.06 + (glowValue * 0.04))
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(bottomLeftX, bottomLeftY), 12, accentPaint);
    canvas.drawCircle(Offset(bottomLeftX + 25, bottomLeftY - 20), 7, accentPaint);
    canvas.drawCircle(Offset(bottomLeftX - 15, bottomLeftY - 15), 5, accentPaint);
  }

  @override
  bool shouldRepaint(ModernBackgroundPainter oldDelegate) {
    return oldDelegate.rotateValue != rotateValue ||
        oldDelegate.glowValue != glowValue;
  }
}

