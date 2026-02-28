import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_colors.dart';
import '../../core/services/database_service.dart';
import '../../core/services/sound_service.dart';
import '../../core/utils/toast_utils.dart';
import '../../domain/models/quiz_report.dart';
import '../widgets/custom_dialog.dart';
import '../widgets/mystic_background.dart';
import 'report_page.dart';

/// 管理员页面 - 查看所有测试数据
class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  bool _isLoading = true;
  Map<String, dynamic>? _stats;
  List<dynamic> _reports = [];
  int _currentPage = 1;
  final int _pageSize = 20;
  Map<String, dynamic>? _pagination;
  String? _selectedQuizType;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    // 加载统计数据
    final statsResult = await DatabaseService.instance.getStats();
    if (statsResult['success']) {
      _stats = statsResult['data'];
    }

    // 加载报告列表
    final reportsResult = await DatabaseService.instance.getReportList(
      page: _currentPage,
      limit: _pageSize,
      quizType: _selectedQuizType,
    );

    if (reportsResult['success']) {
      _reports = reportsResult['data'];
      _pagination = reportsResult['pagination'];
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _viewReport(String shareCode) async {
    CustomDialog.showLoading(context, message: '加载中...');

    final result = await DatabaseService.instance.downloadReport(
      shareCode: shareCode,
    );

    CustomDialog.dismissLoading();

    if (!mounted) return;

    if (result['success']) {
      final report = result['data'] as QuizReport;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ReportPage(sharedReport: report),
        ),
      );
    } else {
      ToastUtils.showError(context, result['message']);
    }
  }

  Future<void> _deleteReport(String shareCode) async {
    final confirmed = await CustomDialog.showConfirm(
      context,
      title: '确认删除',
      content: '确定要删除这份报告吗？此操作不可恢复。',
      confirmText: '删除',
      cancelText: '取消',
      color: AppColors.error,
    );

    if (!confirmed) return;

    CustomDialog.showLoading(context, message: '删除中...');

    final result = await DatabaseService.instance.deleteReport(
      shareCode: shareCode,
    );

    CustomDialog.dismissLoading();

    if (!mounted) return;

    if (result['success']) {
      SoundService.instance.playSuccess();
      ToastUtils.showSuccess(context, '删除成功');
      _loadData();
    } else {
      ToastUtils.showError(context, result['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!DatabaseService.instance.isConfigured) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.surface,
          title: const Text('管理后台'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.cloud_off,
                  size: 80,
                  color: AppColors.textMuted,
                ),
                const SizedBox(height: 24),
                Text(
                  '数据库未配置',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '请先部署后端到 Vercel，然后在 database_service.dart 中配置 API 地址',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Text(
                  '查看部署指南：\nbackend/vercel/README.md',
                  style: TextStyle(
                    color: AppColors.neonCyan,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: MysticBackground(
        primaryColor: AppColors.neonPurple,
        secondaryColor: AppColors.neonCyan,
        child: CustomScrollView(
          slivers: [
            _buildAppBar(),
            if (_isLoading)
              const SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.neonCyan,
                  ),
                ),
              )
            else ...[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildStatsSection(),
                      const SizedBox(height: 24),
                      _buildFilterSection(),
                      const SizedBox(height: 16),
                      _buildReportsList(),
                      if (_pagination != null) ...[
                        const SizedBox(height: 16),
                        _buildPagination(),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 56,
      toolbarHeight: 56,
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor: AppColors.surface,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: AppColors.textPrimary,
          size: 24,
        ),
        onPressed: () {
          SoundService.instance.playClick();
          Navigator.pop(context);
        },
      ),
      title: Row(
        children: [
          Icon(Icons.admin_panel_settings, color: AppColors.neonPurple),
          const SizedBox(width: 8),
          Text(
            '管理后台',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.refresh, color: AppColors.neonCyan),
          onPressed: () {
            SoundService.instance.playClick();
            _loadData();
          },
          tooltip: '刷新',
        ),
      ],
    );
  }

  Widget _buildStatsSection() {
    if (_stats == null) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.neonPurple.withOpacity(0.5),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.analytics, color: AppColors.neonPurple),
              const SizedBox(width: 8),
              Text(
                '数据统计',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  '总报告',
                  '${_stats!['totalReports']}',
                  Icons.description,
                  AppColors.neonCyan,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  '今日新增',
                  '${_stats!['todayReports']}',
                  Icons.today,
                  AppColors.neonGreen,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  '本周新增',
                  '${_stats!['weekReports']}',
                  Icons.calendar_today,
                  AppColors.neonOrange,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  '总浏览',
                  '${_stats!['totalViews']}',
                  Icons.visibility,
                  AppColors.neonPink,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.neonCyan.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.filter_list, color: AppColors.neonCyan, size: 20),
          const SizedBox(width: 8),
          Text(
            '筛选：',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Wrap(
              spacing: 8,
              children: [
                _buildFilterChip('全部', null),
                _buildFilterChip('女性M', 'female_m'),
                _buildFilterChip('男性M', 'male_m'),
                _buildFilterChip('绿帽', 'cuckold'),
                _buildFilterChip('女性欲望', 'female_desire'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String? quizType) {
    final isSelected = _selectedQuizType == quizType;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        SoundService.instance.playClick();
        setState(() {
          _selectedQuizType = selected ? quizType : null;
          _currentPage = 1;
        });
        _loadData();
      },
      backgroundColor: AppColors.surfaceLight,
      selectedColor: AppColors.neonCyan.withOpacity(0.2),
      labelStyle: TextStyle(
        color: isSelected ? AppColors.neonCyan : AppColors.textSecondary,
        fontSize: 12,
      ),
      side: BorderSide(
        color: isSelected
            ? AppColors.neonCyan
            : AppColors.textMuted.withOpacity(0.3),
      ),
    );
  }

  Widget _buildReportsList() {
    if (_reports.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.inbox,
                size: 64,
                color: AppColors.textMuted,
              ),
              const SizedBox(height: 16),
              Text(
                '暂无数据',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: _reports.map((report) => _buildReportCard(report)).toList(),
    );
  }

  Widget _buildReportCard(dynamic report) {
    final shareCode = report['share_code'];
    final quizTypeName = report['quiz_type_name'];
    final createdAt = DateTime.parse(report['created_at']);
    final viewCount = report['view_count'] ?? 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.neonCyan.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.neonCyan.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.neonCyan.withOpacity(0.5)),
                ),
                child: Text(
                  shareCode,
                  style: TextStyle(
                    color: AppColors.neonCyan,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  quizTypeName,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.access_time, size: 14, color: AppColors.textMuted),
              const SizedBox(width: 4),
              Text(
                _formatDateTime(createdAt),
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: 16),
              Icon(Icons.visibility, size: 14, color: AppColors.textMuted),
              const SizedBox(width: 4),
              Text(
                '$viewCount 次浏览',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () {
                  SoundService.instance.playClick();
                  Clipboard.setData(ClipboardData(text: shareCode));
                  ToastUtils.showSuccess(context, '分享码已复制');
                },
                icon: Icon(Icons.copy, size: 16, color: AppColors.neonGreen),
                label: Text(
                  '复制',
                  style: TextStyle(color: AppColors.neonGreen),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  SoundService.instance.playClick();
                  _viewReport(shareCode);
                },
                icon: Icon(Icons.visibility, size: 16, color: AppColors.neonCyan),
                label: Text(
                  '查看',
                  style: TextStyle(color: AppColors.neonCyan),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  SoundService.instance.playClick();
                  _deleteReport(shareCode);
                },
                icon: Icon(Icons.delete, size: 16, color: AppColors.error),
                label: Text(
                  '删除',
                  style: TextStyle(color: AppColors.error),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPagination() {
    if (_pagination == null) return const SizedBox.shrink();

    final totalPages = _pagination!['pages'];
    final currentPage = _pagination!['page'];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: currentPage > 1
                ? () {
                    SoundService.instance.playClick();
                    setState(() {
                      _currentPage--;
                    });
                    _loadData();
                  }
                : null,
            icon: Icon(
              Icons.chevron_left,
              color: currentPage > 1
                  ? AppColors.neonCyan
                  : AppColors.textMuted,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            '$currentPage / $totalPages',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 16),
          IconButton(
            onPressed: currentPage < totalPages
                ? () {
                    SoundService.instance.playClick();
                    setState(() {
                      _currentPage++;
                    });
                    _loadData();
                  }
                : null,
            icon: Icon(
              Icons.chevron_right,
              color: currentPage < totalPages
                  ? AppColors.neonCyan
                  : AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} '
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
