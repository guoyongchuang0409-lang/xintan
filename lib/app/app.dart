import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_theme.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_animations.dart';
import '../main.dart';
import '../presentation/providers/quiz_provider.dart';
import '../presentation/providers/report_provider.dart';
import '../presentation/providers/settings_provider.dart';
import '../presentation/providers/user_profile_provider.dart';
import '../presentation/pages/home_page.dart';
import '../presentation/pages/quiz_detail_page.dart';
import '../presentation/pages/quiz_test_page.dart';
import '../presentation/pages/report_page.dart';
import '../presentation/pages/history_page.dart';
import '../presentation/pages/profile_page.dart';
class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => QuizProvider()),
        ChangeNotifierProvider(create: (_) => ReportProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(create: (_) => UserProfileProvider()),
      ],
      child: MaterialApp(
        title: '心探',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        initialRoute: '/splash',
        onGenerateRoute: _generateRoute,
      ),
    );
  }
  Route<dynamic>? _generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/splash':
        // 启动页使用淡入效
        return AppAnimations.createFadeRoute(
          page: const SplashPage(),
          settings: settings,
        );
      case '/':
        // 首页使用淡入效果
        return AppAnimations.createFadeRoute(
          page: const HomePage(),
          settings: settings,
        );
      case '/quiz-detail':
        return AppAnimations.createPageRoute(
          page: const QuizDetailPage(),
          settings: settings,
        );
      case '/quiz-test':
        return AppAnimations.createPageRoute(
          page: const QuizTestPage(),
          settings: settings,
        );
      case '/report':
        // 报告页面使用从底部滑入效
        return AppAnimations.createPageRoute(
          page: const ReportPage(),
          settings: settings,
          direction: SlideDirection.bottomToTop,
        );
      case '/history':
        return AppAnimations.createPageRoute(
          page: const HistoryPage(),
          settings: settings,
        );
      case '/settings':
      case '/profile':
        return AppAnimations.createPageRoute(
          page: const ProfilePage(),
          settings: settings,
        );
      default:
        return AppAnimations.createFadeRoute(
          page: const HomePage(),
          settings: settings,
        );
    }
  }
}
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _pulseController;
  late AnimationController _rotateController;
  late AnimationController _particleController;
  
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _titleSlideAnimation;
  late Animation<double> _subtitleFadeAnimation;
  
  String? _errorMessage;
  bool _isInitializing = true;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _initializeApp();
  }

  void _setupAnimations() {
    // 主动画控制器
    _mainController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    // 脉冲动画
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    // 旋转动画
    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    // 粒子动画
    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
      ),
    );

    _titleSlideAnimation = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.3, 0.7, curve: Curves.easeOut),
      ),
    );

    _subtitleFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );

    _mainController.forward();
  }

  Future<void> _initializeApp() async {
    try {
      await AppInitializer.initialize();
      
      if (mounted) {
        final settingsProvider = context.read<SettingsProvider>();
        await settingsProvider.loadSettings();
      }
      
      // 停留3秒
      await Future.delayed(const Duration(seconds: 3));
      
      if (mounted) {
        setState(() {
          _isInitializing = false;
        });
        
        if (mounted) {
          Navigator.of(context).pushReplacementNamed('/');
        }
      }
    } catch (e) {
      debugPrint('Initialization error: $e');
      if (mounted) {
        setState(() {
          _errorMessage = '初始化失败，请重试';
          _isInitializing = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _mainController.dispose();
    _pulseController.dispose();
    _rotateController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // 背景粒子效果
          _buildParticleBackground(),
          // 科技感网格背景
          _buildTechGrid(),
          // 主内容
          Center(
            child: AnimatedBuilder(
              animation: _mainController,
              builder: (context, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 玄幻符文区域
                    _buildMysticRunes(),
                    const SizedBox(height: 40),
                    // 标题
                    _buildAnimatedTitle(),
                    const SizedBox(height: 12),
                    // 副标题
                    _buildAnimatedSubtitle(),
                    const SizedBox(height: 60),
                    // 加载指示器
                    _buildLoadingIndicator(),
                  ],
                );
              },
            ),
          ),
          // 顶部装饰线
          _buildTopDecoration(),
          // 底部装饰线
          _buildBottomDecoration(),
        ],
      ),
    );
  }

  Widget _buildParticleBackground() {
    return AnimatedBuilder(
      animation: _particleController,
      builder: (context, child) {
        return CustomPaint(
          size: MediaQuery.of(context).size,
          painter: _ParticlePainter(
            progress: _particleController.value,
          ),
        );
      },
    );
  }

  Widget _buildTechGrid() {
    return Opacity(
      opacity: 0.1,
      child: CustomPaint(
        size: MediaQuery.of(context).size,
        painter: _TechGridPainter(),
      ),
    );
  }

  // 玄幻风格的神秘符文动画
  Widget _buildMysticRunes() {
    return AnimatedBuilder(
      animation: Listenable.merge([_pulseController, _rotateController]),
      builder: (context, child) {
        final pulse = _pulseController.value;
        final rotation = _rotateController.value * 2 * pi;
        
        return FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: SizedBox(
              width: 200,
              height: 200,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // 最外层 - 神秘符文圆环
                  Transform.rotate(
                    angle: rotation * 0.3,
                    child: CustomPaint(
                      size: const Size(200, 200),
                      painter: _MysticRunePainter(
                        progress: pulse,
                        color: AppColors.neonCyan,
                      ),
                    ),
                  ),
                  // 中层 - 反向旋转的能量环
                  Transform.rotate(
                    angle: -rotation * 0.5,
                    child: CustomPaint(
                      size: const Size(160, 160),
                      painter: _EnergyRingPainter(
                        progress: pulse,
                        color: AppColors.neonPurple,
                      ),
                    ),
                  ),
                  // 内层 - 脉冲核心
                  Transform.rotate(
                    angle: rotation * 0.8,
                    child: CustomPaint(
                      size: const Size(120, 120),
                      painter: _PulseCorepainter(
                        progress: pulse,
                      ),
                    ),
                  ),
                  // 中心光晕
                  Container(
                    width: 60 + pulse * 20,
                    height: 60 + pulse * 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          AppColors.neonCyan.withOpacity(0.8 - pulse * 0.3),
                          AppColors.neonPurple.withOpacity(0.5 - pulse * 0.2),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.neonCyan.withOpacity(0.6 - pulse * 0.2),
                          blurRadius: 30 + pulse * 20,
                          spreadRadius: 5 + pulse * 10,
                        ),
                        BoxShadow(
                          color: AppColors.neonPink.withOpacity(0.4 - pulse * 0.1),
                          blurRadius: 50 + pulse * 30,
                          spreadRadius: 10 + pulse * 15,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedTitle() {
    return AnimatedBuilder(
      animation: Listenable.merge([_mainController, _pulseController]),
      builder: (context, child) {
        final pulse = _pulseController.value;
        final breathValue = sin(pulse * 2 * pi);
        final glowIntensity = 0.4 + breathValue * 0.3;
        final scale = 1.0 + breathValue * 0.03;
        
        // 渐变色动态偏移
        final gradientOffset = pulse;
        
        return Transform.translate(
          offset: Offset(0, _titleSlideAnimation.value),
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: Transform.scale(
              scale: scale,
              child: ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  begin: Alignment(-1.0 + gradientOffset * 2, 0),
                  end: Alignment(1.0 + gradientOffset * 2, 0),
                  colors: const [
                    AppColors.neonCyan,
                    AppColors.neonPurple,
                    AppColors.neonPink,
                    AppColors.neonCyan,
                  ],
                  stops: const [0.0, 0.33, 0.66, 1.0],
                ).createShader(bounds),
                child: Text(
                  '心探',
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 8,
                    shadows: [
                      Shadow(
                        color: AppColors.neonCyan.withOpacity(glowIntensity),
                        blurRadius: 20 + breathValue * 15,
                      ),
                      Shadow(
                        color: AppColors.neonPurple.withOpacity(glowIntensity * 0.8),
                        blurRadius: 30 + breathValue * 20,
                      ),
                      Shadow(
                        color: AppColors.neonPink.withOpacity(glowIntensity * 0.6),
                        blurRadius: 40 + breathValue * 25,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedSubtitle() {
    return AnimatedBuilder(
      animation: Listenable.merge([_subtitleFadeAnimation, _pulseController]),
      builder: (context, child) {
        final pulse = _pulseController.value;
        final breathValue = sin(pulse * 2 * pi);
        final opacity = 0.7 + breathValue * 0.15;
        
        // 字符逐个显示效果的模拟 - 通过透明度渐变
        final gradientOffset = pulse * 0.5;
        
        return Opacity(
          opacity: _subtitleFadeAnimation.value,
          child: ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              begin: Alignment(-1.5 + gradientOffset * 3, 0),
              end: Alignment(1.5 + gradientOffset * 3, 0),
              colors: [
                AppColors.neonCyan.withOpacity(opacity),
                AppColors.neonPurple.withOpacity(opacity),
                AppColors.neonPink.withOpacity(opacity),
                AppColors.neonCyan.withOpacity(opacity),
              ],
              stops: const [0.0, 0.33, 0.66, 1.0],
            ).createShader(bounds),
            child: Text(
              '探索内心的真实自我',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                letterSpacing: 4,
                fontWeight: FontWeight.w500,
                shadows: [
                  Shadow(
                    color: AppColors.neonCyan.withOpacity(0.3 + breathValue * 0.2),
                    blurRadius: 10 + breathValue * 8,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoadingIndicator() {
    if (_errorMessage != null) {
      return Column(
        children: [
          Text(
            _errorMessage!,
            style: const TextStyle(
              color: AppColors.error,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              setState(() {
                _errorMessage = null;
                _isInitializing = true;
              });
              _initializeApp();
            },
            child: const Text('重试'),
          ),
        ],
      );
    }
    
    if (_isInitializing) {
      return FadeTransition(
        opacity: _subtitleFadeAnimation,
        child: Column(
          children: [
            // 科技感加载条
            SizedBox(
              width: 200,
              child: AnimatedBuilder(
                animation: _pulseController,
                builder: (context, child) {
                  return Stack(
                    children: [
                      // 背景条
                      Container(
                        height: 2,
                        decoration: BoxDecoration(
                          color: AppColors.neonCyan.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                      // 动画进度条
                      AnimatedBuilder(
                        animation: _particleController,
                        builder: (context, child) {
                          return FractionallySizedBox(
                            widthFactor: _particleController.value,
                            child: Container(
                              height: 2,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    AppColors.neonCyan,
                                    AppColors.neonPurple,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(1),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.neonCyan.withOpacity(0.5),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'LOADING...',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textMuted,
                letterSpacing: 4,
              ),
            ),
          ],
        ),
      );
    }
    
    return const SizedBox.shrink();
  }

  Widget _buildTopDecoration() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.neonCyan.withOpacity(0.1),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomDecoration() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                AppColors.neonPurple.withOpacity(0.1),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// 粒子背景绘制
class _ParticlePainter extends CustomPainter {
  final double progress;
  
  _ParticlePainter({required this.progress});
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    
    // 绘制随机粒子
    for (int i = 0; i < 30; i++) {
      final x = (size.width * ((i * 37 + progress * 100) % 100) / 100);
      final y = (size.height * ((i * 53 + progress * 150) % 100) / 100);
      final opacity = ((i * 17 + progress * 200) % 100) / 200;
      final radius = 1.0 + (i % 3);
      
      paint.color = i % 2 == 0 
          ? AppColors.neonCyan.withOpacity(opacity)
          : AppColors.neonPurple.withOpacity(opacity);
      
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }
  
  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

// 科技网格绘制
class _TechGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.neonCyan.withOpacity(0.3)
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;
    
    const spacing = 40.0;
    
    // 绘制垂直线
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    
    // 绘制水平线
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// 神秘符文绘制器
class _MysticRunePainter extends CustomPainter {
  final double progress;
  final Color color;
  
  _MysticRunePainter({required this.progress, required this.color});
  
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 5;
    
    final paint = Paint()
      ..color = color.withOpacity(0.6 + progress * 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;
    
    // 绘制外圈符文
    const runeCount = 12;
    for (int i = 0; i < runeCount; i++) {
      final angle = (i / runeCount) * 2 * pi;
      final x = center.dx + radius * cos(angle);
      final y = center.dy + radius * sin(angle);
      
      // 绘制符文点
      canvas.drawCircle(Offset(x, y), 3 + progress * 2, paint);
      
      // 绘制连接线
      if (i % 2 == 0) {
        final nextAngle = ((i + 3) / runeCount) * 2 * pi;
        final nx = center.dx + radius * cos(nextAngle);
        final ny = center.dy + radius * sin(nextAngle);
        canvas.drawLine(Offset(x, y), Offset(nx, ny), paint..strokeWidth = 0.5);
      }
    }
    
    // 绘制外圈
    canvas.drawCircle(center, radius, paint..strokeWidth = 1);
  }
  
  @override
  bool shouldRepaint(covariant _MysticRunePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

// 能量环绘制器
class _EnergyRingPainter extends CustomPainter {
  final double progress;
  final Color color;
  
  _EnergyRingPainter({required this.progress, required this.color});
  
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 5;
    
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    
    // 绘制渐变能量弧
    const arcCount = 6;
    for (int i = 0; i < arcCount; i++) {
      final startAngle = (i / arcCount) * 2 * pi;
      final sweepAngle = pi / 4 + progress * pi / 8;
      
      paint.shader = SweepGradient(
        center: Alignment.center,
        startAngle: startAngle,
        endAngle: startAngle + sweepAngle,
        colors: [
          color.withOpacity(0.0),
          color.withOpacity(0.8),
          AppColors.neonPink.withOpacity(0.6),
          color.withOpacity(0.0),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
      
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
    
    // 绘制内圈虚线
    paint.shader = null;
    paint.color = color.withOpacity(0.3);
    paint.strokeWidth = 1;
    
    const dashCount = 24;
    for (int i = 0; i < dashCount; i++) {
      final angle = (i / dashCount) * 2 * pi;
      final innerRadius = radius * 0.85;
      final outerRadius = radius * 0.95;
      
      final x1 = center.dx + innerRadius * cos(angle);
      final y1 = center.dy + innerRadius * sin(angle);
      final x2 = center.dx + outerRadius * cos(angle);
      final y2 = center.dy + outerRadius * sin(angle);
      
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
    }
  }
  
  @override
  bool shouldRepaint(covariant _EnergyRingPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

// 脉冲核心绘制器
class _PulseCorepainter extends CustomPainter {
  final double progress;
  
  _PulseCorepainter({required this.progress});
  
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 5;
    
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    
    // 绘制六芒星
    paint.color = AppColors.neonCyan.withOpacity(0.7 + progress * 0.2);
    _drawHexagram(canvas, center, radius * 0.8, paint);
    
    // 绘制内三角
    paint.color = AppColors.neonPink.withOpacity(0.5 + progress * 0.3);
    _drawTriangle(canvas, center, radius * 0.5, paint, 0);
    
    // 绘制反向三角
    paint.color = AppColors.neonPurple.withOpacity(0.5 + progress * 0.3);
    _drawTriangle(canvas, center, radius * 0.5, paint, pi);
  }
  
  void _drawHexagram(Canvas canvas, Offset center, double radius, Paint paint) {
    // 正三角
    _drawTriangle(canvas, center, radius, paint, -pi / 2);
    // 倒三角
    _drawTriangle(canvas, center, radius, paint, pi / 2);
  }
  
  void _drawTriangle(Canvas canvas, Offset center, double radius, Paint paint, double rotation) {
    final path = Path();
    for (int i = 0; i < 3; i++) {
      final angle = rotation + (i / 3) * 2 * pi;
      final x = center.dx + radius * cos(angle);
      final y = center.dy + radius * sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }
  
  @override
  bool shouldRepaint(covariant _PulseCorepainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}


