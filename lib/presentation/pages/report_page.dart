import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_animations.dart';
import '../../core/utils/advanced_screenshot_utils.dart';
import '../../core/utils/toast_utils.dart';
import '../../core/services/path_manager.dart';
import '../../core/services/sound_service.dart';
import '../../core/constants/quiz_data.dart';
import '../../domain/models/quiz_type.dart';
import '../../domain/models/quiz_item.dart';
import '../../domain/models/quiz_report.dart';
import '../../domain/models/rating_level.dart';
import '../providers/report_provider.dart';
import '../providers/settings_provider.dart';
import '../widgets/neon_card.dart';
import '../widgets/glow_button.dart';
import '../widgets/report_table.dart';
import '../widgets/report_summary_card.dart';
import '../widgets/selection_detail_card.dart';
import '../widgets/custom_dialog.dart';
import '../widgets/mystic_background.dart';
class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  
  QuizReport? _report;
  QuizType? _quizType;
  bool _isLoading = true;
  bool _isFromNewQuiz = false;
  bool _autoSaveTriggered = false;
  final GlobalKey _reportKey = GlobalKey();
  final GlobalKey _visibleReportKey = GlobalKey();  // 用于普通截图的可见部分
  final Map<String, GlobalKey<SelectionDetailCardState>> _detailCardKeys = {};
  bool _allExpanded = false;
  final ScreenshotController _screenshotController = ScreenshotController();

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
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isLoading) {
      _loadReportData();
    }
  }


  void _loadReportData() {
    final args = ModalRoute.of(context)?.settings.arguments;
    
    if (args is Map<String, dynamic>) {
      // Coming from quiz test page with fresh data
      _quizType = args['quizType'] as QuizType?;
      final ratings = args['ratings'] as Map<String, RatingLevel>?;
      
      if (_quizType != null && ratings != null) {
        _report = _generateReport(_quizType!, ratings);
        _isFromNewQuiz = true;
        _saveReport(_report!);
      }
    } else if (args is QuizReport) {
      // Coming from history page with existing report
      _report = args;
      _isFromNewQuiz = false;
      
      // Fix for old reports that don't have selections data
      _fixOldReportSelections();
    }
    
    setState(() {
      _isLoading = false;
    });
    _animationController.forward();
    
    // Trigger auto-save screenshot after animation completes
    // Requirements: 6.4 - Auto save screenshot when report is generated
    if (_isFromNewQuiz && !_autoSaveTriggered) {
      _autoSaveTriggered = true;
      _animationController.addStatusListener(_onAnimationComplete);
    }
  }

  void _onAnimationComplete(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _animationController.removeStatusListener(_onAnimationComplete);
      _checkAndAutoSaveScreenshot();
    }
  }
  Future<void> _checkAndAutoSaveScreenshot() async {
    if (!mounted) return;
    
    final settingsProvider = context.read<SettingsProvider>();
    
    if (settingsProvider.autoSaveScreenshot) {
      // Small delay to ensure the widget is fully rendered
      await Future.delayed(const Duration(milliseconds: 300));
      if (!mounted) return;
      
      // 捕获截图
      final imageBytes = await _screenshotController.captureFromWidget(
        _buildVisibleReportWidget(),
        pixelRatio: 3.0,
      );
      
      if (imageBytes == null) return;
      
      // 保存截图
      final result = await AdvancedScreenshotUtils.saveScreenshot(
        imageBytes,
        fileName: 'quiz_report_${_report?.quizTypeName ?? "unknown"}_${DateTime.now().millisecondsSinceEpoch}',
      );
      
      if (!mounted) return;
      
      // Requirements: 6.5 - 显示简短的成功提示通知
      if (result.success) {
        _showSnackBar('报告已自动保存到相册', AppColors.neonGreen);
      }
    }
  }

  Widget _buildVisibleReportWidget() {
    final quizColor = _getQuizColor(_report!.quizTypeId);
    return Container(
      color: AppColors.background,
      width: 500,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildReportHeaderForScreenshot(quizColor),
            const SizedBox(height: 20),
            _buildSummarySection(quizColor),
            const SizedBox(height: 20),
            _buildDetailTable(quizColor),
          ],
        ),
      ),
    );
  }

  QuizReport _generateReport(QuizType quizType, Map<String, RatingLevel> ratings) {
    final categoryStats = <String, CategoryStats>{};
    
    // 调试：输出所有ratings的key
    print('=== DEBUG: All rating keys ===');
    ratings.keys.forEach((key) {
      print('Rating key: $key');
    });
    
    for (final category in quizType.categories) {
      print('\n=== Processing category: ${category.name} (${category.id}) ===');
      print('Category has ${category.items.length} items');
      
      final levelCounts = <RatingLevel, int>{};
      for (final level in RatingLevel.values) {
        levelCounts[level] = 0;
      }
      
      // 收集该分类下的所有选择详情
      final selections = <SelectionDetail>[];
      
      for (final item in category.items) {
        final rating = ratings[item.id];
        print('Checking item: ${item.id} - Rating: ${rating != null ? rating.code : 'null'}');
        if (rating != null) {
          levelCounts[rating] = (levelCounts[rating] ?? 0) + 1;
          // 保存每个选择项的详细信息
          selections.add(SelectionDetail(
            item: item,
            rating: rating,
          ));
        }
      }
      
      print('Category ${category.name} - Found ${selections.length} selections');
      
      final totalItems = category.items.length;
      final levelPercentages = <RatingLevel, double>{};
      for (final level in RatingLevel.values) {
        final count = levelCounts[level] ?? 0;
        levelPercentages[level] = totalItems > 0 ? (count / totalItems * 100) : 0.0;
      }
      
      categoryStats[category.id] = CategoryStats(
        categoryName: category.name,
        levelCounts: levelCounts,
        levelPercentages: levelPercentages,
        selections: selections, // 添加选择详情
      );
    }
    
    return QuizReport(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      quizTypeId: quizType.id,
      quizTypeName: quizType.name,
      createdAt: DateTime.now(),
      ratings: Map.from(ratings),
      categoryStats: categoryStats,
      shareCode: QuizReport.generateShareCode(), // 生成分享
    );
  }

  Future<void> _saveReport(QuizReport report) async {
    try {
      await context.read<ReportProvider>().saveReport(report);
    } catch (e) {
      // Handle error silently for now
      debugPrint('Error saving report: $e');
    }
  }
  void _fixOldReportSelections() {
    if (_report == null) return;
    
    // 检查是否有任何分类缺少selections
    bool needsFix = false;
    for (final stats in _report!.categoryStats.values) {
      if (stats.selections.isEmpty && stats.levelCounts.values.any((count) => count > 0)) {
        needsFix = true;
        break;
      }
    }
    
    if (!needsFix) return;
    
    print('=== Fixing old report selections ===');
    
    // 获取对应的测试类
    final quizType = _getQuizTypeFromReport(_report!);
    if (quizType == null) {
      print('Could not find quiz type for report');
      return;
    }
    
    // 重试建categoryStats，添加selections数据
    final updatedCategoryStats = <String, CategoryStats>{};
    
    for (final category in quizType.categories) {
      final existingStats = _report!.categoryStats[category.id];
      if (existingStats == null) continue;
      
      // 根据ratings重试建selections
      final selections = <SelectionDetail>[];
      for (final item in category.items) {
        final rating = _report!.ratings[item.id];
        if (rating != null) {
          selections.add(SelectionDetail(
            item: item,
            rating: rating,
          ));
        }
      }
      
      updatedCategoryStats[category.id] = CategoryStats(
        categoryName: existingStats.categoryName,
        levelCounts: existingStats.levelCounts,
        levelPercentages: existingStats.levelPercentages,
        selections: selections,
      );
    }
    
    // 创建更新后的报告
    _report = QuizReport(
      id: _report!.id,
      quizTypeId: _report!.quizTypeId,
      quizTypeName: _report!.quizTypeName,
      createdAt: _report!.createdAt,
      ratings: _report!.ratings,
      categoryStats: updatedCategoryStats,
      shareCode: _report!.shareCode,
      lastViewedAt: _report!.lastViewedAt,
    );
    
    // 保存更新后的报告
    _saveReport(_report!);
    print('Report selections fixed and saved');
  }
  
  QuizType? _getQuizTypeFromReport(QuizReport report) {
    // 根据报告的quizTypeId获取对应的测试类
    switch (report.quizTypeId) {
      case 'female_m':
        return QuizData.femaleMQuizType;
      case 'male_m':
        return QuizData.maleMQuizType;
      case 'cuckold':
        return QuizData.cuckoldQuizType;
      case 'female_desire':
        return QuizData.femaleDesireQuizType;
      default:
        return null;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Color _getQuizColor(String? quizTypeId) {
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
  Future<void> _shareReport() async {
    if (_report == null) return;
    
    final quizType = _getQuizTypeFromReport(_report!);
    final text = _generateShareText();
    
    await Share.share(
      text,
      subject: 'Quiz Report - ${_report!.quizTypeName}',
    );
  }
  String _generateShareText() {
    final buffer = StringBuffer();
    buffer.writeln('🌟 ${_report!.quizTypeName} 测试报告 🌟');
    buffer.writeln('分享 ${_report!.shareCode}');
    buffer.writeln('测试时间: ${_formatDateTime(_report!.createdAt)}');
    buffer.writeln();
    buffer.writeln('📊 统计概览:');
    
    for (final entry in _report!.categoryStats.entries) {
      final stats = entry.value;
      buffer.writeln('\n📦 ${stats.categoryName}:');
      for (final level in RatingLevel.values) {
        final count = stats.levelCounts[level] ?? 0;
        final percentage = stats.levelPercentages[level] ?? 0.0;
        if (count > 0) {
          buffer.writeln('  ${level.emoji} ${level.label}: $count(${percentage.toStringAsFixed(1)}%)');
        }
      }
    }
    
    return buffer.toString();
  }
  
  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} '
           '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
  Future<void> _handleScreenshot() async {
    final pathManager = PathManager.instance;
    final hasCustomPath = await pathManager.hasCustomPath();
    
    // 如果是电脑端且没有设置路径，先让用户设置路径
    if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
      if (!hasCustomPath) {
        final shouldSetPath = await CustomDialog.showConfirm(
          context,
          title: '设置保存路径',
          content: '您还未设置截图保存路径，是否现在设置？',
          confirmText: '设置路径',
          cancelText: '使用默认',
          color: AppColors.neonCyan,
        );
        
        if (shouldSetPath) {
          await _selectSavePath();
          // 设置路径后继续执行截
          if (!mounted) return;
        }
      }
    }
    
    // 显示截图选项
    _showScreenshotOptions();
  }
  Future<void> _showScreenshotOptions() async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            border: Border(
              top: BorderSide(
                color: _getQuizColor(_report!.quizTypeId).withOpacity(0.5),
                width: 2,
              ),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.textMuted,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '选择截图类型',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    leading: Icon(
                      Icons.image,
                      color: AppColors.neonGreen,
                    ),
                    title: Text(
                      '普通截图',
                      style: TextStyle(color: AppColors.textPrimary),
                    ),
                    subtitle: Text(
                      '保存当前显示的报告内容',
                      style: TextStyle(color: AppColors.textMuted),
                    ),
                    onTap: () {
                      SoundService.instance.playButton();
                      Navigator.pop(context);
                      _exportReport();
                    },
                  ),
                  const Divider(color: AppColors.textMuted),
                  ListTile(
                    leading: Icon(
                      Icons.fullscreen,
                      color: AppColors.neonPurple,
                    ),
                    title: Text(
                      '长截图',
                      style: TextStyle(color: AppColors.textPrimary),
                    ),
                    subtitle: Text(
                      '生成包含所有内容的完整截图',
                      style: TextStyle(color: AppColors.textMuted),
                    ),
                    onTap: () {
                      SoundService.instance.playButton();
                      Navigator.pop(context);
                      _captureLongScreenshot();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  Future<void> _exportReport() async {
    CustomDialog.showLoading(context, message: '正在生成截图...');
    
    // 捕获可见部分截图
    final imageBytes = await _screenshotController.captureFromWidget(
      _buildVisibleReportWidget(),
      pixelRatio: 3.0,
    );
    
    if (imageBytes == null) {
      CustomDialog.dismissLoading();
      if (!mounted) return;
      _showSnackBar('截图生成失败', AppColors.error);
      return;
    }
    
    // 保存截图
    final result = await AdvancedScreenshotUtils.saveScreenshot(
      imageBytes,
      fileName: 'quiz_report_${_report?.quizTypeName ?? "report"}_${DateTime.now().millisecondsSinceEpoch}',
    );
    
    CustomDialog.dismissLoading();
    if (!mounted) return;
    
    final pathManager = PathManager.instance;
    final hasCustomPath = await pathManager.hasCustomPath();
    
    if (result.success) {
      SoundService.instance.playSuccess();
      final message = hasCustomPath 
          ? '已保存到指定目录' 
          : result.message;
      _showSnackBar(message, AppColors.neonGreen);
    } else {
      _showSnackBar(result.message, AppColors.error);
    }
  }
  Future<void> _captureLongScreenshot({bool useCustomPath = false}) async {
    CustomDialog.showLoading(context, message: '正在生成长截..');
    
    // 先展开所有选项
    if (!_allExpanded) {
      setState(() {
        _allExpanded = true;
        for (final key in _detailCardKeys.values) {
          key.currentState?.setExpanded(true);
        }
      });
      
      // 等待UI更新
      await Future.delayed(const Duration(milliseconds: 500));
    }
    
    // 构建完整的报告Widget（不依赖状态和动画
    final quizColor = _getQuizColor(_report!.quizTypeId);
    final fullReportWidget = _buildCompleteReportForScreenshot(quizColor);
    
    // 捕获长截
    final imageBytes = await AdvancedScreenshotUtils.captureLongScreenshot(
      widget: fullReportWidget,
      pixelRatio: 3.0,
    );
    
    if (imageBytes == null) {
      if (!mounted) return;
      _showSnackBar('截图生成失败，请重试试', AppColors.error);
      return;
    }
    
    // 保存截图
    final result = await AdvancedScreenshotUtils.saveScreenshot(
      imageBytes,
      fileName: 'long_screenshot_${_report?.quizTypeName ?? "report"}_${DateTime.now().millisecondsSinceEpoch}',
      useCustomPath: useCustomPath,
    );
    
    CustomDialog.dismissLoading();
    if (!mounted) return;
    
    if (result.success) {
      SoundService.instance.playSuccess();
      final pathManager = PathManager.instance;
      final hasCustomPath = await pathManager.hasCustomPath();
      final message = hasCustomPath && !useCustomPath 
          ? '已保存到指定目录' 
          : result.message;
      _showSnackBar(message, AppColors.neonGreen);
    } else {
      _showSnackBar(result.message, AppColors.error);
    }
  }

  void _showSnackBar(String message, Color color) {
    if (color == AppColors.neonGreen) {
      ToastUtils.showSuccess(context, message);
    } else if (color == AppColors.error) {
      ToastUtils.showError(context, message);
    } else if (color == AppColors.neonCyan) {
      ToastUtils.showInfo(context, message);
    } else {
      ToastUtils.showToast(context, message, backgroundColor: color);
    }
  }
  Future<void> _selectSavePath() async {
    CustomDialog.showLoading(context, message: '选择保存路径...');
    
    final selectedPath = await AdvancedScreenshotUtils.selectSavePath();
    
    CustomDialog.dismissLoading();
    
    if (selectedPath != null) {
      await CustomDialog.showInfo(
        context,
        title: '路径已设置',
        content: '后续截图将保存到:\n$selectedPath',
        buttonText: '知道了',
        color: AppColors.neonGreen,
      );
    }
  }
  Widget _buildCompleteReportForScreenshot(Color quizColor) {
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 报告头部
          _buildReportHeaderForScreenshot(quizColor),
          const SizedBox(height: 20),
          // 概要部分
          _buildSummarySection(quizColor),
          const SizedBox(height: 20),
          // 详细表格
          _buildDetailTable(quizColor),
          const SizedBox(height: 20),
          // 选择详情（全部展开
          _buildExpandedSelectionDetails(quizColor),
          const SizedBox(height: 20),
          // 分析部分
          _buildAnalysisSection(quizColor),
        ],
      ),
    );
  }
  Widget _buildReportHeaderForScreenshot(Color quizColor) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: quizColor.withOpacity(0.6),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _getQuizIcon(_report!.quizTypeId),
                color: quizColor,
                size: 28,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _report!.quizTypeName,
                      style: TextStyle(
                        color: quizColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _formatDate(_report!.createdAt),
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: quizColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('总项目', '${_report!.ratings.length}', quizColor),
                _buildStatItem('分类', '${_report!.categoryStats.length}', quizColor),
                if (_report!.shareCode != null)
                  _buildStatItem('分享码', _report!.shareCode!, quizColor),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildExpandedSelectionDetails(Color quizColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '选择详情',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ..._report!.categoryStats.entries.map((entry) {
          final stats = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildStaticSelectionCard(
              categoryName: stats.categoryName,
              selections: stats.selections,
              accentColor: quizColor,
            ),
          );
        }).toList(),
      ],
    );
  }
  Widget _buildStaticSelectionCard({
    required String categoryName,
    required List<SelectionDetail> selections,
    required Color accentColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.textMuted.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.category,
                  color: accentColor,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    categoryName,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  '${selections.length} 项',
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: selections.map((selection) {
                final color = _getRatingColor(selection.rating);
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: color.withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        selection.rating.code,
                        style: TextStyle(
                          color: color,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          selection.item.name,
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Color _getRatingColor(RatingLevel rating) {
    switch (rating) {
      case RatingLevel.n:
        return AppColors.ratingN;
      case RatingLevel.q:
        return AppColors.ratingQ;
      case RatingLevel.s:
        return AppColors.neonCyan;
      case RatingLevel.ss:
        return AppColors.neonPurple;
      case RatingLevel.sss:
        return AppColors.neonGreen;
      case RatingLevel.w:
        return AppColors.textMuted;
    }
  }

  void _goHome() {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }


  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: CircularProgressIndicator(
            color: AppColors.neonCyan,
          ),
        ),
      );
    }

    if (_report == null) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.surface,
          title: const Text('测试报告'),
        ),
        body: const Center(
          child: Text(
            '无法加载报告数据',
            style: TextStyle(color: AppColors.textPrimary),
          ),
        ),
      );
    }

    final quizColor = _getQuizColor(_report!.quizTypeId);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: MysticBackground(
        primaryColor: quizColor,
        secondaryColor: quizColor.withOpacity(0.6),
        child: RepaintBoundary(
          key: _visibleReportKey,  // 用于普通截图的可见部分
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: CustomScrollView(
                slivers: [
                  _buildAppBar(quizColor),
                  SliverToBoxAdapter(
                    child: RepaintBoundary(
                      key: _reportKey,  // 用于长截图的完整内容
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildReportHeader(quizColor),
                            const SizedBox(height: 20),
                            _buildSummarySection(quizColor),
                            const SizedBox(height: 20),
                            _buildDetailTable(quizColor),
                            const SizedBox(height: 20),
                            _buildSelectionDetails(quizColor),
                            const SizedBox(height: 20),
                            _buildAnalysisSection(quizColor),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(Color quizColor) {
    return SliverAppBar(
      expandedHeight: 56,  // 标准AppBar高度
      toolbarHeight: 56,
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor: AppColors.surface,  // 与历史记录页面一
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: AppColors.textPrimary,
          size: 24,
        ),
        onPressed: () {
          SoundService.instance.playClick();
          _goHome();
        },
        tooltip: '返回首页',
      ),
      title: Text(
        '测试报告',
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(
            Icons.share_outlined,
            color: quizColor,  // 使用主题题色作为点缀
            size: 22,
          ),
          onPressed: () {
            SoundService.instance.playClick();
            _shareReport();
          },
          tooltip: '分享',
        ),
        IconButton(
          icon: Icon(
            Icons.camera_alt_outlined,
            color: quizColor,  // 使用主题题色作为点缀
            size: 22,
          ),
          onPressed: () {
            SoundService.instance.playClick();
            _handleScreenshot();
          },
          tooltip: '截图',
        ),
        const SizedBox(width: 8),  // 添加右侧间距，与下方内容的 padding 对齐
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  Widget _buildReportHeader(Color quizColor) {
    return NeonCard(
      borderColor: quizColor.withOpacity(0.6),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _getQuizIcon(_report!.quizTypeId),
                color: quizColor,
                size: 28,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _report!.quizTypeName,
                      style: TextStyle(
                        color: quizColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _formatDate(_report!.createdAt),
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: quizColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('总项目', '${_report!.ratings.length}', quizColor),
                _buildStatItem('分类', '${_report!.categoryStats.length}', quizColor),
                if (_report!.shareCode != null)
                  _buildStatItem('分享码', _report!.shareCode!, quizColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
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

  IconData _getQuizIcon(String? quizTypeId) {
    switch (quizTypeId) {
      case 'female_m':
        return Icons.female;
      case 'male_m':
        return Icons.male;
      case 'cuckold':
        return Icons.lock_open;
      case 'female_desire':
        return Icons.favorite;
      default:
        return Icons.quiz;
    }
  }


  Widget _buildSummarySection(Color quizColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.pie_chart_outline,
              color: quizColor,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              '总体统计',
              style: TextStyle(
                color: quizColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ReportSummaryCard(report: _report!),
      ],
    );
  }

  Widget _buildDetailTable(Color quizColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.table_chart_outlined,
              color: quizColor,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              '分类统计',
              style: TextStyle(
                color: quizColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ReportTable(report: _report!),
      ],
    );
  }

  Widget _buildSelectionDetails(Color quizColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.checklist,
              color: quizColor,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              '选择详情',
              style: TextStyle(
                color: quizColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            TextButton.icon(
              onPressed: _toggleAllExpansion,
              icon: Icon(
                _allExpanded ? Icons.unfold_less : Icons.unfold_more,
                color: quizColor,
                size: 16,
              ),
              label: Text(
                _allExpanded ? '全部折叠' : '全部展开',
                style: TextStyle(
                  color: quizColor,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ..._report!.categoryStats.entries.map((entry) {
          final stats = entry.value;
          final key = GlobalKey<SelectionDetailCardState>();
          _detailCardKeys[entry.key] = key;
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: SelectionDetailCard(
              key: key,
              categoryName: stats.categoryName,
              selections: stats.selections,
              accentColor: quizColor,
              initiallyExpanded: _allExpanded,
            ),
          );
        }).toList(),
      ],
    );
  }

  void _toggleAllExpansion() {
    setState(() {
      _allExpanded = !_allExpanded;
      for (final key in _detailCardKeys.values) {
        key.currentState?.setExpanded(_allExpanded);
      }
    });
  }

  Widget _buildAnalysisSection(Color quizColor) {
    // Calculate dominant rating
    final totalCounts = <RatingLevel, int>{};
    for (final level in RatingLevel.values) {
      totalCounts[level] = 0;
    }
    for (final stats in _report!.categoryStats.values) {
      for (final entry in stats.levelCounts.entries) {
        totalCounts[entry.key] = (totalCounts[entry.key] ?? 0) + entry.value;
      }
    }
    
    RatingLevel? dominantLevel;
    int maxCount = 0;
    for (final entry in totalCounts.entries) {
      if (entry.value > maxCount) {
        maxCount = entry.value;
        dominantLevel = entry.key;
      }
    }

    return NeonCard(
      borderColor: quizColor.withOpacity(0.6),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.psychology_outlined,
                color: quizColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                '倾向分析',
                style: TextStyle(
                  color: quizColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (dominantLevel != null) ...[
            Text(
              '主题要倾向: ${dominantLevel.description}',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _getAnalysisText(dominantLevel),
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
                height: 1.6,
              ),
            ),
          ],
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: AppColors.textMuted,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '本测试结果仅供参考，帮助你更好地了解自己的内心倾向。',
                    style: TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getAnalysisText(RatingLevel level) {
    switch (level) {
      case RatingLevel.sss:
        return '你对测试中的大部分项目表现出强烈的兴趣和热情。这表明你是一个开放、积极探索的人，愿意尝试新事物。';
      case RatingLevel.ss:
        return '你对测试中的许多项目持积极态度。这说明你有较强的好奇心，同时也保持着一定的理性判断。';
      case RatingLevel.s:
        return '你对测试中的项目持中立态度居多。这表明你是一个理性、客观的人，不会轻易被情绪左右。';
      case RatingLevel.q:
        return '你对一些项目虽然不太喜欢，但仍愿意尝试。这说明你有较强的适应能力和包容心。';
      case RatingLevel.n:
        return '你对测试中的许多项目持保守态度。这表明你有明确的底线和原则，知道自己想要什么。';
      case RatingLevel.w:
        return '你对许多项目还不太确定自己的态度。这可能意味着你还在探索和了解自己的过程中。';
    }
  }

}
