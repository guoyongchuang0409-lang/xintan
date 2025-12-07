import 'dart:math';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_animations.dart';
import '../../core/constants/quiz_data.dart';
import '../../core/services/sound_service.dart';
import '../../core/utils/responsive_utils.dart';
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
    // 桌面端使用侧边栏布局
    if (ResponsiveUtils.shouldUseSideNav(context)) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: MysticBackground(
          child: Row(
            children: [
              _buildSideNavigation(),
              Expanded(
                child: AnimatedSwitcher(
                  duration: AppAnimations.normal,
                  child: _pages[_currentIndex],
                ),
              ),
            ],
          ),
        ),
      );
    }
    
    // 移动端和平板使用底部导航栏
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
    final screenHeight = ResponsiveUtils.getHeight(context);
    // 动态调整底部导航栏高度 - 减小内边距
    final verticalPadding = screenHeight > 900 ? 6.0
        : screenHeight > 800 ? 5.0
        : screenHeight > 700 ? 4.0
        : screenHeight > 600 ? 3.0
        : 2.0;
    final horizontalPadding = 8.0;
    
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
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding, 
            vertical: verticalPadding,
          ),
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
    final screenHeight = ResponsiveUtils.getHeight(context);
    // 动态调整导航项尺寸
    final iconSize = screenHeight > 900 ? 24.0
        : screenHeight > 800 ? 23.0
        : screenHeight > 700 ? 22.0
        : screenHeight > 600 ? 21.0
        : 20.0;
    final fontSize = screenHeight > 900 ? 12.0
        : screenHeight > 800 ? 11.5
        : screenHeight > 700 ? 11.0
        : screenHeight > 600 ? 10.5
        : 10.0;
    final verticalPadding = screenHeight > 900 ? 6.0
        : screenHeight > 800 ? 5.0
        : screenHeight > 700 ? 4.0
        : screenHeight > 600 ? 3.0
        : 2.0;
    final spacing = screenHeight > 900 ? 3.0
        : screenHeight > 800 ? 2.5
        : screenHeight > 700 ? 2.0
        : 1.5;
        
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
        padding: EdgeInsets.symmetric(
          horizontal: 16, 
          vertical: verticalPadding,
        ),
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
              size: iconSize,
            ),
            SizedBox(height: spacing),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.neonCyan : AppColors.textMuted,
                fontSize: fontSize,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 侧边导航栏(桌面端)
  Widget _buildSideNavigation() {
    return Container(
      width: 240,
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          right: BorderSide(
            color: AppColors.neonCyan.withOpacity(0.1),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.neonCyan.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(2, 0),
            spreadRadius: 2,
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
            // 标题
            const Text(
              '心探',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 4,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '探索内心的真实自我',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 32),
            // 导航项
            _buildSideNavItem(
              index: 0,
              icon: Icons.home_outlined,
              activeIcon: Icons.home,
              label: '首页',
            ),
            _buildSideNavItem(
              index: 1,
              icon: Icons.history_outlined,
              activeIcon: Icons.history,
              label: '历史',
            ),
            _buildSideNavItem(
              index: 2,
              icon: Icons.settings_outlined,
              activeIcon: Icons.settings,
              label: '设置',
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildSideNavItem({
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
  }) {
    final isSelected = _currentIndex == index;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: GestureDetector(
        onTap: () {
          SoundService.instance.playTap();
          if (!isSelected) {
            setState(() => _currentIndex = index);
          }
        },
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: AppAnimations.fast,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.neonCyan.withOpacity(0.15)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? AppColors.neonCyan.withOpacity(0.3)
                  : Colors.transparent,
              width: 1,
            ),
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
          child: Row(
            children: [
              Icon(
                isSelected ? activeIcon : icon,
                color: isSelected ? AppColors.neonCyan : AppColors.textMuted,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? AppColors.neonCyan : AppColors.textMuted,
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          ),
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
    final horizontalPadding = ResponsiveUtils.getHorizontalPadding(context);
    final maxWidth = ResponsiveUtils.getMaxContentWidth(context);

    return SafeArea(
      bottom: false, // 不在底部添加 SafeArea padding，由底部导航栏的 SafeArea 处理
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Column(
            children: [
              // 顶部 Logo 区域
              _buildHeader(),
              // 测试列表 - 使用 LayoutBuilder 获取可用空间并计算卡片高度
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final availableHeight = constraints.maxHeight;
                    final cardSpacing = ResponsiveUtils.getCardSpacing(context);
                    final listTopPadding = ResponsiveUtils.getListTopPadding(context);
                    final listBottomPadding = ResponsiveUtils.getListBottomPadding(context);
                    
                    // 计算自适应卡片高度
                    final itemCount = quizTypes.length;
                    final totalSpacing = cardSpacing * (itemCount - 1) + listTopPadding + listBottomPadding;
                    final calculatedCardHeight = (availableHeight - totalSpacing) / itemCount;
                    // 约束卡片高度在70px-120px之间
                    final cardHeight = calculatedCardHeight.clamp(70.0, 120.0);
                    
                    // 计算实际内容总高度
                    final totalContentHeight = cardHeight * itemCount + totalSpacing;
                    
                    // 判断是否需要滚动
                    final needsScroll = totalContentHeight > availableHeight;
                    
                    // 构建卡片列表
                    final cardList = Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: listTopPadding),
                        for (int index = 0; index < quizTypes.length; index++) ...[
                          if (index > 0) SizedBox(height: cardSpacing),
                          SizedBox(
                            height: cardHeight,
                            child: _QuizTypeCard(
                              quizType: quizTypes[index],
                              index: index,
                              cardHeight: cardHeight,
                            ),
                          ),
                        ],
                        SizedBox(height: listBottomPadding),
                      ],
                    );
                    
                    // 当内容超出时使用 SingleChildScrollView
                    if (needsScroll) {
                      return ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                        child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                          child: cardList,
                        ),
                      );
                    }
                    
                    // 内容不超出时直接使用 Column
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                      child: cardList,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return AnimatedBuilder(
      animation: Listenable.merge([_logoController, _titleController]),
      builder: (context, child) {
        final pulse = sin(_logoPulse.value * 2 * pi);
        final rotation = _logoRotation.value;
        final gradientProgress = _titleController.value;
        final horizontalPadding = ResponsiveUtils.getHorizontalPadding(context);
        
        // 使用 ResponsiveUtils 动态计算头部元素尺寸
        final titleSize = ResponsiveUtils.getHeaderTitleFontSize(context);
        final subtitleSize = ResponsiveUtils.getHeaderSubtitleFontSize(context);
        final verticalPadding = ResponsiveUtils.getHeaderVerticalPadding(context);
        final spacing = ResponsiveUtils.getHeaderElementSpacing(context);
        
        // 呼吸效果参数
        final glowIntensity = 0.3 + pulse * 0.2;
        final scale = 1.0 + pulse * 0.02;
        
        return Container(
          padding: EdgeInsets.fromLTRB(
            horizontalPadding,
            verticalPadding,
            horizontalPadding,
            verticalPadding,
          ),
          decoration: BoxDecoration(
            color: AppColors.surface,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // 背景装饰 - 流动的能量线
              Positioned.fill(
                child: CustomPaint(
                  painter: _HeaderMysticPainter(
                    progress: gradientProgress,
                    pulse: pulse,
                    rotation: rotation,
                  ),
                ),
              ),
              // 主内容
              Center(
                child: Transform.scale(
                  scale: scale,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 主标题 - 呼吸发光效果
                      _buildBreathingTitle(titleSize, glowIntensity, gradientProgress),
                      SizedBox(height: spacing),
                      // 副标题 - 渐变色
                      _buildBreathingSubtitle(subtitleSize, pulse, gradientProgress),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // 呼吸感主标题 - 带流动渐变
  Widget _buildBreathingTitle(double fontSize, double glowIntensity, double gradientProgress) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        begin: Alignment(-1.0 + gradientProgress * 2, 0),
        end: Alignment(1.0 + gradientProgress * 2, 0),
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
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          letterSpacing: 8,
          shadows: [
            Shadow(
              color: AppColors.neonCyan.withOpacity(glowIntensity),
              blurRadius: 15 + glowIntensity * 10,
            ),
            Shadow(
              color: AppColors.neonPurple.withOpacity(glowIntensity * 0.8),
              blurRadius: 25 + glowIntensity * 15,
            ),
            Shadow(
              color: AppColors.neonPink.withOpacity(glowIntensity * 0.6),
              blurRadius: 35 + glowIntensity * 20,
            ),
          ],
        ),
      ),
    );
  }

  // 呼吸感副标题 - 带流动渐变
  Widget _buildBreathingSubtitle(double fontSize, double pulse, double gradientProgress) {
    final opacity = 0.7 + pulse * 0.15;
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        begin: Alignment(-1.5 + gradientProgress * 3, 0),
        end: Alignment(1.5 + gradientProgress * 3, 0),
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
          fontSize: fontSize,
          color: Colors.white,
          letterSpacing: 3.0,
          fontWeight: FontWeight.w500,
          shadows: [
            Shadow(
              color: AppColors.neonCyan.withOpacity(0.3 + pulse * 0.2),
              blurRadius: 8 + pulse * 5,
            ),
          ],
        ),
      ),
    );
  }
}

// 标题栏玄幻背景绘制器
class _HeaderMysticPainter extends CustomPainter {
  final double progress;
  final double pulse;
  final double rotation;
  
  _HeaderMysticPainter({
    required this.progress,
    required this.pulse,
    required this.rotation,
  });
  
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()..style = PaintingStyle.stroke;
    
    // 绘制两侧的能量弧线
    _drawEnergyArcs(canvas, size, paint);
    
    // 绘制流动的粒子点
    _drawFlowingParticles(canvas, size, paint);
    
    // 绘制装饰符文
    _drawDecorativeRunes(canvas, size, paint);
  }
  
  void _drawEnergyArcs(Canvas canvas, Size size, Paint paint) {
    final center = Offset(size.width / 2, size.height / 2);
    
    // 左侧弧线
    paint
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;
    
    for (int i = 0; i < 3; i++) {
      final offset = i * 15.0;
      final opacity = (0.3 - i * 0.08 + pulse * 0.1).clamp(0.0, 1.0);
      
      paint.shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.center,
        colors: [
          AppColors.neonCyan.withOpacity(opacity),
          AppColors.neonPurple.withOpacity(opacity * 0.5),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width / 2, size.height));
      
      final path = Path();
      path.moveTo(0, size.height * 0.3 + offset);
      path.quadraticBezierTo(
        size.width * 0.15,
        size.height * 0.5,
        size.width * 0.05,
        size.height * 0.7 - offset,
      );
      canvas.drawPath(path, paint);
    }
    
    // 右侧弧线
    for (int i = 0; i < 3; i++) {
      final offset = i * 15.0;
      final opacity = (0.3 - i * 0.08 + pulse * 0.1).clamp(0.0, 1.0);
      
      paint.shader = LinearGradient(
        begin: Alignment.centerRight,
        end: Alignment.center,
        colors: [
          AppColors.neonPink.withOpacity(opacity),
          AppColors.neonPurple.withOpacity(opacity * 0.5),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(size.width / 2, 0, size.width / 2, size.height));
      
      final path = Path();
      path.moveTo(size.width, size.height * 0.3 + offset);
      path.quadraticBezierTo(
        size.width * 0.85,
        size.height * 0.5,
        size.width * 0.95,
        size.height * 0.7 - offset,
      );
      canvas.drawPath(path, paint);
    }
  }
  
  void _drawFlowingParticles(Canvas canvas, Size size, Paint paint) {
    paint.shader = null;
    paint.style = PaintingStyle.fill;
    
    // 左侧粒子
    for (int i = 0; i < 5; i++) {
      final t = (progress + i * 0.2) % 1.0;
      final x = size.width * 0.05 + t * size.width * 0.15;
      final y = size.height * 0.3 + sin(t * pi) * size.height * 0.3;
      final opacity = sin(t * pi) * (0.5 + pulse * 0.3);
      final radius = 2.0 + pulse * 1.5;
      
      paint.color = AppColors.neonCyan.withOpacity(opacity.clamp(0.0, 1.0));
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
    
    // 右侧粒子
    for (int i = 0; i < 5; i++) {
      final t = (progress + i * 0.2) % 1.0;
      final x = size.width * 0.95 - t * size.width * 0.15;
      final y = size.height * 0.3 + sin(t * pi) * size.height * 0.3;
      final opacity = sin(t * pi) * (0.5 + pulse * 0.3);
      final radius = 2.0 + pulse * 1.5;
      
      paint.color = AppColors.neonPink.withOpacity(opacity.clamp(0.0, 1.0));
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }
  
  void _drawDecorativeRunes(Canvas canvas, Size size, Paint paint) {
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 1.0;
    
    // 左侧小符文
    final leftRuneCenter = Offset(size.width * 0.08, size.height * 0.5);
    final runeSize = 8.0 + pulse * 3;
    paint.color = AppColors.neonCyan.withOpacity(0.4 + pulse * 0.2);
    
    // 绘制小三角
    final leftPath = Path();
    for (int i = 0; i < 3; i++) {
      final angle = rotation * 0.5 + (i / 3) * 2 * pi - pi / 2;
      final x = leftRuneCenter.dx + runeSize * cos(angle);
      final y = leftRuneCenter.dy + runeSize * sin(angle);
      if (i == 0) {
        leftPath.moveTo(x, y);
      } else {
        leftPath.lineTo(x, y);
      }
    }
    leftPath.close();
    canvas.drawPath(leftPath, paint);
    
    // 右侧小符文
    final rightRuneCenter = Offset(size.width * 0.92, size.height * 0.5);
    paint.color = AppColors.neonPink.withOpacity(0.4 + pulse * 0.2);
    
    final rightPath = Path();
    for (int i = 0; i < 3; i++) {
      final angle = -rotation * 0.5 + (i / 3) * 2 * pi + pi / 2;
      final x = rightRuneCenter.dx + runeSize * cos(angle);
      final y = rightRuneCenter.dy + runeSize * sin(angle);
      if (i == 0) {
        rightPath.moveTo(x, y);
      } else {
        rightPath.lineTo(x, y);
      }
    }
    rightPath.close();
    canvas.drawPath(rightPath, paint);
  }
  
  @override
  bool shouldRepaint(covariant _HeaderMysticPainter oldDelegate) {
    return oldDelegate.progress != progress || 
           oldDelegate.pulse != pulse ||
           oldDelegate.rotation != rotation;
  }
}

class _QuizTypeCard extends StatefulWidget {
  final QuizType quizType;
  final int index;
  final double? cardHeight;

  const _QuizTypeCard({
    required this.quizType,
    required this.index,
    this.cardHeight,
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
    
    // 使用传入的卡片高度或根据屏幕高度计算
    final cardHeight = widget.cardHeight ?? 100.0;
    final scaleFactor = ResponsiveUtils.getCardScaleFactor(cardHeight);
    
    // 根据卡片高度动态调整内部元素尺寸
    final cardPadding = (14.0 * scaleFactor).clamp(10.0, 16.0);
    final iconSize = ResponsiveUtils.getAdaptiveIconSize(cardHeight);
    final iconInnerSize = (26.0 * scaleFactor).clamp(20.0, 28.0);
    final titleSize = ResponsiveUtils.getAdaptiveTitleFontSize(cardHeight);
    final descSize = ResponsiveUtils.getAdaptiveDescFontSize(cardHeight);
    final spacing = (10.0 * scaleFactor).clamp(6.0, 12.0);
    final contentSpacing = (5.0 * scaleFactor).clamp(2.0, 6.0);

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: NeonCard(
          borderColor: cardColor,
          onTap: () => _navigateToQuizDetail(context),
          padding: EdgeInsets.all(cardPadding),
          child: Row(
            children: [
              // Icon container with pulse effect
              AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (context, child) {
                  return Container(
                    width: iconSize,
                    height: iconSize,
                    decoration: BoxDecoration(
                      color: cardColor.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: cardColor.withOpacity(0.5 + _pulseAnimation.value * 0.2),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: cardColor.withOpacity(0.3 + _pulseAnimation.value * 0.3),
                          blurRadius: 10 + _pulseAnimation.value * 8,
                          spreadRadius: _pulseAnimation.value * 3,
                        ),
                      ],
                    ),
                    child: Icon(
                      _getQuizIcon(),
                      color: cardColor,
                      size: iconInnerSize,
                    ),
                  );
                },
              ),
              SizedBox(width: spacing),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.quizType.name,
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: titleSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.quizType.description,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: descSize,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: contentSpacing),
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
