import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_animations.dart';
import '../../core/utils/toast_utils.dart';
import '../../core/utils/responsive_utils.dart';
import '../../core/services/sound_service.dart';
import '../../domain/models/quiz_report.dart';
import '../providers/report_provider.dart';
import '../widgets/neon_card.dart';
import '../widgets/mystic_background.dart';
import '../widgets/custom_dialog.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

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
    _animationController.forward();
    
    // Load reports when page opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ReportProvider>().loadReports();
    });
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

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  void _viewReport(QuizReport report) {
    SoundService.instance.playButton();
    Navigator.pushNamed(
      context,
      '/report',
      arguments: report,
    );
  }

  void _confirmDelete(QuizReport report) async {
    final confirmed = await CustomDialog.showConfirm(
      context,
      title: '确认删除',
      content: '确定要删除"${report.quizTypeName}"的测试记录吗？此操作无法撤销',
      confirmText: '删除',
      cancelText: '取消',
      color: AppColors.error,
    );
    
    if (confirmed && mounted) {
      _deleteReport(report);
    }
  }

  Future<void> _deleteReport(QuizReport report) async {
    final success = await context.read<ReportProvider>().deleteReport(report.id);
    if (mounted) {
      if (success) {
        ToastUtils.showSuccess(context, '删除成功');
      } else {
        ToastUtils.showError(context, '删除失败，请重试试');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface.withOpacity(0.95),
        title: Text(
          '历史记录',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: MysticBackground(
        primaryColor: AppColors.neonBlue,
        secondaryColor: AppColors.neonCyan.withOpacity(0.6),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Consumer<ReportProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.neonCyan,
                  ),
                );
              }

              if (provider.errorMessage != null) {
                return _buildErrorState(provider.errorMessage!);
              }

              if (provider.reports.isEmpty) {
                return _buildEmptyState();
              }

              return _buildReportList(provider.reports);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.surface,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.textMuted.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: Icon(
              Icons.history,
              color: AppColors.textMuted,
              size: 40,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            '暂无历史记录',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '完成测试后，记录将显示在这里',
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: AppColors.error,
            size: 48,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              SoundService.instance.playClick();
              context.read<ReportProvider>().loadReports();
            },
            child: Text(
              '重试试',
              style: TextStyle(color: AppColors.neonCyan),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportList(List<QuizReport> reports) {
    final deviceType = ResponsiveUtils.getDeviceType(context);
    final isDesktop = deviceType == DeviceType.desktop || 
                      deviceType == DeviceType.largeDesktop;
    
    if (isDesktop) {
      // 桌面端：使用网格布局
      return ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: GridView.builder(
              padding: const EdgeInsets.all(24),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: deviceType == DeviceType.largeDesktop ? 3 : 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 1.5,
              ),
              itemCount: reports.length,
              itemBuilder: (context, index) {
                final report = reports[index];
                return _buildReportGridCard(report, index);
              },
            ),
          ),
        ),
      );
    } else {
      // 移动端/平板：使用列表布局
      return ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: reports.length,
              itemBuilder: (context, index) {
                final report = reports[index];
                return _buildReportCard(report, index);
              },
            ),
          ),
        ),
      );
    }
  }

  /// 网格卡片（桌面端）
  Widget _buildReportGridCard(QuizReport report, int index) {
    final quizColor = _getQuizColor(report.quizTypeId);
    
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 200 + (index * 50).clamp(0, 300)),
      curve: AppAnimations.defaultCurve,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.scale(
            scale: 0.9 + (0.1 * value),
            child: child,
          ),
        );
      },
      child: GestureDetector(
        onTap: () => _viewReport(report),
        child: NeonCard(
          borderColor: quizColor,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: quizColor.withOpacity(0.15),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: quizColor.withOpacity(0.5),
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      _getQuizIcon(report.quizTypeId),
                      color: quizColor,
                      size: 28,
                    ),
                  ),
                  const Spacer(),
                  PopupMenuButton<String>(
                    icon: Icon(Icons.more_vert, color: AppColors.textMuted),
                    color: AppColors.surface,
                    onSelected: (value) {
                      if (value == 'delete') {
                        _confirmDelete(report);
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete_outline, color: AppColors.error, size: 20),
                            const SizedBox(width: 8),
                            Text('删除', style: TextStyle(color: AppColors.error)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                report.quizTypeName,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                _formatDate(report.createdAt),
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 13,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: quizColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: quizColor.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      '${report.ratings.length} 项',
                      style: TextStyle(
                        color: quizColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (report.shareCode != null) ...[
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        decoration: BoxDecoration(
                          color: quizColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          report.shareCode!,
                          style: TextStyle(
                            color: quizColor.withOpacity(0.8),
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReportCard(QuizReport report, int index) {
    final quizColor = _getQuizColor(report.quizTypeId);
    
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 200 + (index * 50).clamp(0, 300)),
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
        padding: const EdgeInsets.only(bottom: 12),
        child: Dismissible(
          key: Key(report.id),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              color: AppColors.error.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              Icons.delete,
              color: AppColors.error,
            ),
          ),
          confirmDismiss: (direction) async {
            _confirmDelete(report);
            return false;
          },
          child: GestureDetector(
            onTap: () => _viewReport(report),
            child: NeonCard(
              borderColor: quizColor,
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: quizColor.withOpacity(0.15),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: quizColor.withOpacity(0.5),
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      _getQuizIcon(report.quizTypeId),
                      color: quizColor,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          report.quizTypeName,
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _formatDate(report.createdAt),
                          style: TextStyle(
                            color: AppColors.textMuted,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              '${report.ratings.length} 项评分',
                              style: TextStyle(
                                color: quizColor.withOpacity(0.8),
                                fontSize: 12,
                              ),
                            ),
                            if (report.shareCode != null) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: quizColor.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  '分享码: ${report.shareCode}',
                                  style: TextStyle(
                                    color: quizColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete_outline,
                      color: AppColors.textMuted,
                    ),
                    onPressed: () {
                      SoundService.instance.playClick();
                      _confirmDelete(report);
                    },
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: quizColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
