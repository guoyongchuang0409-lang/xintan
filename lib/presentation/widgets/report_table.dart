import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_animations.dart';
import '../../domain/models/quiz_report.dart';
import '../../domain/models/rating_level.dart';
class ReportTable extends StatefulWidget {
  final QuizReport report;
  final bool animate;

  const ReportTable({
    super.key,
    required this.report,
    this.animate = true,
  });

  @override
  State<ReportTable> createState() => _ReportTableState();
}

class _ReportTableState extends State<ReportTable>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Animation<double>> _rowAnimations = [];

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    final totalRows = widget.report.categoryStats.length + 1; // +1 for header
    final totalDuration = AppAnimations.dataFadeIn.inMilliseconds +
        (totalRows * AppAnimations.dataReveal.inMilliseconds);

    _controller = AnimationController(
      duration: Duration(milliseconds: totalDuration),
      vsync: this,
    );

    _rowAnimations.clear();
    for (int i = 0; i < totalRows; i++) {
      final startTime = i * AppAnimations.dataReveal.inMilliseconds;
      final endTime = startTime + AppAnimations.dataFadeIn.inMilliseconds;

      final animation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            startTime / totalDuration,
            (endTime / totalDuration).clamp(0.0, 1.0),
            curve: AppAnimations.smoothCurve,
          ),
        ),
      );
      _rowAnimations.add(animation);
    }

    if (widget.animate) {
      _controller.forward();
    } else {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.neonCyan.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header row
                _buildAnimatedRow(
                  index: 0,
                  child: _buildHeaderRow(),
                ),
                // Data rows
                ...widget.report.categoryStats.entries.toList().asMap().entries.map(
                  (entry) {
                    final index = entry.key + 1;
                    final categoryEntry = entry.value;
                    return _buildAnimatedRow(
                      index: index,
                      child: _buildDataRow(
                        categoryEntry.value,
                        isAlternate: index % 2 == 0,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedRow({required int index, required Widget child}) {
    if (index >= _rowAnimations.length) {
      return child;
    }

    final animation = _rowAnimations[index];
    return Opacity(
      opacity: animation.value,
      child: Transform.translate(
        offset: Offset(0, 10 * (1 - animation.value)),
        child: child,
      ),
    );
  }

  Widget _buildHeaderRow() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        border: Border(
          bottom: BorderSide(
            color: AppColors.neonCyan.withOpacity(0.3),
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '分类',
              style: TextStyle(
                color: AppColors.neonCyan,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          ...RatingLevel.values.map((level) {
            return Expanded(
              child: Text(
                level.code,
                style: TextStyle(
                  color: _getRatingColor(level),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildDataRow(CategoryStats stats, {bool isAlternate = false}) {
    return Container(
      decoration: BoxDecoration(
        color: isAlternate
            ? AppColors.surface.withOpacity(0.5)
            : AppColors.surface,
        border: Border(
          bottom: BorderSide(
            color: AppColors.textMuted.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              stats.categoryName,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ...RatingLevel.values.map((level) {
            final count = stats.levelCounts[level] ?? 0;
            final percentage = stats.levelPercentages[level] ?? 0.0;
            return Expanded(
              child: _buildStatCell(count, percentage, _getRatingColor(level)),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildStatCell(int count, double percentage, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          count.toString(),
          style: TextStyle(
            color: count > 0 ? color : AppColors.textMuted,
            fontWeight: count > 0 ? FontWeight.bold : FontWeight.normal,
            fontSize: 14,
          ),
        ),
        if (count > 0)
          Text(
            '${percentage.toStringAsFixed(0)}%',
            style: TextStyle(
              color: color.withOpacity(0.7),
              fontSize: 10,
            ),
          ),
      ],
    );
  }
}
