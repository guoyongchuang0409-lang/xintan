import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_animations.dart';
import '../../core/services/sound_service.dart';
class GlowButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? color;
  final double? width;
  final double height;
  final IconData? icon;
  final bool isLoading;

  const GlowButton({
    super.key,
    required this.text,
    this.onPressed,
    this.color,
    this.width,
    this.height = 48,
    this.icon,
    this.isLoading = false,
  });

  @override
  State<GlowButton> createState() => _GlowButtonState();
}

class _GlowButtonState extends State<GlowButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: AppAnimations.glowPulse,
      vsync: this,
    );
    _pulseAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
    );
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final buttonColor = widget.color ?? AppColors.neonCyan;
    final isEnabled = widget.onPressed != null && !widget.isLoading;

    return GestureDetector(
      onTapDown: isEnabled ? _handleTapDown : null,
      onTapUp: isEnabled ? _handleTapUp : null,
      onTapCancel: isEnabled ? _handleTapCancel : null,
      onTap: isEnabled
          ? () {
              SoundService.instance.playClick();
              widget.onPressed?.call();
            }
          : null,
      child: AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, child) {
          final glowIntensity = _isPressed
              ? 0.9
              : (isEnabled ? _pulseAnimation.value : 0.3);
          final spreadRadius = _isPressed ? 16.0 : 10.0;

          return AnimatedContainer(
            duration: AppAnimations.fast,
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  buttonColor.withOpacity(isEnabled ? 1.0 : 0.5),
                  buttonColor.withOpacity(isEnabled ? 0.8 : 0.4),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: buttonColor.withOpacity(glowIntensity * 0.4),
                  blurRadius: spreadRadius,
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: buttonColor.withOpacity(glowIntensity * 0.2),
                  blurRadius: spreadRadius * 2,
                  spreadRadius: spreadRadius * 0.5,
                ),
              ],
            ),
            child: child,
          );
        },
        child: Center(
          child: widget.isLoading
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.background,
                    ),
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.icon != null) ...[
                      Icon(
                        widget.icon,
                        color: AppColors.background,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      widget.text,
                      style: TextStyle(
                        color: AppColors.background,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
