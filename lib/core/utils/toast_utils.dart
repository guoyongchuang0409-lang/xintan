import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ToastUtils {
  static OverlayEntry? _currentToast;

  static void showToast(
    BuildContext context,
    String message, {
    Color? backgroundColor,
    Duration duration = const Duration(seconds: 3),
    IconData? icon,
  }) {
    _currentToast?.remove();
    _currentToast = null;

    final overlay = Overlay.of(context);

    _currentToast = OverlayEntry(
      builder: (context) => _PortalToast(
        message: message,
        primaryColor: backgroundColor ?? const Color(0xFF9D4EDD),
        icon: icon,
      ),
    );

    overlay.insert(_currentToast!);

    Future.delayed(duration, () {
      _currentToast?.remove();
      _currentToast = null;
    });
  }

  static void showSuccess(BuildContext context, String message) {
    showToast(
      context,
      message,
      backgroundColor: const Color(0xFF9D4EDD), // 紫色
      icon: Icons.stars_rounded,
    );
  }

  static void showError(BuildContext context, String message) {
    showToast(
      context,
      message,
      backgroundColor: const Color(0xFFFF6B6B),
      icon: Icons.close_rounded,
    );
  }

  static void showInfo(BuildContext context, String message) {
    showToast(
      context,
      message,
      backgroundColor: const Color(0xFF4ECDC4),
      icon: Icons.lightbulb_outline_rounded,
    );
  }

  static void showWarning(BuildContext context, String message) {
    showToast(
      context,
      message,
      backgroundColor: const Color(0xFFFFBE0B),
      icon: Icons.priority_high_rounded,
    );
  }
}

class _PortalToast extends StatefulWidget {
  final String message;
  final Color primaryColor;
  final IconData? icon;

  const _PortalToast({
    required this.message,
    required this.primaryColor,
    this.icon,
  });

  @override
  State<_PortalToast> createState() => _PortalToastState();
}

class _PortalToastState extends State<_PortalToast>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _rotateController;
  late AnimationController _particleController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  final List<_EnergyOrb> _orbs = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();

    _mainController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _rotateController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();

    _particleController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _mainController, curve: Curves.elasticOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
      ),
    );

    _generateOrbs();
    _mainController.forward();

    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) _mainController.reverse();
    });
  }

  void _generateOrbs() {
    for (int i = 0; i < 6; i++) {
      _orbs.add(_EnergyOrb(
        angle: (i / 6) * 2 * pi,
        radius: 80 + _random.nextDouble() * 20,
        size: 4 + _random.nextDouble() * 4,
        speed: 0.8 + _random.nextDouble() * 0.4,
      ));
    }
  }

  @override
  void dispose() {
    _mainController.dispose();
    _rotateController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  Color get _glowColor {
    final hsl = HSLColor.fromColor(widget.primaryColor);
    return hsl.withLightness((hsl.lightness + 0.2).clamp(0.0, 1.0)).toColor();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: AnimatedBuilder(
          animation: Listenable.merge([_mainController, _rotateController, _particleController]),
          builder: (context, child) {
            return Opacity(
              opacity: _fadeAnimation.value,
              child: Center(
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: _buildPortal(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPortal() {
    return SizedBox(
      width: 280,
      height: 280,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 外圈光环
          _buildOuterRing(),
          // 能量球
          ..._buildEnergyOrbs(),
          // 内圈
          _buildInnerRing(),
          // 中心内容
          _buildCenterContent(),
        ],
      ),
    );
  }

  Widget _buildOuterRing() {
    return Transform.rotate(
      angle: _rotateController.value * 2 * pi,
      child: Container(
        width: 220,
        height: 220,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: widget.primaryColor.withValues(alpha: 0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: widget.primaryColor.withValues(alpha: 0.2),
              blurRadius: 30,
              spreadRadius: 5,
            ),
          ],
        ),
        child: CustomPaint(
          painter: _RuneCirclePainter(
            color: widget.primaryColor,
            progress: _rotateController.value,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildEnergyOrbs() {
    return _orbs.asMap().entries.map((entry) {
      final orb = entry.value;
      final progress = (_particleController.value * orb.speed) % 1.0;
      final angle = orb.angle + _rotateController.value * 2 * pi * 0.5;
      final pulseRadius = orb.radius + sin(progress * 2 * pi) * 10;

      return Positioned(
        left: 140 + cos(angle) * pulseRadius - orb.size / 2,
        top: 140 + sin(angle) * pulseRadius - orb.size / 2,
        child: Container(
          width: orb.size,
          height: orb.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _glowColor,
            boxShadow: [
              BoxShadow(
                color: widget.primaryColor.withValues(alpha: 0.8),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  Widget _buildInnerRing() {
    return Transform.rotate(
      angle: -_rotateController.value * 2 * pi * 0.3,
      child: Container(
        width: 160,
        height: 160,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: widget.primaryColor.withValues(alpha: 0.5),
            width: 2,
          ),
          gradient: RadialGradient(
            colors: [
              widget.primaryColor.withValues(alpha: 0.1),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCenterContent() {
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF1a1a2e),
        border: Border.all(
          color: widget.primaryColor.withValues(alpha: 0.8),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: widget.primaryColor.withValues(alpha: 0.5),
            blurRadius: 25,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.icon != null)
            Icon(
              widget.icon,
              color: _glowColor,
              size: 32,
            ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              widget.message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
                height: 1.3,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _RuneCirclePainter extends CustomPainter {
  final Color color;
  final double progress;

  _RuneCirclePainter({required this.color, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;

    final paint = Paint()
      ..color = color.withValues(alpha: 0.6)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // 绘制虚线圆弧
    const dashCount = 24;
    const dashAngle = (2 * pi) / dashCount;
    const gapRatio = 0.4;

    for (int i = 0; i < dashCount; i++) {
      final startAngle = i * dashAngle;
      final sweepAngle = dashAngle * (1 - gapRatio);

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }

    // 绘制小三角标记
    final trianglePaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 4; i++) {
      final angle = (i / 4) * 2 * pi - pi / 2;
      final x = center.dx + cos(angle) * radius;
      final y = center.dy + sin(angle) * radius;

      final path = Path();
      path.moveTo(x + cos(angle) * 6, y + sin(angle) * 6);
      path.lineTo(x + cos(angle + 2.5) * 4, y + sin(angle + 2.5) * 4);
      path.lineTo(x + cos(angle - 2.5) * 4, y + sin(angle - 2.5) * 4);
      path.close();

      canvas.drawPath(path, trianglePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _RuneCirclePainter oldDelegate) =>
      oldDelegate.progress != progress;
}

class _EnergyOrb {
  final double angle;
  final double radius;
  final double size;
  final double speed;

  _EnergyOrb({
    required this.angle,
    required this.radius,
    required this.size,
    required this.speed,
  });
}

void showToast(BuildContext context, String message, [Color? color]) {
  ToastUtils.showToast(context, message, backgroundColor: color);
}
