import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_animations.dart';
import '../../core/services/sound_service.dart';
import '../../domain/models/quiz_type.dart';
import '../widgets/neon_card.dart';
import '../widgets/glow_button.dart';
class QuizDetailPage extends StatefulWidget {
  const QuizDetailPage({super.key});

  @override
  State<QuizDetailPage> createState() => _QuizDetailPageState();
}

class _QuizDetailPageState extends State<QuizDetailPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: AppAnimations.normal,
      vsync: this,
    );
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
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Color _getQuizColor(String quizTypeId) {
    switch (quizTypeId) {
      case 'female_desire':
        return AppColors.neonPink;
      case 'female_s':
        return AppColors.neonCyan;
      case 'male_s':
        return AppColors.neonPurple;
      case 'female_m':
        return AppColors.neonGreen;
      case 'male_m':
        return AppColors.neonBlue;
      case 'cuckold':
        return AppColors.neonOrange;
      default:
        return AppColors.neonCyan;
    }
  }


  IconData _getQuizIcon(String quizTypeId) {
    switch (quizTypeId) {
      case 'female_desire':
        return Icons.favorite;
      case 'female_s':
        return Icons.shield;
      case 'male_s':
        return Icons.shield_outlined;
      case 'female_m':
        return Icons.female;
      case 'male_m':
        return Icons.male;
      case 'cuckold':
        return Icons.favorite_border;
      default:
        return Icons.quiz;
    }
  }

  @override
  Widget build(BuildContext context) {
    final quizType = ModalRoute.of(context)?.settings.arguments as QuizType?;

    if (quizType == null) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.surface,
          title: const Text('测试详情'),
        ),
        body: const Center(
          child: Text(
            '无法加载测试数据',
            style: TextStyle(color: AppColors.textPrimary),
          ),
        ),
      );
    }

    final quizColor = _getQuizColor(quizType.id);
    final totalItems = quizType.categories.fold<int>(
      0,
      (sum, category) => sum + category.items.length,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: CustomScrollView(
          slivers: [
          _buildAppBar(quizType, quizColor),
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDescriptionCard(quizType, quizColor),
                      const SizedBox(height: 20),
                      _buildStatsCard(quizType, quizColor, totalItems),
                      const SizedBox(height: 20),
                      _buildCategoriesCard(quizType, quizColor),
                      const SizedBox(height: 20),
                      _buildRatingGuideCard(quizColor),
                      const SizedBox(height: 32),
                      _buildStartButton(quizType, quizColor),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
        ),
      ),
    );
  }

  Widget _buildAppBar(QuizType quizType, Color quizColor) {
    return SliverAppBar(
      expandedHeight: 0,
      floating: false,
      pinned: true,
      backgroundColor: AppColors.surface,
      automaticallyImplyLeading: false,
      toolbarHeight: 64,
      flexibleSpace: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 8,
          left: 8,
          right: 16,
          bottom: 8,
        ),
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border(
            bottom: BorderSide(
              color: quizColor.withOpacity(0.2),
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            // 返回按钮
            IconButton(
              icon: Icon(Icons.arrow_back, color: quizColor),
              onPressed: () {
                SoundService.instance.playClick();
                Navigator.pop(context);
              },
            ),
            // 标题居中
            Expanded(
              child: Center(
                child: ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [quizColor, quizColor.withOpacity(0.7)],
                  ).createShader(bounds),
                  child: Text(
                    quizType.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            // 右侧占位，与返回按钮平衡
            const SizedBox(width: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionCard(QuizType quizType, Color quizColor) {
    return NeonCard(
      borderColor: quizColor,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: quizColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                '测试说明',
                style: TextStyle(
                  color: quizColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            quizType.description,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '本测试将帮助你更好地了解自己的内心倾向和偏好请根据你的真实感受选择评分，没有对错之分',
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard(QuizType quizType, Color quizColor, int totalItems) {
    return NeonCard(
      borderColor: quizColor.withOpacity(0.7),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.analytics_outlined,
                color: quizColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                '测试概览',
                style: TextStyle(
                  color: quizColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  icon: Icons.category_outlined,
                  label: '分类数量',
                  value: '${quizType.categories.length}',
                  color: quizColor,
                ),
              ),
              Container(
                width: 1,
                height: 50,
                color: AppColors.textMuted.withOpacity(0.2),
              ),
              Expanded(
                child: _buildStatItem(
                  icon: Icons.list_alt_outlined,
                  label: '测试项目',
                  value: '$totalItems',
                  color: quizColor,
                ),
              ),
              Container(
                width: 1,
                height: 50,
                color: AppColors.textMuted.withOpacity(0.2),
              ),
              Expanded(
                child: _buildStatItem(
                  icon: Icons.timer_outlined,
                  label: '预计时间',
                  value: '${(totalItems * 0.3).ceil()}分钟',
                  color: quizColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: color.withOpacity(0.8),
          size: 24,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: AppColors.textMuted,
            fontSize: 12,
          ),
        ),
      ],
    );
  }


  Widget _buildCategoriesCard(QuizType quizType, Color quizColor) {
    return NeonCard(
      borderColor: quizColor.withOpacity(0.6),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.folder_outlined,
                color: quizColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                '测试分类',
                style: TextStyle(
                  color: quizColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // 使用 Wrap + Row 实现两列布局，自动适应内容高度
          _buildCategoryRows(quizType.categories, quizColor),
        ],
      ),
    );
  }

  Widget _buildCategoryRows(List categories, Color quizColor) {
    List<Widget> rows = [];
    for (int i = 0; i < categories.length; i += 2) {
      rows.add(
        Padding(
          padding: EdgeInsets.only(bottom: i + 2 < categories.length ? 10 : 0),
          child: Row(
            children: [
              Expanded(
                child: _buildCategoryItem(categories[i], quizColor),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: i + 1 < categories.length
                    ? _buildCategoryItem(categories[i + 1], quizColor)
                    : const SizedBox(),
              ),
            ],
          ),
        ),
      );
    }
    return Column(children: rows);
  }

  Widget _buildCategoryItem(dynamic category, Color quizColor) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: quizColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: quizColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              category.name,
              style: TextStyle(
                color: quizColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 3,
            ),
            decoration: BoxDecoration(
              color: quizColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '${category.items.length}',
              style: TextStyle(
                color: quizColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingGuideCard(Color quizColor) {
    return NeonCard(
      borderColor: quizColor.withOpacity(0.5),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.help_outline,
                color: quizColor,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                '评分说明',
                style: TextStyle(
                  color: quizColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // 一行显示3个评分选项
          Row(
            children: [
              Expanded(child: _buildRatingItem('SR', '特别喜欢', AppColors.ratingSSS)),
              const SizedBox(width: 8),
              Expanded(child: _buildRatingItem('S', '可以', AppColors.ratingS)),
              const SizedBox(width: 8),
              Expanded(child: _buildRatingItem('N', '跳过', AppColors.ratingN)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRatingItem(String code, String description, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            code,
            style: TextStyle(
              color: color,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            description,
            style: TextStyle(
              color: color.withOpacity(0.8),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStartButton(QuizType quizType, Color quizColor) {
    return Center(
      child: GlowButton(
        text: '开始测试',
        icon: Icons.play_arrow,
        color: quizColor,
        width: double.infinity,
        height: 56,
        onPressed: () => _startQuiz(quizType),
      ),
    );
  }

  void _startQuiz(QuizType quizType) {
    // 播放通知音效
    SoundService.instance.playNotification();
    
    // Navigate to quiz test page
    // This will be implemented in task 10.3
    Navigator.pushNamed(
      context,
      '/quiz-test',
      arguments: quizType,
    );
  }
}
