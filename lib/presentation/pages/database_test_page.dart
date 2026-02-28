import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_colors.dart';
import '../../core/services/database_service.dart';
import '../../core/utils/toast_utils.dart';
import '../widgets/custom_dialog.dart';

/// 数据库测试页面 - 用于测试数据库功能
class DatabaseTestPage extends StatefulWidget {
  const DatabaseTestPage({super.key});

  @override
  State<DatabaseTestPage> createState() => _DatabaseTestPageState();
}

class _DatabaseTestPageState extends State<DatabaseTestPage> {
  final _shareCodeController = TextEditingController();
  String _testResult = '';

  @override
  void dispose() {
    _shareCodeController.dispose();
    super.dispose();
  }

  Future<void> _testConnection() async {
    setState(() {
      _testResult = '正在测试连接...';
    });

    try {
      final result = await DatabaseService.instance.getStats();
      
      if (result['success']) {
        setState(() {
          _testResult = '✅ 连接成功！\n\n统计数据：\n${_formatJson(result['data'])}';
        });
        ToastUtils.showSuccess(context, '连接成功');
      } else {
        setState(() {
          _testResult = '❌ 连接失败：${result['message']}';
        });
        ToastUtils.showError(context, result['message']);
      }
    } catch (e) {
      setState(() {
        _testResult = '❌ 连接异常：$e';
      });
      ToastUtils.showError(context, '连接异常');
    }
  }

  Future<void> _testDownload() async {
    final shareCode = _shareCodeController.text.trim();
    
    if (shareCode.isEmpty) {
      ToastUtils.showError(context, '请输入分享码');
      return;
    }

    setState(() {
      _testResult = '正在下载报告...';
    });

    CustomDialog.showLoading(context, message: '下载中...');

    try {
      final result = await DatabaseService.instance.downloadReport(
        shareCode: shareCode,
      );
      
      CustomDialog.dismissLoading();

      if (result['success']) {
        final report = result['data'];
        setState(() {
          _testResult = '✅ 下载成功！\n\n报告信息：\n'
              '测试类型：${report.quizTypeName}\n'
              '分享码：${report.shareCode}\n'
              '创建时间：${report.createdAt}\n'
              '评分数量：${report.ratings.length}';
        });
        ToastUtils.showSuccess(context, '下载成功');
      } else {
        setState(() {
          _testResult = '❌ 下载失败：${result['message']}';
        });
        ToastUtils.showError(context, result['message']);
      }
    } catch (e) {
      CustomDialog.dismissLoading();
      setState(() {
        _testResult = '❌ 下载异常：$e';
      });
      ToastUtils.showError(context, '下载异常');
    }
  }

  Future<void> _testList() async {
    setState(() {
      _testResult = '正在获取列表...';
    });

    try {
      final result = await DatabaseService.instance.getReportList(
        page: 1,
        limit: 10,
      );
      
      if (result['success']) {
        final reports = result['data'] as List;
        final pagination = result['pagination'];
        
        setState(() {
          _testResult = '✅ 获取成功！\n\n'
              '总数：${pagination['total']}\n'
              '当前页：${pagination['page']}/${pagination['pages']}\n\n'
              '报告列表：\n${_formatReportList(reports)}';
        });
        ToastUtils.showSuccess(context, '获取成功');
      } else {
        setState(() {
          _testResult = '❌ 获取失败：${result['message']}';
        });
        ToastUtils.showError(context, result['message']);
      }
    } catch (e) {
      setState(() {
        _testResult = '❌ 获取异常：$e';
      });
      ToastUtils.showError(context, '获取异常');
    }
  }

  String _formatJson(dynamic data) {
    if (data is Map) {
      return data.entries
          .map((e) => '${e.key}: ${e.value}')
          .join('\n');
    }
    return data.toString();
  }

  String _formatReportList(List reports) {
    if (reports.isEmpty) {
      return '暂无数据';
    }
    
    return reports.take(5).map((report) {
      return '- ${report['share_code']} | ${report['quiz_type_name']}';
    }).join('\n');
  }

  @override
  Widget build(BuildContext context) {
    final isConfigured = DatabaseService.instance.isConfigured;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: const Text('数据库测试'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 配置状态
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isConfigured
                    ? AppColors.neonGreen.withOpacity(0.1)
                    : AppColors.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isConfigured
                      ? AppColors.neonGreen.withOpacity(0.5)
                      : AppColors.error.withOpacity(0.5),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    isConfigured ? Icons.check_circle : Icons.error,
                    color: isConfigured ? AppColors.neonGreen : AppColors.error,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      isConfigured
                          ? 'API 已配置'
                          : 'API 未配置\n请在 database_service.dart 中配置 API 地址',
                      style: TextStyle(
                        color: isConfigured
                            ? AppColors.neonGreen
                            : AppColors.error,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 测试按钮
            Text(
              '测试功能',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            ElevatedButton.icon(
              onPressed: isConfigured ? _testConnection : null,
              icon: const Icon(Icons.wifi),
              label: const Text('测试连接'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.neonCyan,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16),
              ),
            ),

            const SizedBox(height: 12),

            ElevatedButton.icon(
              onPressed: isConfigured ? _testList : null,
              icon: const Icon(Icons.list),
              label: const Text('获取报告列表'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.neonPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16),
              ),
            ),

            const SizedBox(height: 24),

            // 下载测试
            Text(
              '下载报告测试',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _shareCodeController,
              decoration: InputDecoration(
                labelText: '分享码',
                hintText: '输入分享码（例如：ABC123）',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: AppColors.surface,
              ),
              style: TextStyle(color: AppColors.textPrimary),
            ),

            const SizedBox(height: 12),

            ElevatedButton.icon(
              onPressed: isConfigured ? _testDownload : null,
              icon: const Icon(Icons.download),
              label: const Text('下载报告'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.neonGreen,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16),
              ),
            ),

            const SizedBox(height: 24),

            // 测试结果
            Text(
              '测试结果',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.neonCyan.withOpacity(0.3),
                ),
              ),
              constraints: const BoxConstraints(minHeight: 200),
              child: SingleChildScrollView(
                child: Text(
                  _testResult.isEmpty ? '等待测试...' : _testResult,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 12,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            if (_testResult.isNotEmpty)
              ElevatedButton.icon(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: _testResult));
                  ToastUtils.showSuccess(context, '已复制到剪贴板');
                },
                icon: const Icon(Icons.copy),
                label: const Text('复制结果'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.surfaceLight,
                  foregroundColor: AppColors.textPrimary,
                  padding: const EdgeInsets.all(12),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
