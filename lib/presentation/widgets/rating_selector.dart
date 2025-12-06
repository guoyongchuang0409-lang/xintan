import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_animations.dart';
import '../../core/services/sound_service.dart';
import '../../domain/models/rating_level.dart';
class RatingSelector extends StatelessWidget {
  final RatingLevel? selectedLevel;
  final ValueChanged<RatingLevel>? onSelected;
  final bool compact;

  const RatingSelector({
    super.key,
    this.selectedLevel,
    this.onSelected,
    this.compact = false,
  });

  Color _getRatingColor(RatingLevel level) {
    switch (level) {
      case RatingLevel.sss:
        return AppColors.ratingSSS;
      case RatingLevel.ss:
        return AppColors.ratingSS;
      case RatingLevel.s:
        return AppColors.ratingS;
      case RatingLevel.q:
        return AppColors.ratingQ;
      case RatingLevel.n:
        return AppColors.ratingN;
      case RatingLevel.w:
        return AppColors.ratingW;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (compact) {
      return Wrap(
        spacing: 8,
        runSpacing: 8,
        children: RatingLevel.values.map((level) {
          return _RatingButton(
            level: level,
            color: _getRatingColor(level),
            isSelected: selectedLevel == level,
            onTap: () => onSelected?.call(level),
            compact: true,
          );
        }).toList(),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: RatingLevel.values.map((level) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: _RatingButton(
              level: level,
              color: _getRatingColor(level),
              isSelected: selectedLevel == level,
              onTap: () => onSelected?.call(level),
              compact: false,
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _RatingButton extends StatefulWidget {
  final RatingLevel level;
  final Color color;
  final bool isSelected;
  final VoidCallback? onTap;
  final bool compact;

  const _RatingButton({
    required this.level,
    required this.color,
    required this.isSelected,
    this.onTap,
    this.compact = false,
  });

  @override
  State<_RatingButton> createState() => _RatingButtonState();
}

class _RatingButtonState extends State<_RatingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: AppAnimations.selectionGlow,
      vsync: this,
    );
    _glowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: AppAnimations.defaultCurve),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: AppAnimations.defaultCurve),
    );

    if (widget.isSelected) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(_RatingButton oldWidget) {
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
    return GestureDetector(
      onTap: () {
        SoundService.instance.playSelect();
        widget.onTap?.call();
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final glowIntensity = _glowAnimation.value * 0.7;
          final spreadRadius = 10.0 * _glowAnimation.value;

          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: widget.compact ? 12 : 8,
                vertical: widget.compact ? 8 : 12,
              ),
              decoration: BoxDecoration(
                color: widget.isSelected
                    ? widget.color.withOpacity(0.15)
                    : AppColors.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: widget.isSelected
                      ? widget.color
                      : AppColors.textMuted.withOpacity(0.3),
                  width: widget.isSelected ? 2 : 1,
                ),
                boxShadow: widget.isSelected
                    ? [
                        BoxShadow(
                          color: widget.color.withOpacity(glowIntensity * 0.4),
                          blurRadius: spreadRadius,
                          spreadRadius: 0,
                        ),
                        BoxShadow(
                          color: widget.color.withOpacity(glowIntensity * 0.2),
                          blurRadius: spreadRadius * 2,
                          spreadRadius: spreadRadius * 0.5,
                        ),
                      ]
                    : null,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.level.code,
                    style: TextStyle(
                      color: widget.isSelected
                          ? widget.color
                          : AppColors.textSecondary,
                      fontSize: widget.compact ? 14 : 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (!widget.compact) ...[
                    const SizedBox(height: 4),
                    Text(
                      widget.level.description,
                      style: TextStyle(
                        color: widget.isSelected
                            ? widget.color.withOpacity(0.8)
                            : AppColors.textMuted,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
