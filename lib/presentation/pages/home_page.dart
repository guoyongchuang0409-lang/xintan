import 'dart:math';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_animations.dart';
import '../../core/constants/quiz_data.dart';
import '../../core/services/sound_service.dart';
import '../../domain/models/quiz_type.dart';
import '../widgets/neon_card.dart';
import '../widgets/mystic_background.dart';
import 'history_page.dart';
import 'settings_page.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const _QuizTypeListPage(),
    const HistoryPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: MysticBackground(
        child: AnimatedSwitcher(
          duration: AppAnimations.normal,
          child: _pages[_currentIndex],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: AppColors.neonCyan.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, -2),
            spreadRadius: 2,
          ),
          BoxShadow(
            color: AppColors.neonPurple.withOpacity(0.1),
            blurRadius: 30,
            offset: const Offset(0, -4),
            spreadRadius: 4,
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                index: 0,
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                label: '首页',
              ),
              _buildNavItem(
                index: 1,
                icon: Icons.history_outlined,
                activeIcon: Icons.history,
                label: '历史',
              ),
              _buildNavItem(
                index: 2,
                icon: Icons.settings_outlined,
                activeIcon: Icons.settings,
                label: '设置',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
  }) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        SoundService.instance.playTap();
        if (!isSelected) {
          setState(() => _currentIndex = index);
        }
      },
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: AppAnimations.fast,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.neonCyan.withOpacity(0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.neonCyan.withOpacity(0.3),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              color: isSelected ? AppColors.neonCyan : AppColors.textMuted,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.neonCyan : AppColors.textMuted,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class _QuizTypeListPage extends StatefulWidget {
  const _QuizTypeListPage();

  @override
  State<_QuizTypeListPage> createState() => _QuizTypeListPageState();
}

class _QuizTypeListPageState extends State<_QuizTypeListPage>
    with TickerProviderStateMixin {
  late AnimationController _titleController;
  late AnimationController _logoController;
  late Animation<double> _titleAnimation;
  late Animation<double> _logoRotation;
  late Animation<double> _logoPulse;

  @override
  void initState() {
    super.initState();
    // 标题动画控制器
    _titleController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(); // 单向循环，不反向
    
    _titleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _titleController,
        curve: Curves.easeInOut,
      ),
    );
    
    // Logo动画控制器
    _logoController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();
    
    _logoRotation = Tween<double>(begin: 0.0, end: 2 * pi).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: Curves.linear,
      ),
    );
    
    _logoPulse = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final quizTypes = QuizData.getAllQuizTypes();

    return SafeArea(
      child: Column(
        children: [
          // 顶部 Logo 区域
          _buildHeader(),
          // 测试列表
          Expanded(
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                itemCount: quizTypes.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _QuizTypeCard(
                      quizType: quizTypes[index],
                      index: index,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return AnimatedBuilder(
      animation: _titleController,
      builder: (context, child) {
        final progress = _titleController.value;
        // 让progress从-0.2到1.2循环，确保光带从左侧外到右侧外
        final normalizedProgress = (progress * 1.4) % 1.4 - 0.2;
        
        return Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                AppColors.surface,
                Color.lerp(AppColors.surface, AppColors.neonCyan, 0.15)!,
                Color.lerp(AppColors.surface, AppColors.neonPurple, 0.18)!,
                Color.lerp(AppColors.surface, AppColors.neonPink, 0.15)!,
                AppColors.surface,
              ],
              stops: [
                (normalizedProgress - 0.2).clamp(0.0, 1.0),
                (normalizedProgress - 0.1).clamp(0.0, 1.0),
                normalizedProgress.clamp(0.0, 1.0),
                (normalizedProgress + 0.1).clamp(0.0, 1.0),
                (normalizedProgress + 0.2).clamp(0.0, 1.0),
              ],
            ),
          ),
          child: Row(
            children: [
              // Logo 在左
              _buildLogo(),
              // 标题居中
              Expanded(
                child: Column(
                  children: [
                    // 主标题
                    _buildSimpleTitle(progress),
                    const SizedBox(height: 6),
                    // 副标题
                    _buildEnhancedSubtitle(progress, sin(progress * 2 * pi)),
                  ],
                ),
              ),
              // 右侧占位，保持标题居中
              const SizedBox(width: 48),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLogo() {
    return AnimatedBuilder(
      animation: _logoController,
      builder: (context, child) {
        // 呼吸效果 - 使用sin波形实现平滑的缩放
        final breathValue = sin(_logoPulse.value * 2 * pi);
        final scale = 1.0 + breathValue * 0.15; // 0.85 - 1.15 的缩放范围
        final glowIntensity = 0.5 + breathValue * 0.3; // 光晕强度跟随呼吸
        
        return Transform.scale(
          scale: scale,
          child: Container(
            width: 48,
            height: 48,
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
                // 内层青色光晕
                BoxShadow(
                  color: AppColors.neonCyan.withOpacity(glowIntensity),
                  blurRadius: 18 + breathValue * 15,
                  spreadRadius: 2 + breathValue * 4,
                ),
                // 中层紫色光晕
                BoxShadow(
                  color: AppColors.neonPurple.withOpacity(glowIntensity * 0.8),
                  blurRadius: 28 + breathValue * 20,
                  spreadRadius: 4 + breathValue * 5,
                ),
                // 外层粉色光晕
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
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.5 + breathValue * 0.3),
                      width: 1.5 + breathValue * 0.5,
                    ),
                  ),
                ),
                // 中心图标，随呼吸轻微缩放
                Transform.scale(
                  scale: 1.0 + breathValue * 0.08,
                  child: CustomPaint(
                    size: const Size(24, 24),
                    painter: _LogoPainter(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // 简化的主标题（不再单独渐变）
  Widget _buildSimpleTitle(double progress) {
    final pulse = sin(progress * 2 * pi);
    
    return Stack(
      alignment: Alignment.center,
      children: [
        // 底层发光边框
        Text(
          '心探',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 4
              ..color = AppColors.neonCyan.withOpacity(0.3 + pulse * 0.2)
              ..maskFilter = MaskFilter.blur(BlurStyle.normal, 8 + pulse * 4),
          ),
        ),
        // 主体文字（纯白色）
        const Text(
          '心探',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 2,
            shadows: [
              Shadow(
                color: Colors.white,
                blurRadius: 10,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 增强的副标题
  Widget _buildEnhancedSubtitle(double progress, double pulse) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // 底层光晕
        Text(
          '探索内心的真实自我',
          style: TextStyle(
            fontSize: 11,
            letterSpacing: 1.5,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 3
              ..color = AppColors.neonCyan.withOpacity(0.3 + pulse * 0.15)
              ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
          ),
        ),
        // 主体文字
        Opacity(
          opacity: 0.85 + pulse * 0.15,
          child: ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [
                AppColors.textSecondary,
                AppColors.neonCyan.withOpacity(0.9),
                AppColors.neonPurple.withOpacity(0.8),
                AppColors.textSecondary,
              ],
              stops: [
                0.0,
                0.3 + sin(progress * 3 * pi) * 0.2,
                0.6 + cos(progress * 3 * pi) * 0.2,
                1.0,
              ],
            ).createShader(bounds),
            child: const Text(
              '探索内心的真实自我',
              style: TextStyle(
                fontSize: 11,
                color: Colors.white,
                letterSpacing: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
class _LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);

    // 绘制心形轮廓
    final heartPath = Path();
    // 左侧弧线
    heartPath.moveTo(center.dx, center.dy + 6);
    heartPath.cubicTo(
      center.dx - 10, center.dy + 2,
      center.dx - 8, center.dy - 8,
      center.dx, center.dy - 4,
    );
    // 右侧弧线
    heartPath.cubicTo(
      center.dx + 8, center.dy - 8,
      center.dx + 10, center.dy + 2,
      center.dx, center.dy + 6,
    );
    
    canvas.drawPath(heartPath, paint);

    // 绘制中心的问号（象征探索）
    final questionPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    final questionPath = Path();
    questionPath.moveTo(center.dx - 2, center.dy - 3);
    questionPath.quadraticBezierTo(
      center.dx - 2, center.dy - 6,
      center.dx + 1, center.dy - 6,
    );
    questionPath.quadraticBezierTo(
      center.dx + 4, center.dy - 6,
      center.dx + 4, center.dy - 3,
    );
    questionPath.quadraticBezierTo(
      center.dx + 4, center.dy - 1,
      center.dx + 1, center.dy,
    );
    questionPath.lineTo(center.dx + 1, center.dy + 1);
    
    canvas.drawPath(questionPath, questionPaint);

    // 问号下面的点
    final dotPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(center.dx + 1, center.dy + 3), 1.2, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
class _QuizTypeCard extends StatefulWidget {
  final QuizType quizType;
  final int index;

  const _QuizTypeCard({
    required this.quizType,
    required this.index,
  });

  @override
  State<_QuizTypeCard> createState() => _QuizTypeCardState();
}

class _QuizTypeCardState extends State<_QuizTypeCard>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _pulseController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: AppAnimations.normal,
      vsync: this,
    );
    
    // 脉冲动画控制器
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: AppAnimations.defaultCurve,
      ),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: AppAnimations.defaultCurve,
      ),
    );
    
    _pulseAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
    );

    Future.delayed(Duration(milliseconds: 80 * widget.index), () {
      if (mounted) {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  Color _getCardColor() {
    final colors = [
      AppColors.neonPink,
      AppColors.neonCyan,
      AppColors.neonPurple,
      AppColors.neonGreen,
      AppColors.neonBlue,
      AppColors.neonOrange,
    ];
    return colors[widget.index % colors.length];
  }

  IconData _getQuizIcon() {
    switch (widget.quizType.id) {
      case 'female_desire':
        return Icons.favorite;
      case 'female_m':
        return Icons.female;
      case 'male_m':
        return Icons.male;
      case 'cuckold':
        return Icons.favorite_border;
      case 'male_s':
        return Icons.shield_outlined;
      case 'female_s':
        return Icons.shield;
      default:
        return Icons.quiz;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cardColor = _getCardColor();
    final totalItems = widget.quizType.categories.fold<int>(
      0,
      (sum, category) => sum + category.items.length,
    );

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: NeonCard(
          borderColor: cardColor,
          onTap: () => _navigateToQuizDetail(context),
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              // Icon container with pulse effect
              AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (context, child) {
                  return Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: cardColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: cardColor.withOpacity(0.3 + _pulseAnimation.value * 0.2),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: cardColor.withOpacity(0.2 + _pulseAnimation.value * 0.3),
                          blurRadius: 8 + _pulseAnimation.value * 8,
                          spreadRadius: _pulseAnimation.value * 3,
                        ),
                      ],
                    ),
                    child: Icon(
                      _getQuizIcon(),
                      color: cardColor,
                      size: 26,
                    ),
                  );
                },
              ),
              const SizedBox(width: 12),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.quizType.name,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.quizType.description,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        _buildInfoChip(
                          icon: Icons.category_outlined,
                          label: '${widget.quizType.categories.length}分类',
                          color: cardColor,
                        ),
                        const SizedBox(width: 8),
                        _buildInfoChip(
                          icon: Icons.list_alt_outlined,
                          label: '$totalItems项',
                          color: cardColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: cardColor.withOpacity(0.7),
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 12),
          const SizedBox(width: 3),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToQuizDetail(BuildContext context) {
    SoundService.instance.playButton();
    Navigator.pushNamed(
      context,
      '/quiz-detail',
      arguments: widget.quizType,
    );
  }
}
