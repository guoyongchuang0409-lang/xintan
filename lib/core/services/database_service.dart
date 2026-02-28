import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../domain/models/quiz_report.dart';

/// 数据库服务 - 连接 Vercel 后端
/// 提供上传、下载、查询功能
class DatabaseService {
  static final DatabaseService instance = DatabaseService._();
  DatabaseService._();

  // TODO: 部署到 Vercel 后，将此地址替换为你的 Vercel API 地址
  // 例如：https://quiz-api-xxx.vercel.app
  static const String _apiBaseUrl = 'YOUR_VERCEL_API_URL';
  
  final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
  ));

  /// 检查 API 是否已配置
  bool get isConfigured => _apiBaseUrl != 'YOUR_VERCEL_API_URL';

  /// 上传测试报告到数据库
  /// 
  /// [report] 测试报告
  /// 
  /// 返回：
  /// - success: 是否成功
  /// - shareCode: 分享码
  /// - message: 提示信息
  Future<Map<String, dynamic>> uploadReport({
    required QuizReport report,
  }) async {
    if (!isConfigured) {
      return {
        'success': false,
        'message': 'API 地址未配置，请先部署后端到 Vercel',
      };
    }

    debugPrint('');
    debugPrint('═══════════════════════════════════════');
    debugPrint('📤 [数据库] 开始上传报告');
    debugPrint('═══════════════════════════════════════');
    
    try {
      final shareCode = report.shareCode ?? QuizReport.generateShareCode();
      
      final requestData = {
        'shareCode': shareCode,
        'quizTypeId': report.quizTypeId,
        'quizTypeName': report.quizTypeName,
        'reportData': report.toJson(),
      };

      debugPrint('📋 [数据库] 请求数据:');
      debugPrint('   - shareCode: $shareCode');
      debugPrint('   - quizTypeId: ${report.quizTypeId}');
      debugPrint('   - quizTypeName: ${report.quizTypeName}');
      debugPrint('');
      debugPrint('🌐 [数据库] 目标地址: $_apiBaseUrl/api/reports');
      debugPrint('⏳ [数据库] 正在发送请求...');

      final startTime = DateTime.now();
      
      final response = await _dio.post(
        '$_apiBaseUrl/api/reports',
        data: requestData,
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );

      final duration = DateTime.now().difference(startTime);
      
      debugPrint('');
      debugPrint('📨 [数据库] 响应信息:');
      debugPrint('   - 状态码: ${response.statusCode}');
      debugPrint('   - 耗时: ${duration.inMilliseconds}ms');

      if (response.statusCode == 200) {
        debugPrint('');
        debugPrint('✅ [数据库] 上传成功！');
        debugPrint('═══════════════════════════════════════');
        debugPrint('');
        
        return {
          'success': true,
          'shareCode': shareCode,
          'message': '上传成功',
        };
      } else {
        debugPrint('');
        debugPrint('⚠️  [数据库] 上传失败');
        debugPrint('═══════════════════════════════════════');
        debugPrint('');
        
        return {
          'success': false,
          'message': '上传失败：HTTP ${response.statusCode}',
        };
      }
    } on DioException catch (e) {
      debugPrint('');
      debugPrint('❌ [数据库] Dio 异常:');
      debugPrint('   - 类型: ${e.type}');
      debugPrint('   - 消息: ${e.message}');
      debugPrint('   - 响应: ${e.response?.statusCode}');
      debugPrint('═══════════════════════════════════════');
      debugPrint('');
      
      return {
        'success': false,
        'message': '网络错误：${e.message}',
      };
    } catch (e, stackTrace) {
      debugPrint('');
      debugPrint('❌ [数据库] 未知异常:');
      debugPrint('   - 错误: $e');
      debugPrint('   - 堆栈: $stackTrace');
      debugPrint('═══════════════════════════════════════');
      debugPrint('');
      
      return {
        'success': false,
        'message': '上传失败：$e',
      };
    }
  }

  /// 通过分享码下载报告
  /// 
  /// [shareCode] 分享码
  /// 
  /// 返回：
  /// - success: 是否成功
  /// - data: 报告数据（QuizReport 对象）
  /// - message: 提示信息
  Future<Map<String, dynamic>> downloadReport({
    required String shareCode,
  }) async {
    if (!isConfigured) {
      return {
        'success': false,
        'message': 'API 地址未配置',
      };
    }

    debugPrint('');
    debugPrint('═══════════════════════════════════════');
    debugPrint('📥 [数据库] 开始下载报告');
    debugPrint('   - 分享码: $shareCode');
    debugPrint('═══════════════════════════════════════');
    
    try {
      final response = await _dio.get(
        '$_apiBaseUrl/api/reports',
        queryParameters: {'shareCode': shareCode},
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final reportData = response.data['data'];
        final report = QuizReport.fromJson(reportData);
        
        debugPrint('');
        debugPrint('✅ [数据库] 下载成功！');
        debugPrint('   - 测试类型: ${report.quizTypeName}');
        debugPrint('   - 创建时间: ${report.createdAt}');
        debugPrint('═══════════════════════════════════════');
        debugPrint('');
        
        return {
          'success': true,
          'data': report,
          'message': '下载成功',
        };
      } else {
        debugPrint('');
        debugPrint('⚠️  [数据库] 下载失败');
        debugPrint('═══════════════════════════════════════');
        debugPrint('');
        
        return {
          'success': false,
          'message': response.data['error'] ?? '报告不存在',
        };
      }
    } on DioException catch (e) {
      debugPrint('');
      debugPrint('❌ [数据库] 下载异常: ${e.message}');
      debugPrint('═══════════════════════════════════════');
      debugPrint('');
      
      if (e.response?.statusCode == 404) {
        return {
          'success': false,
          'message': '报告不存在',
        };
      }
      
      return {
        'success': false,
        'message': '网络错误：${e.message}',
      };
    } catch (e) {
      debugPrint('');
      debugPrint('❌ [数据库] 未知异常: $e');
      debugPrint('═══════════════════════════════════════');
      debugPrint('');
      
      return {
        'success': false,
        'message': '下载失败：$e',
      };
    }
  }

  /// 获取报告列表（管理员功能）
  /// 
  /// [page] 页码（从 1 开始）
  /// [limit] 每页数量
  /// [quizType] 测试类型筛选（可选）
  /// 
  /// 返回：
  /// - success: 是否成功
  /// - data: 报告列表
  /// - pagination: 分页信息
  /// - message: 提示信息
  Future<Map<String, dynamic>> getReportList({
    int page = 1,
    int limit = 20,
    String? quizType,
  }) async {
    if (!isConfigured) {
      return {
        'success': false,
        'message': 'API 地址未配置',
      };
    }

    debugPrint('');
    debugPrint('═══════════════════════════════════════');
    debugPrint('📋 [数据库] 获取报告列表');
    debugPrint('   - 页码: $page');
    debugPrint('   - 每页: $limit');
    if (quizType != null) {
      debugPrint('   - 筛选: $quizType');
    }
    debugPrint('═══════════════════════════════════════');
    
    try {
      final queryParams = {
        'page': page.toString(),
        'limit': limit.toString(),
      };
      
      if (quizType != null) {
        queryParams['quizType'] = quizType;
      }

      final response = await _dio.get(
        '$_apiBaseUrl/api/reports',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        debugPrint('');
        debugPrint('✅ [数据库] 获取成功！');
        debugPrint('   - 总数: ${response.data['pagination']['total']}');
        debugPrint('   - 当前页: ${response.data['data'].length} 条');
        debugPrint('═══════════════════════════════════════');
        debugPrint('');
        
        return {
          'success': true,
          'data': response.data['data'],
          'pagination': response.data['pagination'],
          'message': '获取成功',
        };
      } else {
        return {
          'success': false,
          'message': '获取失败',
        };
      }
    } catch (e) {
      debugPrint('');
      debugPrint('❌ [数据库] 获取异常: $e');
      debugPrint('═══════════════════════════════════════');
      debugPrint('');
      
      return {
        'success': false,
        'message': '获取失败：$e',
      };
    }
  }

  /// 获取统计数据（管理员功能）
  /// 
  /// 返回：
  /// - success: 是否成功
  /// - data: 统计数据
  ///   - totalReports: 总报告数
  ///   - todayReports: 今日新增
  ///   - weekReports: 本周新增
  ///   - totalViews: 总浏览次数
  ///   - byType: 按类型统计
  Future<Map<String, dynamic>> getStats() async {
    if (!isConfigured) {
      return {
        'success': false,
        'message': 'API 地址未配置',
      };
    }

    debugPrint('');
    debugPrint('═══════════════════════════════════════');
    debugPrint('📊 [数据库] 获取统计数据');
    debugPrint('═══════════════════════════════════════');
    
    try {
      final response = await _dio.get('$_apiBaseUrl/api/stats');

      if (response.statusCode == 200 && response.data['success'] == true) {
        debugPrint('');
        debugPrint('✅ [数据库] 获取成功！');
        debugPrint('   - 总报告: ${response.data['data']['totalReports']}');
        debugPrint('   - 今日新增: ${response.data['data']['todayReports']}');
        debugPrint('   - 本周新增: ${response.data['data']['weekReports']}');
        debugPrint('═══════════════════════════════════════');
        debugPrint('');
        
        return {
          'success': true,
          'data': response.data['data'],
          'message': '获取成功',
        };
      } else {
        return {
          'success': false,
          'message': '获取失败',
        };
      }
    } catch (e) {
      debugPrint('');
      debugPrint('❌ [数据库] 获取异常: $e');
      debugPrint('═══════════════════════════════════════');
      debugPrint('');
      
      return {
        'success': false,
        'message': '获取失败：$e',
      };
    }
  }

  /// 删除报告（管理员功能）
  /// 
  /// [shareCode] 分享码
  Future<Map<String, dynamic>> deleteReport({
    required String shareCode,
  }) async {
    if (!isConfigured) {
      return {
        'success': false,
        'message': 'API 地址未配置',
      };
    }

    debugPrint('');
    debugPrint('═══════════════════════════════════════');
    debugPrint('🗑️  [数据库] 删除报告');
    debugPrint('   - 分享码: $shareCode');
    debugPrint('═══════════════════════════════════════');
    
    try {
      final response = await _dio.delete(
        '$_apiBaseUrl/api/reports',
        queryParameters: {'shareCode': shareCode},
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        debugPrint('');
        debugPrint('✅ [数据库] 删除成功！');
        debugPrint('═══════════════════════════════════════');
        debugPrint('');
        
        return {
          'success': true,
          'message': '删除成功',
        };
      } else {
        return {
          'success': false,
          'message': response.data['error'] ?? '删除失败',
        };
      }
    } catch (e) {
      debugPrint('');
      debugPrint('❌ [数据库] 删除异常: $e');
      debugPrint('═══════════════════════════════════════');
      debugPrint('');
      
      return {
        'success': false,
        'message': '删除失败：$e',
      };
    }
  }
}
