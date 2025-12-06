import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_animations.dart';
import '../../core/services/sound_service.dart';
class NeonCard extends StatefulWidget {
  final Widget child;
  final Color? borderColor;
  final double borderWidth;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final bool enableHoverEffect;

  const NeonCard({
    super.key,
    required this.child,
    this.borderColor,
    this.borderWidth = 1.5,
    this.borderRadius = 16,
    this.padding,
    this.onTap,
    this.enableHoverEffect = true,
  });

  @override
  State<NeonCard> createState() => _NeonCardState();
}

class _NeonCardState extends State<NeonCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;
  late Animation<double> _pulseAnimation;
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: AppAnimations.cardHover,
      vsync: this,
    );
    _glowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: AppAnimations.defaultCurve),
    );
    
    // 添加脉冲动画
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleHoverChange(bool isHovered) {
    if (!widget.enableHoverEffect) return;
    setState(() => _isHovered = isHovered);
    if (isHovered) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
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
    final glowColor = widget.borderColor ?? AppColors.neonCyan;

    return MouseRegion(
      onEnter: (_) => _handleHoverChange(true),
      onExit: (_) => _handleHoverChange(false),
      child: GestureDetector(
        onTapDown: widget.onTap != null ? _handleTapDown : null,
        onTapUp: widget.onTap != null ? _handleTapUp : null,
        onTapCancel: widget.onTap != null ? _handleTapCancel : null,
        onTap: widget.onTap != null
            ? () {
                SoundService.instance.playClick();
                widget.onTap?.call();
              }
            : null,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final glowIntensity = _isPressed ? 1.0 : (_isHovered ? 0.9 : 0.65);
            final borderWidthAnimated = widget.borderWidth +
                (_glowAnimation.value * 0.8) +
                (_isPressed ? 0.8 : 0);
            final spreadRadius =
                8.0 + (_glowAnimation.value * 8.0) + (_isPressed ? 6.0 : 0);

            return Transform.scale(
              scale: _isPressed ? 0.98 : (_isHovered ? _pulseAnimation.value : 1.0),
              child: Container(
                padding: widget.padding,
                decoration: BoxDecoration(
                  gradient: AppColors.cardGradient,
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  border: Border.all(
                    color: glowColor.withOpacity(glowIntensity),
                    width: borderWidthAnimated,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: glowColor.withOpacity(glowIntensity * 0.6),
                      blurRadius: spreadRadius,
                      spreadRadius: 0,
                    ),
                    BoxShadow(
                      color: glowColor.withOpacity(glowIntensity * 0.4),
                      blurRadius: spreadRadius * 2,
                      spreadRadius: spreadRadius * 0.5,
                    ),
                    // 添加第三层光晕 - 增强科技感
                    BoxShadow(
                      color: glowColor.withOpacity(glowIntensity * 0.2),
                      blurRadius: spreadRadius * 3,
                      spreadRadius: spreadRadius,
                    ),
                  ],
                ),
                child: child,
              ),
            );
          },
          child: widget.child,
        ),
      ),
    );
  }
}
