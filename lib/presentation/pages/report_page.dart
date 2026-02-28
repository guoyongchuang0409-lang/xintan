import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_animations.dart';
import '../../core/utils/toast_utils.dart';
import '../../core/utils/responsive_utils.dart';
import '../../core/services/sound_service.dart';
import '../../core/services/netlify_forms_service.dart';
import '../../core/services/database_service.dart';
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
  final QuizReport? sharedReport;
  
  const ReportPage({super.key, this.sharedReport});

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
  final Map<String, GlobalKey<SelectionDetailCardState>> _detailCardKeys = {};
  bool _allExpanded = false;

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
    // 如果是分享的报告，直接使用
    if (widget.sharedReport != null) {
      _report = widget.sharedReport;
      _isFromNewQuiz = false;
      setState(() {
        _isLoading = false;
      });
      _animationController.forward();
      return;
    }
    
    final args = ModalRoute.of(context)?.settings.arguments;
    
    if (args is Map<String, dynamic>) {
      // Coming from quiz test page with fresh data
      _quizType = args['quizType'] as QuizType?;
      final ratings = args['ratings'] as Map<String, RatingLevel>?;
      
      if (_quizType != null && ratings != null) {
        _report = _generateReport(_quizType!, ratings);
        _isFromNewQuiz = true;
        _saveReport(_report!);
        
        // 自动静默上传到云端
        _uploadToCloudSilently();
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
    // 已删除自动截图功能
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
    
    CustomDialog.showLoading(context, message: '正在生成分享图片...');
    
    // 构建完整的报告Widget
    final quizColor = _getQuizColor(_report!.quizTypeId);
    final fullReportWidget = _buildCompleteReportForScreenshot(quizColor);
    
    // 根据内容量计算延迟时间
    final categoryCount = _report!.categoryStats.length;
    final totalItems = _report!.ratings.length;
    final delayMs = 800 + (categoryCount * 150) + (totalItems ~/ 5 * 30);
    
    // 捕获长截图
    final imageBytes = await AdvancedScreenshotUtils.captureLongScreenshot(
      widget: fullReportWidget,
      pixelRatio: 3.0,
      context: context,
      targetWidth: 390,
      delayMs: delayMs.clamp(800, 3000),
    );
    
    CustomDialog.dismissLoading();
    
    if (imageBytes == null) {
      if (!mounted) return;
      _showSnackBar('生成分享图片失败', AppColors.error);
      return;
    }
    
    // 保存到临时文件并分享
    try {
      if (PlatformUtils.isWeb) {
        // Web 平台：直接使用 XFile 分享
        final xFile = XFile.fromData(
          imageBytes,
          name: 'quiz_report_${DateTime.now().millisecondsSinceEpoch}.png',
          mimeType: 'image/png',
        );
        
        await Share.shareXFiles(
          [xFile],
          text: '${_report!.quizTypeName} 测试报告',
          subject: 'Quiz Report - ${_report!.quizTypeName}',
        );
      } else {
        // 移动端和桌面端：保存到临时文件
        final tempDir = await getTemporaryDirectory();
        final tempFile = File('${tempDir.path}/share_report_${DateTime.now().millisecondsSinceEpoch}.png');
        await tempFile.writeAsBytes(imageBytes);
        
        await Share.shareXFiles(
          [XFile(tempFile.path)],
          text: '${_report!.quizTypeName} 测试报告',
          subject: 'Quiz Report - ${_report!.quizTypeName}',
        );
        
        // 分享后删除临时文件
        await tempFile.delete();
      }
    } catch (e) {
      debugPrint('分享失败: $e');
      if (!mounted) return;
      _showSnackBar('分享失败: $e', AppColors.error);
    }
  }

  /// 生成分享链接（使用 URL 参数）
  Future<void> _generateShareLink() async {
    if (_report == null) return;
    
    try {
      // 使用 NetlifyFormsService 生成分享链接
      final shareUrl = NetlifyFormsService.instance.generateShareUrl(
        report: _report!,
        baseUrl: 'https://xintan.netlify.app',
      );
      
      _showShareLinkDialog(shareUrl);
    } catch (e) {
      _showSnackBar('生成分享链接失败：$e', AppColors.error);
    }
  }

  /// 显示分享链接对话框
  void _showShareLinkDialog(String shareUrl) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: AppColors.neonCyan.withOpacity(0.5)),
        ),
        title: Row(
          children: [
            Icon(Icons.link, color: AppColors.neonCyan, size: 28),
            const SizedBox(width: 12),
            Text(
              '分享链接',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.neonCyan.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.neonCyan.withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.qr_code_2,
                    color: AppColors.neonCyan,
                    size: 48,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '复制链接发送给朋友',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '朋友打开链接即可查看你的测试结果',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '分享链接',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.neonPurple.withOpacity(0.3)),
              ),
              child: SelectableText(
                shareUrl,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 11,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.neonGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle_outline, color: AppColors.neonGreen, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '链接永久有效，无需登录即可查看',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              '关闭',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
          TextButton(
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: shareUrl));
              if (!context.mounted) return;
              Navigator.pop(context);
              _showSnackBar('链接已复制到剪贴板', AppColors.neonGreen);
            },
            child: Text(
              '复制链接',
              style: TextStyle(color: AppColors.neonCyan),
            ),
          ),
        ],
      ),
    );
  }

  /// 上传测试结果到数据库 - 静默上传，无提示
  Future<void> _uploadToCloudSilently() async {
    if (_report == null) {
      debugPrint('❌ [自动上传] 报告为空，跳过上传');
      return;
    }
    
    debugPrint('🚀 [自动上传] 开始上传测试结果...');
    debugPrint('📊 [自动上传] 测试类型: ${_report!.quizTypeName}');
    debugPrint('🔑 [自动上传] 分享码: ${_report!.shareCode}');
    debugPrint('⏰ [自动上传] 创建时间: ${_report!.createdAt}');
    
    try {
      final startTime = DateTime.now();
      
      // 静默上传到数据库，不显示加载提示
      final result = await DatabaseService.instance.uploadReport(
        report: _report!,
      );
      
      final duration = DateTime.now().difference(startTime);
      
      if (result['success']) {
        debugPrint('✅ [自动上传] 上传成功！');
        debugPrint('⏱️  [自动上传] 耗时: ${duration.inMilliseconds}ms');
        debugPrint('🔑 [自动上传] 分享码: ${result['shareCode']}');
      } else {
        debugPrint('⚠️  [自动上传] 上传失败');
        debugPrint('❌ [自动上传] 错误信息: ${result['message']}');
      }
    } catch (e, stackTrace) {
      // 失败也不显示提示，只在控制台记录
      debugPrint('❌ [自动上传] 上传异常: $e');
      debugPrint('📍 [自动上传] 堆栈跟踪: $stackTrace');
    }
    
    debugPrint('🏁 [自动上传] 上传流程结束');
  }

  /// 上传测试结果到云端（Netlify Forms）- 手动上传，有提示
  Future<void> _uploadToCloud() async {
    if (_report == null) return;
    
    // 确认对话框
    final confirmed = await CustomDialog.showConfirm(
      context,
      title: '上传到云端',
      content: '将测试结果上传到云端，方便管理员查看统计数据。\n\n上传的数据仅管理员可见，不会公开。',
      confirmText: '上传',
      cancelText: '取消',
      color: AppColors.neonCyan,
    );
    
    if (!confirmed) return;
    
    CustomDialog.showLoading(context, message: '正在上传...');
    
    try {
      final result = await NetlifyFormsService.instance.submitReport(
        report: _report!,
        netlifyUrl: 'https://xintan.netlify.app', // 你的 Netlify 网址
      );
      
      CustomDialog.dismissLoading();
      
      if (!mounted) return;
      
      if (result['success']) {
        SoundService.instance.playSuccess();
        _showUploadSuccessDialog(result['shareCode']);
      } else {
        _showSnackBar(result['message'], AppColors.error);
      }
    } catch (e) {
      CustomDialog.dismissLoading();
      if (!mounted) return;
      _showSnackBar('上传失败：$e', AppColors.error);
    }
  }

  /// 显示上传成功对话框
  void _showUploadSuccessDialog(String shareCode) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: AppColors.neonGreen.withOpacity(0.5)),
        ),
        title: Row(
          children: [
            Icon(Icons.check_circle, color: AppColors.neonGreen, size: 28),
            const SizedBox(width: 12),
            Text(
              '上传成功',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.neonGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.neonGreen.withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.cloud_done,
                    color: AppColors.neonGreen,
                    size: 48,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '测试结果已成功上传到云端',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '分享码：$shareCode',
                    style: TextStyle(
                      color: AppColors.neonCyan,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.neonCyan.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: AppColors.neonCyan, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '管理员可以在 Netlify 后台查看所有测试数据',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              '关闭',
              style: TextStyle(color: AppColors.neonGreen, fontSize: 16),
            ),
          ),
        ],
      ),
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
    // Web 平台：直接显示截图选项，不需要设置路径
    if (PlatformUtils.isWeb) {
      _showScreenshotOptions();
      return;
    }
    
    // 桌面端：检查是否需要设置路径
    final pathManager = PathManager.instance;
    final hasCustomPath = await pathManager.hasCustomPath();
    
    if (PlatformUtils.isDesktop) {
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
          // 设置路径后继续执行截图
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
                    leading: Icon(Icons.image, color: AppColors.neonGreen),
                    title: Text('普通截图', style: TextStyle(color: AppColors.textPrimary)),
                    subtitle: Text(
                      PlatformUtils.isWeb 
                        ? '保存当前显示的报告内容（Web端将触发下载）' 
                        : '保存当前显示的报告内容', 
                      style: TextStyle(color: AppColors.textMuted)
                    ),
                    onTap: () {
                      SoundService.instance.playButton();
                      Navigator.pop(context);
                      _exportReport();
                    },
                  ),
                  const Divider(color: AppColors.textMuted),
                  ListTile(
                    leading: Icon(Icons.fullscreen, color: AppColors.neonPurple),
                    title: Text('长截图', style: TextStyle(color: AppColors.textPrimary)),
                    subtitle: Text(
                      PlatformUtils.isWeb 
                        ? '保存完整报告内容（Web端将触发下载）' 
                        : '保存完整报告内容（包含所有详情）', 
                      style: TextStyle(color: AppColors.textMuted)
                    ),
                    onTap: () {
                      SoundService.instance.playButton();
                      Navigator.pop(context);
                      _captureLongScreenshot();
                    },
                  ),
                  if (PlatformUtils.isWeb) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.neonCyan.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline, color: AppColors.neonCyan, size: 16),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Web端建议使用分享按钮，可以直接分享或保存图片',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
    
    // 构建普通截图的widget（包含头部、概要、表格）
    final quizColor = _getQuizColor(_report!.quizTypeId);
    final screenshotWidget = _buildNormalScreenshotWidget(quizColor);
    
    // 捕获截图
    final imageBytes = await AdvancedScreenshotUtils.captureLongScreenshot(
      widget: screenshotWidget,
      pixelRatio: 3.0,
      context: context,
      targetWidth: 390,
      delayMs: 500,
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
  
  /// 构建普通截图的Widget（头部+概要+表格）
  Widget _buildNormalScreenshotWidget(Color quizColor) {
    return SizedBox(
      width: 390, // 固定宽度
      child: Container(
        color: AppColors.background,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildReportHeaderForScreenshot(quizColor),
            const SizedBox(height: 20),
            _buildSummarySectionForScreenshot(quizColor),
            const SizedBox(height: 20),
            _buildDetailTableForScreenshot(quizColor),
          ],
        ),
      ),
    );
  }
  
  /// 截图专用的概要部分
  Widget _buildSummarySectionForScreenshot(Color quizColor) {
    // 计算总体统计
    final totalCounts = <RatingLevel, int>{};
    int totalItems = 0;
    
    for (final level in RatingLevel.values) {
      totalCounts[level] = 0;
    }
    
    for (final stats in _report!.categoryStats.values) {
      for (final entry in stats.levelCounts.entries) {
        totalCounts[entry.key] = (totalCounts[entry.key] ?? 0) + entry.value;
        totalItems += entry.value;
      }
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.pie_chart_outline, color: quizColor, size: 20),
            const SizedBox(width: 8),
            Text(
              '总体统计',
              style: TextStyle(color: quizColor, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.neonCyan.withOpacity(0.5)),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.analytics_outlined, color: AppColors.neonCyan, size: 24),
                    const SizedBox(width: 8),
                    Text(
                      '$totalItems 项评分',
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ...RatingLevel.values.where((level) => (totalCounts[level] ?? 0) > 0).map((level) {
                final count = totalCounts[level] ?? 0;
                final percentage = totalItems > 0 
                    ? (count / totalItems * 100).toStringAsFixed(1)
                    : '0.0';
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: _buildRatingRowForScreenshot(level, count, percentage),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildRatingRowForScreenshot(RatingLevel level, int count, String percentage) {
    final color = _getRatingColor(level);
    return Row(
      children: [
        Container(
          width: 50,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.5)),
          ),
          child: Center(
            child: Text(
              level.code,
              style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(level.description, style: const TextStyle(color: AppColors.textPrimary, fontSize: 13)),
                  const Spacer(),
                  Text('$count 项', style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
                  const SizedBox(width: 8),
                  Text('($percentage%)', style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold)),
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
  
  /// 截图专用的表格部分
  Widget _buildDetailTableForScreenshot(Color quizColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.table_chart_outlined, color: quizColor, size: 20),
            const SizedBox(width: 8),
            Text(
              '分类统计',
              style: TextStyle(color: quizColor, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.neonCyan.withOpacity(0.3)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    border: Border(bottom: BorderSide(color: AppColors.neonCyan.withOpacity(0.3))),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  child: Row(
                    children: [
                      const Expanded(flex: 2, child: Text('分类', style: TextStyle(color: AppColors.neonCyan, fontWeight: FontWeight.bold, fontSize: 12), textAlign: TextAlign.center)),
                      ...RatingLevel.values.map((level) => Expanded(
                        child: Text(level.code, style: TextStyle(color: _getRatingColor(level), fontWeight: FontWeight.bold, fontSize: 11), textAlign: TextAlign.center),
                      )),
                    ],
                  ),
                ),
                // Data rows
                ..._report!.categoryStats.entries.toList().asMap().entries.map((entry) {
                  final index = entry.key;
                  final stats = entry.value.value;
                  return Container(
                    decoration: BoxDecoration(
                      color: index % 2 == 0 ? AppColors.surface : AppColors.surface.withOpacity(0.5),
                      border: Border(bottom: BorderSide(color: AppColors.textMuted.withOpacity(0.1))),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                    child: Row(
                      children: [
                        Expanded(flex: 2, child: Text(stats.categoryName, style: const TextStyle(color: AppColors.textPrimary, fontSize: 11), textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis)),
                        ...RatingLevel.values.map((level) {
                          final count = stats.levelCounts[level] ?? 0;
                          final percentage = stats.levelPercentages[level] ?? 0.0;
                          return Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(count.toString(), style: TextStyle(color: count > 0 ? _getRatingColor(level) : AppColors.textMuted, fontWeight: count > 0 ? FontWeight.bold : FontWeight.normal, fontSize: 13)),
                                if (count > 0) Text('${percentage.toStringAsFixed(0)}%', style: TextStyle(color: _getRatingColor(level).withOpacity(0.7), fontSize: 9)),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }
  Future<void> _captureLongScreenshot({bool useCustomPath = false}) async {
    CustomDialog.showLoading(context, message: '正在生成长截图...');
    
    // 构建完整的报告Widget（包含所有内容，不依赖状态和动画）
    final quizColor = _getQuizColor(_report!.quizTypeId);
    final fullReportWidget = _buildCompleteReportForScreenshot(quizColor);
    
    // 根据内容量计算延迟时间
    final categoryCount = _report!.categoryStats.length;
    final totalItems = _report!.ratings.length;
    final delayMs = 800 + (categoryCount * 150) + (totalItems ~/ 5 * 30);
    
    // 捕获长截图
    final imageBytes = await AdvancedScreenshotUtils.captureLongScreenshot(
      widget: fullReportWidget,
      pixelRatio: 3.0,
      context: context,
      targetWidth: 390,
      delayMs: delayMs.clamp(800, 3000),
    );
    
    if (imageBytes == null) {
      CustomDialog.dismissLoading();
      if (!mounted) return;
      _showSnackBar('截图生成失败，请重试', AppColors.error);
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
      // 移动端显示"已保存至相册"，电脑端显示保存路径
      String message;
      if (PlatformUtils.isDesktop) {
        final pathManager = PathManager.instance;
        final hasCustomPath = await pathManager.hasCustomPath();
        message = hasCustomPath && !useCustomPath ? '截图已保存到指定目录' : result.message;
      } else {
        message = '截图已保存至相册';
      }
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
  /// 构建完整的报告Widget用于长截图
  /// 使用MainAxisSize.min让Column根据内容自动确定高度
  /// 不依赖滚动位置，包含所有报告部分
  Widget _buildCompleteReportForScreenshot(Color quizColor) {
    // 使用SizedBox设置固定宽度，让截图有明确的边界
    return SizedBox(
      width: 390, // 固定宽度
      child: Container(
        color: AppColors.background,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min, // 让Column根据内容自动确定高度
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. 报告头部 - 包含测试类型、时间、统计概览
            _buildReportHeaderForScreenshot(quizColor),
            const SizedBox(height: 20),
            // 2. 概要部分 - 总体统计（使用截图专用版本）
            _buildSummarySectionForScreenshot(quizColor),
            const SizedBox(height: 20),
            // 3. 详细表格 - 分类统计（使用截图专用版本）
            _buildDetailTableForScreenshot(quizColor),
            const SizedBox(height: 20),
            // 4. 选择详情 - 全部展开显示所有选择项
            _buildExpandedSelectionDetailsForScreenshot(quizColor),
            const SizedBox(height: 20),
            // 5. 分析部分 - 倾向分析
            _buildAnalysisSectionForScreenshot(quizColor),
          ],
        ),
      ),
    );
  }
  
  /// 截图专用的选择详情部分
  Widget _buildExpandedSelectionDetailsForScreenshot(Color quizColor) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.checklist, color: quizColor, size: 20),
            const SizedBox(width: 8),
            Text(
              '选择详情',
              style: TextStyle(color: quizColor, fontSize: 16, fontWeight: FontWeight.bold),
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
        }),
      ],
    );
  }
  
  /// 截图专用的分析部分
  Widget _buildAnalysisSectionForScreenshot(Color quizColor) {
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

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: quizColor.withOpacity(0.6), width: 2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.psychology_outlined, color: quizColor, size: 20),
              const SizedBox(width: 8),
              Text(
                '倾向分析',
                style: TextStyle(color: quizColor, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (dominantLevel != null) ...[
            Text(
              '主要倾向: ${dominantLevel.description}',
              style: const TextStyle(color: AppColors.textPrimary, fontSize: 15, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Text(
              _getAnalysisText(dominantLevel),
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 14, height: 1.6),
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
                Icon(Icons.info_outline, color: AppColors.textMuted, size: 16),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    '本测试结果仅供参考，帮助你更好地了解自己的内心倾向。',
                    style: TextStyle(color: AppColors.textMuted, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
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
  Widget _buildStaticSelectionCard({
    required String categoryName,
    required List<SelectionDetail> selections,
    required Color accentColor,
  }) {
    // 安全处理空数据
    if (selections.isEmpty) {
      return Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.textMuted.withOpacity(0.3),
            width: 1,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Text(
          '$categoryName - 暂无数据',
          style: TextStyle(color: AppColors.textMuted),
        ),
      );
    }
    
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
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  // 使用约束盒子代替Flexible，避免在长截图中的布局问题
                  constraints: const BoxConstraints(maxWidth: 200),
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
                      // 使用ConstrainedBox代替Flexible，确保文本有固定的最大宽度
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 150),
                        child: Text(
                          selection.item.name,
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
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
      case RatingLevel.sss:
        return AppColors.ratingSSS;
      case RatingLevel.s:
        return AppColors.ratingS;
      case RatingLevel.n:
        return AppColors.ratingN;
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
    final layoutConfig = ResponsiveUtils.getReportLayoutConfig(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: MysticBackground(
        primaryColor: quizColor,
        secondaryColor: quizColor.withOpacity(0.6),
        child: RepaintBoundary(
          key: _visibleReportKey,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: CustomScrollView(
                slivers: [
                  _buildAppBar(quizColor),
                  SliverToBoxAdapter(
                    child: RepaintBoundary(
                      key: _reportKey,
                      child: Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: layoutConfig.contentMaxWidth,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: layoutConfig.horizontalPadding,
                              vertical: 16,
                            ),
                            child: _buildResponsiveContent(quizColor, layoutConfig),
                          ),
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

  /// 构建响应式内容布局
  Widget _buildResponsiveContent(Color quizColor, ReportLayoutConfig config) {
    if (config.useMultiColumn) {
      // 桌面端：使用多列布局
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildReportHeader(quizColor),
          SizedBox(height: config.cardSpacing),
          // 概要和表格并排显示
          if (config.summaryColumns == 2)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSummarySection(quizColor),
                    ],
                  ),
                ),
                SizedBox(width: config.cardSpacing),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailTable(quizColor),
                    ],
                  ),
                ),
              ],
            )
          else ...[
            _buildSummarySection(quizColor),
            SizedBox(height: config.cardSpacing),
            _buildDetailTable(quizColor),
          ],
          SizedBox(height: config.cardSpacing),
          _buildSelectionDetails(quizColor),
          SizedBox(height: config.cardSpacing),
          _buildAnalysisSection(quizColor),
        ],
      );
    } else {
      // 移动端/平板：单列布局
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildReportHeader(quizColor),
          SizedBox(height: config.cardSpacing),
          _buildSummarySection(quizColor),
          SizedBox(height: config.cardSpacing),
          _buildDetailTable(quizColor),
          SizedBox(height: config.cardSpacing),
          _buildSelectionDetails(quizColor),
          SizedBox(height: config.cardSpacing),
          _buildAnalysisSection(quizColor),
        ],
      );
    }
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
      actions: const [
        SizedBox(width: 8),  // 右侧间距
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
      case RatingLevel.s:
        return '你对测试中的项目持积极态度。这说明你有较强的好奇心，同时也保持着一定的理性判断。';
      case RatingLevel.n:
        return '你对测试中的许多项目选择跳过。这表明你有明确的底线和原则，知道自己想要什么。';
    }
  }

}
