import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../domain/models/quiz_report.dart';
import '../../domain/models/rating_level.dart';
import 'neon_card.dart';
class SelectionDetailCard extends StatefulWidget {
  final String categoryName;
  final List<SelectionDetail> selections;
  final Color accentColor;
  final bool initiallyExpanded;

  const SelectionDetailCard({
    super.key,
    required this.categoryName,
    required this.selections,
    required this.accentColor,
    this.initiallyExpanded = false,
  });
  
  /// 过滤后的选择项（只显示SSS和S）
  List<SelectionDetail> get filteredSelections => 
      selections.where((s) => s.rating.shouldShowInReport).toList();

  @override
  State<SelectionDetailCard> createState() => SelectionDetailCardState();
}

class SelectionDetailCardState extends State<SelectionDetailCard> {
  late bool _isExpanded;
  
  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }
  
  void setExpanded(bool expanded) {
    setState(() {
      _isExpanded = expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final displaySelections = widget.filteredSelections;
    
    // 如果没有SSS或S的选项，不显示这个卡片
    if (displaySelections.isEmpty) {
      return const SizedBox.shrink();
    }
    
    return NeonCard(
      borderColor: widget.accentColor.withOpacity(0.5),
      padding: EdgeInsets.zero,
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          childrenPadding: const EdgeInsets.only(bottom: 12),
          initiallyExpanded: _isExpanded,
          onExpansionChanged: (expanded) {
            setState(() {
              _isExpanded = expanded;
            });
          },
          title: Row(
            children: [
              Icon(
                _isExpanded ? Icons.unfold_less : Icons.unfold_more,
                color: widget.accentColor,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.categoryName,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: widget.accentColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${displaySelections.length} 项',
                  style: TextStyle(
                    color: widget.accentColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          trailing: const SizedBox.shrink(),
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: displaySelections.map((selection) {
                  return _buildSelectionItem(selection, displaySelections);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionItem(SelectionDetail selection, List<SelectionDetail> displayList) {
    final isLast = displayList.last == selection;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: !isLast
            ? Border(
                bottom: BorderSide(
                  color: AppColors.textMuted.withOpacity(0.3),
                  width: 0.5,
                ),
              )
            : null,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              selection.item.name,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 12),
          _buildRatingBadge(selection.rating),
        ],
      ),
    );
  }

  Widget _buildRatingBadge(RatingLevel rating) {
    final color = _getRatingColor(rating);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getRatingIcon(rating),
            color: color,
            size: 14,
          ),
          const SizedBox(width: 4),
          Text(
            rating.description,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Color _getRatingColor(RatingLevel rating) {
    switch (rating) {
      case RatingLevel.sss:
        return AppColors.neonPink;
      case RatingLevel.s:
        return AppColors.neonPurple;
      case RatingLevel.n:
        return AppColors.textMuted;
    }
  }

  IconData _getRatingIcon(RatingLevel rating) {
    switch (rating) {
      case RatingLevel.sss:
        return Icons.favorite;
      case RatingLevel.s:
        return Icons.check_circle_outline;
      case RatingLevel.n:
        return Icons.remove_circle_outline;
    }
  }
}
