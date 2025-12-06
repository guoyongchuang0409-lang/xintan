import 'dart:math';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class MysticBackground extends StatefulWidget {
  final Widget child;
  final Color? primaryColor;
  final Color? secondaryColor;

  const MysticBackground({
    super.key,
    required this.child,
    this.primaryColor,
    this.secondaryColor,
  });

  @override
  State<MysticBackground> createState() => _MysticBackgroundState();
}

class _MysticBackgroundState extends State<MysticBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Particle> _particles = [];
  final List<_FloatingOrb> _orbs = [];
  final List<_LightRay> _lightRays = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    // 生成粒子 - 星空效果
    for (int i = 0; i < 60; i++) {
      _particles.add(_Particle(
        x: _random.nextDouble(),
        y: _random.nextDouble(),
        size: _random.nextDouble() * 3 + 0.5,
        speed: _random.nextDouble() * 0.4 + 0.1,
        opacity: _random.nextDouble() * 0.7 + 0.2,
      ));
    }
    
    // 生成漂浮光球
    for (int i = 0; i < 6; i++) {
      _orbs.add(_FloatingOrb(
        x: _random.nextDouble(),
        y: _random.nextDouble(),
        size: _random.nextDouble() * 100 + 50,
        speedX: (_random.nextDouble() - 0.5) * 0.12,
        speedY: (_random.nextDouble() - 0.5) * 0.12,
        colorIndex: i % 4,
      ));
    }
    
    // 生成光线
    for (int i = 0; i < 4; i++) {
      _lightRays.add(_LightRay(
        startX: _random.nextDouble(),
        startY: _random.nextDouble(),
        angle: _random.nextDouble() * 2 * pi,
        length: _random.nextDouble() * 0.4 + 0.2,
        speed: _random.nextDouble() * 0.25 + 0.15,
      ));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primary = widget.primaryColor ?? AppColors.neonCyan;
    final secondary = widget.secondaryColor ?? AppColors.neonPurple;

    return Stack(
      children: [
        // 多层渐变背景
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.topRight,
              radius: 1.8,
              colors: [
                Color.lerp(AppColors.background, primary, 0.18)!,
                AppColors.background,
                Color.lerp(AppColors.background, secondary, 0.15)!,
              ],
            ),
          ),
        ),
        
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.bottomLeft,
              radius: 1.5,
              colors: [
                Color.lerp(AppColors.background, AppColors.neonPink, 0.12)!,
                Colors.transparent,
              ],
            ),
          ),
        ),
        
        // 网格线效果
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              size: Size.infinite,
              painter: _GridPainter(
                progress: _controller.value,
                color: primary,
              ),
            );
          },
        ),
        
        // 漂浮光球
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              size: Size.infinite,
              painter: _OrbPainter(
                orbs: _orbs,
                progress: _controller.value,
              ),
            );
          },
        ),
        
        // 光线追踪效果
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              size: Size.infinite,
              painter: _LightRayPainter(
                lightRays: _lightRays,
                progress: _controller.value,
                color: primary,
              ),
            );
          },
        ),
        
        // 粒子效果（星空）
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              size: Size.infinite,
              painter: _ParticlePainter(
                particles: _particles,
                progress: _controller.value,
                color: primary,
              ),
            );
          },
        ),
        
        // 扫描线动画效果（放在最上层）
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              size: Size.infinite,
              painter: _ScanLinePainter(
                progress: _controller.value,
                color: primary,
              ),
            );
          },
        ),

        // 内容
        widget.child,
      ],
    );
  }
}

class _Particle {
  double x;
  double y;
  final double size;
  final double speed;
  final double opacity;

  _Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.opacity,
  });
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final double progress;
  final Color color;

  _ParticlePainter({
    required this.particles,
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final particle in particles) {
      // 更新粒子位置，添加上下波动
      final y = (particle.y - progress * particle.speed) % 1.0;
      final x = particle.x + sin(progress * 2 * pi + particle.y * 10) * 0.02;

      final paint = Paint()
        ..color = color.withOpacity(particle.opacity * (0.7 + sin(progress * 2 * pi + particle.x * 5) * 0.3))
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
      
      // 画光晕
      final glowPaint = Paint()
        ..color = color.withOpacity(particle.opacity * 0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

      final position = Offset(x * size.width, y * size.height);
      
      // 画光晕
      canvas.drawCircle(position, particle.size * 2, glowPaint);
      // 画粒子
      canvas.drawCircle(position, particle.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

// 扫描线 - 扫描效果
class _ScanLinePainter extends CustomPainter {
  final double progress;
  final Color color;

  _ScanLinePainter({
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.15)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    // 画扫描线
    final y = size.height * progress;
    
    // 画扫描线
    canvas.drawLine(
      Offset(0, y),
      Offset(size.width, y),
      paint,
    );
    
    // 画扫描线的渐变效果
    final gradientPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.transparent,
          color.withOpacity(0.1),
          color.withOpacity(0.2),
          color.withOpacity(0.1),
          Colors.transparent,
        ],
        stops: const [0.0, 0.3, 0.5, 0.7, 1.0],
      ).createShader(Rect.fromLTWH(0, y - 20, size.width, 40));
    
    canvas.drawRect(
      Rect.fromLTWH(0, y - 20, size.width, 40),
      gradientPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _ScanLinePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

// 网格绘制器 - 赛博空间效果
class _GridPainter extends CustomPainter {
  final double progress;
  final Color color;

  _GridPainter({
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.08)
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    const gridSize = 50.0;
    final offset = (progress * gridSize) % gridSize;

    // 绘制垂直线
    for (double x = -gridSize + offset; x < size.width + gridSize; x += gridSize) {
      final path = Path();
      path.moveTo(x, 0);
      path.lineTo(x, size.height);
      canvas.drawPath(path, paint);
    }

    // 绘制水平线
    for (double y = -gridSize + offset; y < size.height + gridSize; y += gridSize) {
      final path = Path();
      path.moveTo(0, y);
      path.lineTo(size.width, y);
      canvas.drawPath(path, paint);
    }
    
    // 绘制交叉点光晕
    final pointPaint = Paint()
      ..color = color.withOpacity(0.15)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    
    for (double x = -gridSize + offset; x < size.width + gridSize; x += gridSize * 2) {
      for (double y = -gridSize + offset; y < size.height + gridSize; y += gridSize * 2) {
        final intensity = (sin(progress * 2 * pi + x * 0.01 + y * 0.01) + 1) / 2;
        canvas.drawCircle(
          Offset(x, y),
          2 + intensity * 2,
          pointPaint..color = color.withOpacity(0.1 + intensity * 0.2),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

// 漂浮光球
class _FloatingOrb {
  double x;
  double y;
  final double size;
  final double speedX;
  final double speedY;
  final int colorIndex;

  _FloatingOrb({
    required this.x,
    required this.y,
    required this.size,
    required this.speedX,
    required this.speedY,
    required this.colorIndex,
  });
}

// 光球绘制器
class _OrbPainter extends CustomPainter {
  final List<_FloatingOrb> orbs;
  final double progress;

  _OrbPainter({
    required this.orbs,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final colors = [
      AppColors.neonCyan,
      AppColors.neonPurple,
      AppColors.neonPink,
      AppColors.neonBlue,
    ];

    for (final orb in orbs) {
      // 更新位置
      orb.x = (orb.x + orb.speedX * 0.01) % 1.0;
      orb.y = (orb.y + orb.speedY * 0.01) % 1.0;
      
      if (orb.x < 0) orb.x += 1.0;
      if (orb.y < 0) orb.y += 1.0;

      final color = colors[orb.colorIndex];
      final position = Offset(orb.x * size.width, orb.y * size.height);
      final pulseSize = orb.size * (1 + sin(progress * 2 * pi + orb.x * 10) * 0.15);

      // 绘制光球的多层光晕
      final gradientPaint = Paint()
        ..shader = RadialGradient(
          colors: [
            color.withOpacity(0.25),
            color.withOpacity(0.15),
            color.withOpacity(0.08),
            color.withOpacity(0.03),
            Colors.transparent,
          ],
          stops: const [0.0, 0.3, 0.5, 0.7, 1.0],
        ).createShader(Rect.fromCircle(center: position, radius: pulseSize));

      canvas.drawCircle(position, pulseSize, gradientPaint);
      
      // 核心发光点
      final corePaint = Paint()
        ..color = color.withOpacity(0.4)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
      
      canvas.drawCircle(position, pulseSize * 0.3, corePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _OrbPainter oldDelegate) {
    return true; // 总是重绘以更新位置
  }
}

// 光线
class _LightRay {
  double startX;
  double startY;
  final double angle;
  final double length;
  final double speed;

  _LightRay({
    required this.startX,
    required this.startY,
    required this.angle,
    required this.length,
    required this.speed,
  });
}

// 光线绘制器
class _LightRayPainter extends CustomPainter {
  final List<_LightRay> lightRays;
  final double progress;
  final Color color;

  _LightRayPainter({
    required this.lightRays,
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final ray in lightRays) {
      // 更新光线位置
      ray.startX = (ray.startX + cos(ray.angle) * ray.speed * 0.01) % 1.0;
      ray.startY = (ray.startY + sin(ray.angle) * ray.speed * 0.01) % 1.0;
      
      if (ray.startX < 0) ray.startX += 1.0;
      if (ray.startY < 0) ray.startY += 1.0;

      final start = Offset(ray.startX * size.width, ray.startY * size.height);
      final end = Offset(
        start.dx + cos(ray.angle) * ray.length * size.width,
        start.dy + sin(ray.angle) * ray.length * size.height,
      );

      // 绘制光线渐变
      final paint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            color.withOpacity(0.0),
            color.withOpacity(0.3),
            color.withOpacity(0.5),
            color.withOpacity(0.3),
            color.withOpacity(0.0),
          ],
        ).createShader(Rect.fromPoints(start, end))
        ..strokeWidth = 2
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4)
        ..strokeCap = StrokeCap.round;

      canvas.drawLine(start, end, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _LightRayPainter oldDelegate) {
    return true;
  }
}




