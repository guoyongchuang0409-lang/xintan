import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_animations.dart';
class QuizProgressIndicator extends StatefulWidget {
  final double progress;
  final int completed;
  final int total;
  final double height;
  final bool showLabel;

  const QuizProgressIndicator({
    super.key,
    required this.progress,
    required this.completed,
    required this.total,
    this.height = 8,
    this.showLabel = true,
  });

  @override
  State<QuizProgressIndicator> createState() => _QuizProgressIndicatorState();
}

class _QuizProgressIndicatorState extends State<QuizProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _shimmerAnimation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _shimmerController, curve: Curves.linear),
    );
    _shimmerController.repeat();
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.showLabel) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '进度',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
              Text(
                '${widget.completed} / ${widget.total}',
                style: TextStyle(
                  color: AppColors.neonCyan,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
        _buildProgressBar(),
      ],
    );
  }

  Widget _buildProgressBar() {
    return AnimatedBuilder(
      animation: _shimmerAnimation,
      builder: (context, child) {
        return Container(
          height: widget.height,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(widget.height / 2),
            border: Border.all(
              color: AppColors.textMuted.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.height / 2),
            child: Stack(
              children: [
                // Progress fill with animation
                AnimatedContainer(
                  duration: AppAnimations.progressUpdate,
                  curve: AppAnimations.defaultCurve,
                  width: double.infinity,
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: widget.progress.clamp(0.0, 1.0),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: AppColors.progressGradient,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.neonCyan.withOpacity(0.5),
                            blurRadius: 4,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Shimmer effect
                if (widget.progress > 0 && widget.progress < 1)
                  Positioned.fill(
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: widget.progress.clamp(0.0, 1.0),
                      child: ShaderMask(
                        shaderCallback: (bounds) {
                          return LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.transparent,
                              Colors.white.withOpacity(0.3),
                              Colors.transparent,
                            ],
                            stops: [
                              _shimmerAnimation.value - 0.3,
                              _shimmerAnimation.value,
                              _shimmerAnimation.value + 0.3,
                            ].map((e) => e.clamp(0.0, 1.0)).toList(),
                          ).createShader(bounds);
                        },
                        blendMode: BlendMode.srcATop,
                        child: Container(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
class CircularQuizProgress extends StatelessWidget {
  final double progress;
  final double size;
  final double strokeWidth;
  final Color? color;
  final Widget? child;

  const CircularQuizProgress({
    super.key,
    required this.progress,
    this.size = 60,
    this.strokeWidth = 4,
    this.color,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final progressColor = color ?? AppColors.neonCyan;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background circle
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              value: 1.0,
              strokeWidth: strokeWidth,
              valueColor: AlwaysStoppedAnimation<Color>(
                AppColors.surface,
              ),
            ),
          ),
          // Progress circle
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: progress),
            duration: AppAnimations.progressUpdate,
            curve: AppAnimations.defaultCurve,
            builder: (context, value, _) {
              return SizedBox(
                width: size,
                height: size,
                child: CircularProgressIndicator(
                  value: value.clamp(0.0, 1.0),
                  strokeWidth: strokeWidth,
                  valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                  strokeCap: StrokeCap.round,
                ),
              );
            },
          ),
          // Center content
          if (child != null) child!,
          if (child == null)
            Text(
              '${(progress * 100).toInt()}%',
              style: TextStyle(
                color: progressColor,
                fontSize: size * 0.22,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }
}
