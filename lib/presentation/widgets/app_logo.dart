import 'dart:math';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// 应用 Logo 图标 - 心形 + 问号
/// 用于启动页、首页、应用图标等，确保一致性
class AppLogoIcon extends StatelessWidget {
  final double size;
  final Color color;

  const AppLogoIcon({
    super.key,
    this.size = 50,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _AppLogoPainter(color: color),
    );
  }
}

/// Logo 绘制器 - 心形轮廓 + 中心问号
class _AppLogoPainter extends CustomPainter {
  final Color color;

  _AppLogoPainter({this.color = Colors.white});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final scale = size.width / 50; // 基于 50x50 的基准尺寸缩放

    // 绘制心形轮廓
    final heartPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5 * scale
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final heartPath = Path();
    final heartSize = 18 * scale;
    
    heartPath.moveTo(center.dx, center.dy + heartSize * 0.7);
    // 左侧弧线
    heartPath.cubicTo(
      center.dx - heartSize * 1.1, center.dy + heartSize * 0.2,
      center.dx - heartSize * 0.9, center.dy - heartSize * 0.8,
      center.dx, center.dy - heartSize * 0.4,
    );
    // 右侧弧线
    heartPath.cubicTo(
      center.dx + heartSize * 0.9, center.dy - heartSize * 0.8,
      center.dx + heartSize * 1.1, center.dy + heartSize * 0.2,
      center.dx, center.dy + heartSize * 0.7,
    );
    
    canvas.drawPath(heartPath, heartPaint);

    // 绘制中心的问号
    final questionPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.8 * scale
      ..strokeCap = StrokeCap.round;

    final qSize = 6 * scale;
    final questionPath = Path();
    
    questionPath.moveTo(center.dx - qSize * 0.6, center.dy - qSize * 0.3);
    questionPath.quadraticBezierTo(
      center.dx - qSize * 0.6, center.dy - qSize * 1.2,
      center.dx + qSize * 0.3, center.dy - qSize * 1.2,
    );
    questionPath.quadraticBezierTo(
      center.dx + qSize * 1.2, center.dy - qSize * 1.2,
      center.dx + qSize * 1.2, center.dy - qSize * 0.3,
    );
    questionPath.quadraticBezierTo(
      center.dx + qSize * 1.2, center.dy + qSize * 0.3,
      center.dx + qSize * 0.3, center.dy + qSize * 0.6,
    );
    questionPath.lineTo(center.dx + qSize * 0.3, center.dy + qSize * 1.0);
    
    canvas.drawPath(questionPath, questionPaint);

    // 问号下面的点
    final dotPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
      Offset(center.dx + qSize * 0.3, center.dy + qSize * 1.8), 
      2.8 * scale, 
      dotPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _AppLogoPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

/// 带容器的 Logo Widget - 用于首页侧边栏等
class AppLogoContainer extends StatelessWidget {
  final double size;
  final double iconSize;
  final double borderRadius;

  const AppLogoContainer({
    super.key,
    this.size = 64,
    this.iconSize = 32,
    this.borderRadius = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: LinearGradient(
          colors: [
            AppColors.neonCyan.withOpacity(0.9),
            AppColors.neonPurple.withOpacity(0.9),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.neonCyan.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: AppLogoIcon(size: iconSize),
      ),
    );
  }
}

/// 带动画效果的 Logo - 用于首页头部
class AnimatedAppLogo extends StatelessWidget {
  final double size;
  final Animation<double> pulseAnimation;

  const AnimatedAppLogo({
    super.key,
    this.size = 48,
    required this.pulseAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pulseAnimation,
      builder: (context, child) {
        final breathValue = sin(pulseAnimation.value * 2 * pi);
        final scale = 1.0 + breathValue * 0.15;
        final glowIntensity = 0.5 + breathValue * 0.3;
        
        return Transform.scale(
          scale: scale,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              gradient: LinearGradient(
                colors: [
                  AppColors.neonCyan.withOpacity(0.9),
                  AppColors.neonPurple.withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.neonCyan.withOpacity(glowIntensity),
                  blurRadius: 18 + breathValue * 15,
                  spreadRadius: 2 + breathValue * 4,
                ),
                BoxShadow(
                  color: AppColors.neonPurple.withOpacity(glowIntensity * 0.8),
                  blurRadius: 28 + breathValue * 20,
                  spreadRadius: 4 + breathValue * 5,
                ),
                BoxShadow(
                  color: AppColors.neonPink.withOpacity(glowIntensity * 0.6),
                  blurRadius: 38 + breathValue * 25,
                  spreadRadius: 6 + breathValue * 6,
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // 脉冲边框
                Container(
                  width: size * 0.83,
                  height: size * 0.83,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.5 + breathValue * 0.3),
                      width: 1.5 + breathValue * 0.5,
                    ),
                  ),
                ),
                // 中心图标
                Transform.scale(
                  scale: 1.0 + breathValue * 0.08,
                  child: AppLogoIcon(size: size * 0.5),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
