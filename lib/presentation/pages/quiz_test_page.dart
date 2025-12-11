import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_animations.dart';
import '../../core/services/sound_service.dart';
import '../../domain/models/quiz_type.dart';
import '../../domain/models/quiz_category.dart';
import '../../domain/models/quiz_item.dart';
import '../../domain/models/rating_level.dart';
import '../providers/quiz_provider.dart';
import '../widgets/neon_card.dart';
import '../widgets/glow_button.dart';
import '../widgets/category_tab.dart';
import '../widgets/custom_dialog.dart';
class QuizTestPage extends StatefulWidget {
  const QuizTestPage({super.key});

  @override
  State<QuizTestPage> createState() => _QuizTestPageState();
}

class _QuizTestPageState extends State<QuizTestPage>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  
  QuizType? _quizType;
  int _currentCategoryIndex = 0;
  final Map<String, RatingLevel> _ratings = {};

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
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
    _animationController.forward();
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_quizType == null) {
      _quizType = ModalRoute.of(context)?.settings.arguments as QuizType?;
      if (_quizType != null) {
        // Initialize provider with quiz type
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.read<QuizProvider>().selectQuizType(_quizType!);
        });
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
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

  int get _totalItems {
    if (_quizType == null) return 0;
    return _quizType!.categories.fold<int>(
      0,
      (sum, category) => sum + category.items.length,
    );
  }

  int get _completedItems => _ratings.length;

  double get _progress {
    if (_totalItems == 0) return 0;
    return _completedItems / _totalItems;
  }

  void _onCategoryChanged(int index) {
    setState(() {
      _currentCategoryIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: AppAnimations.normal,
      curve: AppAnimations.defaultCurve,
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentCategoryIndex = index;
    });
  }

  void _setRating(String itemId, RatingLevel level) {
    // 播放选择音效
    SoundService.instance.playSelect();
    
    setState(() {
      _ratings[itemId] = level;
    });
    context.read<QuizProvider>().setRating(itemId, level);
    
    // Check if current category is complete and auto-scroll to next
    _checkAutoScrollToNextCategory();
  }

  void _checkAutoScrollToNextCategory() {
    if (_quizType == null) return;
    
    final currentCategory = _quizType!.categories[_currentCategoryIndex];
    final categoryItemIds = currentCategory.items.map((item) => item.id).toSet();
    final ratedItemIds = _ratings.keys.toSet();
    
    // Check if all items in current category are rated
    final allRated = categoryItemIds.every((id) => ratedItemIds.contains(id));
    
    if (allRated && _currentCategoryIndex < _quizType!.categories.length - 1) {
      // Auto scroll to next category after a short delay
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          _onCategoryChanged(_currentCategoryIndex + 1);
        }
      });
    }
  }

  void _onComplete() {
    if (_quizType == null) return;
    
    // 播放完成音效
    SoundService.instance.playComplete();
    
    // Navigate to report page with ratings
    Navigator.pushReplacementNamed(
      context,
      '/report',
      arguments: {
        'quizType': _quizType,
        'ratings': _ratings,
      },
    );
  }

  void _showExitConfirmation() async {
    final confirmed = await CustomDialog.showConfirm(
      context,
      title: '确认退出',
      content: '退出后当前测试进度将丢失，确定要退出吗？',
      confirmText: '退出',
      cancelText: '继续测试',
      color: AppColors.neonCyan,
    );
    
    if (confirmed && mounted) {
      Navigator.pop(context);
    }
  }


  @override
  Widget build(BuildContext context) {
    if (_quizType == null) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.surface,
          title: const Text('测试'),
          centerTitle: true,
        ),
        body: const Center(
          child: Text(
            '无法加载测试数据',
            style: TextStyle(color: AppColors.textPrimary),
          ),
        ),
      );
    }

    final quizColor = _getQuizColor(_quizType!.id);
    final categories = _quizType!.categories;

    return WillPopScope(
      onWillPop: () async {
        _showExitConfirmation();
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            children: [
              _buildAppBar(quizColor),
              _buildCategoryTabs(categories, quizColor),
              Expanded(
                child: _buildCategoryPages(categories, quizColor),
              ),
              _buildBottomBar(quizColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(Color quizColor) {
    return Container(
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
          IconButton(
            icon: Icon(Icons.close, color: quizColor),
            onPressed: () {
              SoundService.instance.playClick();
              _showExitConfirmation();
            },
          ),
          Expanded(
            child: Text(
              _quizType!.name,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: quizColor.withOpacity(0.5),
                    blurRadius: 8,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 48), // Balance the close button
        ],
      ),
    );
  }

  Widget _buildCategoryTabs(List<QuizCategory> categories, Color quizColor) {
    return CategoryTabBar(
      categories: categories.map((c) => c.name).toList(),
      selectedIndex: _currentCategoryIndex,
      selectedColor: quizColor,
      onCategorySelected: _onCategoryChanged,
    );
  }

  Widget _buildCategoryPages(List<QuizCategory> categories, Color quizColor) {
    return PageView.builder(
      controller: _pageController,
      onPageChanged: _onPageChanged,
      itemCount: categories.length,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return _buildCategoryContent(categories[index], quizColor);
      },
    );
  }


  Widget _buildCategoryContent(QuizCategory category, Color quizColor) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: category.items.length,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          final item = category.items[index];
          return _buildQuizItemCard(item, quizColor, index);
        },
      ),
    );
  }

  Widget _buildQuizItemCard(QuizItem item, Color quizColor, int index) {
    final selectedRating = _ratings[item.id];
    
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 200 + (index * 50).clamp(0, 200)),
      curve: AppAnimations.defaultCurve,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: NeonCard(
          borderColor: selectedRating != null 
              ? quizColor 
              : AppColors.textMuted.withOpacity(0.3),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: quizColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: quizColor.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '${_getItemIndexInCategory(item) + 1}',
                        style: TextStyle(
                          color: quizColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      item.name,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  if (selectedRating != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getRatingColor(selectedRating).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _getRatingColor(selectedRating).withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        selectedRating.code,
                        style: TextStyle(
                          color: _getRatingColor(selectedRating),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              if (item.description != null && item.description!.isNotEmpty)
                const SizedBox(height: 8),
              if (item.description != null && item.description!.isNotEmpty)
                Text(
                  item.description!,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              const SizedBox(height: 12),
              _buildRatingButtons(item.id, selectedRating, quizColor),
            ],
          ),
        ),
      ),
    );
  }

  int _getItemIndexInCategory(QuizItem item) {
    if (_quizType == null) return 0;
    final currentCategory = _quizType!.categories[_currentCategoryIndex];
    return currentCategory.items.indexWhere((i) => i.id == item.id);
  }

  Color _getRatingColor(RatingLevel level) {
    switch (level) {
      case RatingLevel.sss:
        return AppColors.ratingSSS;
      case RatingLevel.s:
        return AppColors.ratingS;
      case RatingLevel.n:
        return AppColors.ratingN;
    }
  }

  // 新的评分等级定义：更清晰易懂
  static const _ratingLabels = {
    RatingLevel.sss: '特别喜欢',
    RatingLevel.s: '可以',
    RatingLevel.n: '跳过',
  };

  Widget _buildRatingButtons(String itemId, RatingLevel? selectedRating, Color quizColor) {
    // 一行显示3个选项
    return Row(
      children: RatingLevel.values.map((level) => 
        _buildSingleRatingButton(itemId, level, selectedRating)
      ).toList(),
    );
  }

  Widget _buildSingleRatingButton(String itemId, RatingLevel level, RatingLevel? selectedRating) {
    final isSelected = selectedRating == level;
    final color = _getRatingColor(level);
    final label = _ratingLabels[level] ?? level.description;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          SoundService.instance.playSelect();
          _setRating(itemId, level);
        },
        child: AnimatedContainer(
          duration: AppAnimations.fast,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          decoration: BoxDecoration(
            color: isSelected ? color.withOpacity(0.2) : AppColors.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? color : AppColors.textMuted.withOpacity(0.2),
              width: isSelected ? 2 : 1,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: color.withOpacity(0.3),
                      blurRadius: 8,
                      spreadRadius: 0,
                    ),
                  ]
                : null,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                level.code,
                style: TextStyle(
                  color: isSelected ? color : AppColors.textSecondary,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? color.withOpacity(0.9) : AppColors.textMuted,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBar(Color quizColor) {
    final isComplete = _completedItems == _totalItems && _totalItems > 0;
    final hasAnyRating = _completedItems > 0;
    
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: MediaQuery.of(context).padding.bottom + 12,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(
            color: quizColor.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 进度信息
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '已完$_completedItems / $_totalItems',
                  style: TextStyle(
                    color: quizColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          // 按钮
          Row(
            children: [
              // Previous category button
              IconButton(
                onPressed: _currentCategoryIndex > 0
                    ? () {
                        SoundService.instance.playTap();
                        _onCategoryChanged(_currentCategoryIndex - 1);
                      }
                    : null,
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: _currentCategoryIndex > 0
                      ? quizColor
                      : AppColors.textMuted.withOpacity(0.3),
                ),
              ),
              
              Expanded(
                child: GlowButton(
                  text: isComplete ? '完成测试' : '提交测试',
                  icon: Icons.check,
                  color: isComplete ? quizColor : quizColor.withOpacity(0.7),
                  onPressed: hasAnyRating ? _onComplete : null,
                ),
              ),
              
              // Next category button
              IconButton(
                onPressed: _currentCategoryIndex < (_quizType?.categories.length ?? 1) - 1
                    ? () {
                        SoundService.instance.playTap();
                        _onCategoryChanged(_currentCategoryIndex + 1);
                      }
                    : null,
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: _currentCategoryIndex < (_quizType?.categories.length ?? 1) - 1
                      ? quizColor
                      : AppColors.textMuted.withOpacity(0.3),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryProgress(Color quizColor) {
    if (_quizType == null) return const SizedBox();
    
    final currentCategory = _quizType!.categories[_currentCategoryIndex];
    final categoryItemIds = currentCategory.items.map((item) => item.id).toSet();
    final ratedCount = _ratings.keys.where((id) => categoryItemIds.contains(id)).length;
    final totalCount = currentCategory.items.length;
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '${currentCategory.name}: $ratedCount / $totalCount',
          style: TextStyle(
            color: quizColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '左右滑动切换分类',
          style: TextStyle(
            color: AppColors.textMuted,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
