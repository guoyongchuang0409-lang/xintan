import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../domain/models/quiz_report.dart';

/// Netlify Forms 服务
/// 用于将测试结果提交到 Netlify Forms，可以在 Netlify 后台查看所有数据
class NetlifyFormsService {
  static final NetlifyFormsService instance = NetlifyFormsService._();
  NetlifyFormsService._();

  final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
  ));

  /// 提交测试结果到 Netlify Forms
  /// 
  /// [report] 测试报告
  /// [netlifyUrl] 你的 Netlify 网站地址，例如：https://xintan.netlify.app
  /// 
  /// 返回：
  /// - success: 是否成功
  /// - shareCode: 分享码
  /// - shareUrl: 分享链接
  /// - message: 提示信息
  Future<Map<String, dynamic>> submitReport({
    required QuizReport report,
    String netlifyUrl = 'https://xintan.netlify.app',
  }) async {
    debugPrint('');
    debugPrint('═══════════════════════════════════════');
    debugPrint('📤 [Netlify Forms] 开始提交数据');
    debugPrint('═══════════════════════════════════════');
    
    try {
      // 准备表单数据
      final shareCode = report.shareCode ?? QuizReport.generateShareCode();
      final formData = {
        'form-name': 'quiz-results',
        'shareCode': shareCode,
        'quizTypeId': report.quizTypeId,
        'quizTypeName': report.quizTypeName,
        'createdAt': report.createdAt.toIso8601String(),
        'reportData': jsonEncode(report.toJson()),
      };

      debugPrint('📋 [Netlify Forms] 表单数据:');
      debugPrint('   - form-name: quiz-results');
      debugPrint('   - shareCode: $shareCode');
      debugPrint('   - quizTypeId: ${report.quizTypeId}');
      debugPrint('   - quizTypeName: ${report.quizTypeName}');
      debugPrint('   - createdAt: ${report.createdAt.toIso8601String()}');
      debugPrint('   - reportData 大小: ${jsonEncode(report.toJson()).length} 字符');
      debugPrint('');
      debugPrint('🌐 [Netlify Forms] 目标地址: $netlifyUrl');
      debugPrint('⏳ [Netlify Forms] 正在发送请求...');

      final startTime = DateTime.now();
      
      // 提交到 Netlify
      final response = await _dio.post(
        netlifyUrl,
        data: formData,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          followRedirects: false,
          validateStatus: (status) {
            // Netlify Forms 成功后会返回 302 重定向
            return status != null && (status == 200 || status == 302);
          },
        ),
      );

      final duration = DateTime.now().difference(startTime);
      
      debugPrint('');
      debugPrint('📨 [Netlify Forms] 响应信息:');
      debugPrint('   - 状态码: ${response.statusCode}');
      debugPrint('   - 耗时: ${duration.inMilliseconds}ms');
      debugPrint('   - Headers: ${response.headers}');

      if (response.statusCode == 200 || response.statusCode == 302) {
        debugPrint('');
        debugPrint('✅ [Netlify Forms] 提交成功！');
        debugPrint('═══════════════════════════════════════');
        debugPrint('');
        
        return {
          'success': true,
          'shareCode': shareCode,
          'shareUrl': '$netlifyUrl/shared/$shareCode',
          'message': '保存成功！可以在 Netlify 后台查看数据',
        };
      } else {
        debugPrint('');
        debugPrint('⚠️  [Netlify Forms] 提交失败');
        debugPrint('═══════════════════════════════════════');
        debugPrint('');
        
        return {
          'success': false,
          'message': '保存失败：HTTP ${response.statusCode}',
        };
      }
    } on DioException catch (e) {
      debugPrint('');
      debugPrint('❌ [Netlify Forms] Dio 异常:');
      debugPrint('   - 类型: ${e.type}');
      debugPrint('   - 消息: ${e.message}');
      debugPrint('   - 响应: ${e.response?.statusCode}');
      
      // 处理 Dio 异常
      if (e.response?.statusCode == 302) {
        // 302 重定向也算成功
        final shareCode = report.shareCode ?? QuizReport.generateShareCode();
        debugPrint('');
        debugPrint('✅ [Netlify Forms] 302 重定向，视为成功');
        debugPrint('═══════════════════════════════════════');
        debugPrint('');
        
        return {
          'success': true,
          'shareCode': shareCode,
          'shareUrl': '$netlifyUrl/shared/$shareCode',
          'message': '保存成功！',
        };
      }
      
      debugPrint('═══════════════════════════════════════');
      debugPrint('');
      
      return {
        'success': false,
        'message': '网络错误：${e.message}',
      };
    } catch (e, stackTrace) {
      debugPrint('');
      debugPrint('❌ [Netlify Forms] 未知异常:');
      debugPrint('   - 错误: $e');
      debugPrint('   - 堆栈: $stackTrace');
      debugPrint('═══════════════════════════════════════');
      debugPrint('');
      
      return {
        'success': false,
        'message': '保存失败：$e',
      };
    }
  }

  /// 生成分享链接（使用 URL 参数，不依赖服务器）
  /// 这是备用方案，当 Netlify Forms 不可用时使用
  String generateShareUrl({
    required QuizReport report,
    String baseUrl = 'https://xintan.netlify.app',
  }) {
    try {
      // 将报告数据编码到 URL 中
      final jsonStr = jsonEncode(report.toJson());
      final bytes = utf8.encode(jsonStr);
      final base64Str = base64Url.encode(bytes);
      
      return '$baseUrl/shared?data=$base64Str';
    } catch (e) {
      return '$baseUrl/shared/${report.shareCode}';
    }
  }

  /// 从 URL 参数解析报告数据
  QuizReport? parseFromUrl(String dataParam) {
    try {
      final bytes = base64Url.decode(dataParam);
      final jsonStr = utf8.decode(bytes);
      final data = jsonDecode(jsonStr);
      return QuizReport.fromJson(data);
    } catch (e) {
      return null;
    }
  }
}
