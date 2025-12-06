import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_theme.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_animations.dart';
import '../main.dart';
import '../presentation/providers/quiz_provider.dart';
import '../presentation/providers/report_provider.dart';
import '../presentation/providers/settings_provider.dart';
import '../presentation/pages/home_page.dart';
import '../presentation/pages/quiz_detail_page.dart';
import '../presentation/pages/quiz_test_page.dart';
import '../presentation/pages/report_page.dart';
import '../presentation/pages/history_page.dart';
import '../presentation/pages/settings_page.dart';
class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => QuizProvider()),
        ChangeNotifierProvider(create: (_) => ReportProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
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
        return AppAnimations.createPageRoute(
          page: const SettingsPage(),
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

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  String? _errorMessage;
  bool _isInitializing = true;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _initializeApp();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: AppAnimations.slow,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: AppAnimations.smoothCurve,
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: AppAnimations.defaultCurve,
      ),
    );

    _animationController.forward();
  }

  Future<void> _initializeApp() async {
    try {
      // 初始化化应用（数据库和设置
      await AppInitializer.initialize();
      
      // 加载设置
      if (mounted) {
        final settingsProvider = context.read<SettingsProvider>();
        await settingsProvider.loadSettings();
      }
      
      // 确保最少显示启动页1秒，最
      await Future.delayed(const Duration(milliseconds: 800));
      
      if (mounted) {
        setState(() {
          _isInitializing = false;
        });
        
        // 导航到首
        await Future.delayed(const Duration(milliseconds: 200));
        if (mounted) {
          Navigator.of(context).pushReplacementNamed('/');
        }
      }
    } catch (e) {
      debugPrint('Initialization error: $e');
      if (mounted) {
        setState(() {
          _errorMessage = '初始化化失败，请重试试';
          _isInitializing = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: child,
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 应用图标/Logo
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColors.primaryGradient,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.neonCyan.withOpacity(0.4),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // 外圈装饰
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 2,
                        ),
                      ),
                    ),
                    // 中心图标 - 心形与探索
                    CustomPaint(
                      size: const Size(50, 50),
                      painter: _HeartQuestionPainter(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // 应用名称
              ShaderMask(
                shaderCallback: (bounds) => AppColors.neonGradient.createShader(bounds),
                child: const Text(
                  '心探',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '探索内心的真实自我',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 48),
              // 加载指示器或错误信息
              if (_errorMessage != null) ...[
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
                  child: const Text('重试试'),
                ),
              ] else if (_isInitializing) ...[
                SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.neonCyan.withOpacity(0.8),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  '正在加载...',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textMuted.withOpacity(0.8),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// 心形与问号的自定义绘制
 class _HeartQuestionPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);

    // 绘制心形轮廓
    final heartPath = Path();
    // 左侧弧线
    heartPath.moveTo(center.dx, center.dy + 12);
    heartPath.cubicTo(
      center.dx - 18, center.dy + 4,
      center.dx - 15, center.dy - 14,
      center.dx, center.dy - 8,
    );
    // 右侧弧线
    heartPath.cubicTo(
      center.dx + 15, center.dy - 14,
      center.dx + 18, center.dy + 4,
      center.dx, center.dy + 12,
    );
    
    canvas.drawPath(heartPath, paint);

    // 绘制中心的问号（象征探索）
    final questionPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    final questionPath = Path();
    questionPath.moveTo(center.dx - 4, center.dy - 5);
    questionPath.quadraticBezierTo(
      center.dx - 4, center.dy - 10,
      center.dx + 2, center.dy - 10,
    );
    questionPath.quadraticBezierTo(
      center.dx + 8, center.dy - 10,
      center.dx + 8, center.dy - 5,
    );
    questionPath.quadraticBezierTo(
      center.dx + 8, center.dy - 1,
      center.dx + 2, center.dy + 2,
    );
    questionPath.lineTo(center.dx + 2, center.dy + 4);
    
    canvas.drawPath(questionPath, questionPaint);

    // 问号下面的点
    final dotPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(center.dx + 2, center.dy + 8), 2.5, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
