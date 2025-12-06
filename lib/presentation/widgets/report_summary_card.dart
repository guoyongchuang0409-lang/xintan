import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../domain/models/quiz_report.dart';
import '../../domain/models/rating_level.dart';
import 'neon_card.dart';
class ReportSummaryCard extends StatelessWidget {
  final QuizReport report;

  const ReportSummaryCard({
    super.key,
    required this.report,
  });

  @override
  Widget build(BuildContext context) {
    // 计算总体统计
    final totalCounts = <RatingLevel, int>{};
    int totalItems = 0;
    
    for (final level in RatingLevel.values) {
      totalCounts[level] = 0;
    }
    
    for (final stats in report.categoryStats.values) {
      for (final entry in stats.levelCounts.entries) {
        totalCounts[entry.key] = (totalCounts[entry.key] ?? 0) + entry.value;
        totalItems += entry.value;
      }
    }
    
    return NeonCard(
      borderColor: AppColors.neonCyan.withOpacity(0.5),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 显示总计
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.analytics_outlined,
                  color: AppColors.neonCyan,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  '$totalItems 项评分',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // 显示各评级统
          ...RatingLevel.values.map((level) {
            final count = totalCounts[level] ?? 0;
            if (count == 0) return const SizedBox.shrink();
            
            final percentage = totalItems > 0 
                ? (count / totalItems * 100).toStringAsFixed(1)
                : '0.0';
            
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _buildRatingRow(level, count, percentage),
            );
          }).toList(),
        ],
      ),
    );
  }
  
  Widget _buildRatingRow(RatingLevel level, int count, String percentage) {
    final color = _getRatingColor(level);
    
    return Row(
      children: [
        // 评级标签
        Container(
          width: 60,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: color.withOpacity(0.5),
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              level.code,
              style: TextStyle(
                color: color,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        // 进度
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    level.description,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '$count 项',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '($percentage%)',
                    style: TextStyle(
                      color: color,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              LinearProgressIndicator(
                value: double.parse(percentage) / 100,
                backgroundColor: color.withOpacity(0.1),
                valueColor: AlwaysStoppedAnimation<Color>(color.withOpacity(0.6)),
                minHeight: 4,
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Color _getRatingColor(RatingLevel rating) {
    switch (rating) {
      case RatingLevel.n:
        return AppColors.textMuted;
      case RatingLevel.q:
        return AppColors.neonCyan;
      case RatingLevel.s:
        return AppColors.neonPurple;
      case RatingLevel.ss:
        return AppColors.neonGreen;
      case RatingLevel.sss:
        return AppColors.neonPink;
      case RatingLevel.w:
        return AppColors.textMuted.withOpacity(0.6);
    }
  }
}
