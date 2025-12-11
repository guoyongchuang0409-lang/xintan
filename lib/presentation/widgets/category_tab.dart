import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_animations.dart';
import '../../core/services/sound_service.dart';
class CategoryTab extends StatefulWidget {
  final String name;
  final bool isSelected;
  final VoidCallback? onTap;
  final Color? selectedColor;

  const CategoryTab({
    super.key,
    required this.name,
    this.isSelected = false,
    this.onTap,
    this.selectedColor,
  });

  @override
  State<CategoryTab> createState() => _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: AppAnimations.selectionGlow,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _controller, curve: AppAnimations.defaultCurve),
    );
    _glowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: AppAnimations.defaultCurve),
    );

    if (widget.isSelected) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(CategoryTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected != oldWidget.isSelected) {
      if (widget.isSelected) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedColor = widget.selectedColor ?? AppColors.neonCyan;

    return GestureDetector(
      onTap: () {
        SoundService.instance.playTap();
        widget.onTap?.call();
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final glowIntensity = _glowAnimation.value * 0.6;

          return Transform.scale(
            scale: _scaleAnimation.value,
            child: AnimatedContainer(
              duration: AppAnimations.fast,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: widget.isSelected
                    ? selectedColor.withOpacity(0.15)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: widget.isSelected
                      ? selectedColor
                      : AppColors.textMuted.withOpacity(0.3),
                  width: widget.isSelected ? 1.5 : 1,
                ),
                boxShadow: widget.isSelected
                    ? [
                        BoxShadow(
                          color: selectedColor.withOpacity(glowIntensity * 0.4),
                          blurRadius: 8,
                          spreadRadius: 0,
                        ),
                      ]
                    : null,
              ),
              child: Text(
                widget.name,
                style: TextStyle(
                  color: widget.isSelected
                      ? selectedColor
                      : AppColors.textSecondary,
                  fontSize: 14,
                  fontWeight:
                      widget.isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
class CategoryTabBar extends StatefulWidget {
  final List<String> categories;
  final int selectedIndex;
  final ValueChanged<int>? onCategorySelected;
  final Color? selectedColor;

  const CategoryTabBar({
    super.key,
    required this.categories,
    required this.selectedIndex,
    this.onCategorySelected,
    this.selectedColor,
  });

  @override
  State<CategoryTabBar> createState() => _CategoryTabBarState();
}

class _CategoryTabBarState extends State<CategoryTabBar> {
  late ScrollController _scrollController;
  static const int _visibleCount = 4; // 每次显示4个标签

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelected();
    });
  }

  @override
  void didUpdateWidget(CategoryTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedIndex != oldWidget.selectedIndex) {
      _scrollToSelected();
    }
  }

  void _scrollToSelected() {
    if (!_scrollController.hasClients) return;
    
    final itemWidth = _scrollController.position.viewportDimension / _visibleCount;
    final targetOffset = widget.selectedIndex * itemWidth - itemWidth * 1.5;
    final maxScroll = _scrollController.position.maxScrollExtent;
    
    _scrollController.animateTo(
      targetOffset.clamp(0.0, maxScroll),
      duration: AppAnimations.normal,
      curve: AppAnimations.defaultCurve,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.surface.withOpacity(0.5),
        border: Border(
          bottom: BorderSide(
            color: AppColors.textMuted.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final itemWidth = constraints.maxWidth / _visibleCount;
          
          return ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: widget.categories.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: itemWidth,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: _CompactCategoryTab(
                      name: widget.categories[index],
                      isSelected: index == widget.selectedIndex,
                      selectedColor: widget.selectedColor,
                      onTap: () => widget.onCategorySelected?.call(index),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
class _CompactCategoryTab extends StatelessWidget {
  final String name;
  final bool isSelected;
  final VoidCallback? onTap;
  final Color? selectedColor;

  const _CompactCategoryTab({
    required this.name,
    this.isSelected = false,
    this.onTap,
    this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    final color = selectedColor ?? AppColors.neonCyan;

    return GestureDetector(
      onTap: () {
        SoundService.instance.playTap();
        onTap?.call();
      },
      child: AnimatedContainer(
        duration: AppAnimations.fast,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? color : AppColors.textMuted.withOpacity(0.25),
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.25),
                    blurRadius: 6,
                    spreadRadius: 0,
                  ),
                ]
              : null,
        ),
        alignment: Alignment.center,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            name,
            textAlign: TextAlign.center,
            maxLines: 1,
            style: TextStyle(
              color: isSelected ? color : AppColors.textSecondary,
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
class CategoryTabBarWithIndicator extends StatelessWidget {
  final List<String> categories;
  final int selectedIndex;
  final ValueChanged<int>? onCategorySelected;
  final Color? selectedColor;

  const CategoryTabBarWithIndicator({
    super.key,
    required this.categories,
    required this.selectedIndex,
    this.onCategorySelected,
    this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    final color = selectedColor ?? AppColors.neonCyan;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 48,
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final isSelected = index == selectedIndex;
                return GestureDetector(
                  onTap: () => onCategorySelected?.call(index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      AnimatedDefaultTextStyle(
                        duration: AppAnimations.fast,
                        style: TextStyle(
                          color: isSelected ? color : AppColors.textSecondary,
                          fontSize: 15,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                        child: Text(categories[index]),
                      ),
                      const SizedBox(height: 6),
                      AnimatedContainer(
                        duration: AppAnimations.fast,
                        height: 3,
                        width: isSelected ? 24 : 0,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(1.5),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: color.withOpacity(0.5),
                                    blurRadius: 4,
                                    spreadRadius: 0,
                                  ),
                                ]
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        ),
        Container(
          height: 1,
          color: AppColors.textMuted.withOpacity(0.1),
        ),
      ],
    );
  }
}
