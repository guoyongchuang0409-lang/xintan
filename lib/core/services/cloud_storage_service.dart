import 'dart:convert';
import 'package:dio/dio.dart';
import '../../domain/models/quiz_report.dart';

/// 云端存储服务
/// 支持多种存储方式：Netlify Forms, GitHub Gist, JSON文件
class CloudStorageService {
  static final CloudStorageService instance = CloudStorageService._();
  CloudStorageService._();

  final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  /// 方案1：使用 Netlify Forms 存储
  /// 优点：最简单，你已经在用 Netlify
  /// 缺点：每月限制100次提交（免费版）
  Future<Map<String, dynamic>> saveToNetlifyForms({
    required QuizReport report,
    required String netlifyUrl,
  }) async {
    try {
      // Netlify Forms 需要 form-data 格式
      final formData = FormData.fromMap({
        'form-name': 'quiz-results', // 表单名称
        'shareCode': report.shareCode,
        'quizTypeId': report.quizTypeId,
        'quizTypeName': report.quizTypeName,
        'createdAt': report.createdAt.toIso8601String(),
        'reportData': jsonEncode(report.toJson()),
      });

      final response = await _dio.post(
        netlifyUrl,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
          'shareCode': report.shareCode,
          'shareUrl': '$netlifyUrl/shared/${report.shareCode}',
          'message': '保存成功',
        };
      } else {
        return {
          'success': false,
          'message': '保存失败：${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': '保存失败：$e',
      };
    }
  }

  /// 方案2：使用 GitHub Gist 存储
  /// 优点：免费，可以在 GitHub 查看所有数据
  /// 缺点：需要 GitHub Token
  Future<Map<String, dynamic>> saveToGitHubGist({
    required QuizReport report,
    required String githubToken,
  }) async {
    try {
      final gistData = {
        'description': '${report.quizTypeName} - ${report.shareCode}',
        'public': false, // 私有 Gist
        'files': {
          '${report.shareCode}.json': {
            'content': jsonEncode(report.toJson()),
          }
        }
      };

      final response = await _dio.post(
        'https://api.github.com/gists',
        data: gistData,
        options: Options(
          headers: {
            'Authorization': 'token $githubToken',
            'Accept': 'application/vnd.github.v3+json',
          },
        ),
      );

      if (response.statusCode == 201) {
        final gistId = response.data['id'];
        final gistUrl = response.data['html_url'];
        
        return {
          'success': true,
          'shareCode': report.shareCode,
          'gistId': gistId,
          'gistUrl': gistUrl,
          'shareUrl': 'https://xintan.netlify.app/shared/${report.shareCode}?gist=$gistId',
          'message': '保存成功',
        };
      } else {
        return {
          'success': false,
          'message': '保存失败：${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': '保存失败：$e',
      };
    }
  }

  /// 从 GitHub Gist 读取数据
  Future<Map<String, dynamic>> loadFromGitHubGist({
    required String gistId,
  }) async {
    try {
      final response = await _dio.get(
        'https://api.github.com/gists/$gistId',
        options: Options(
          headers: {
            'Accept': 'application/vnd.github.v3+json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final files = response.data['files'] as Map<String, dynamic>;
        final firstFile = files.values.first;
        final content = firstFile['content'] as String;
        final reportData = jsonDecode(content);
        
        return {
          'success': true,
          'data': reportData,
        };
      } else {
        return {
          'success': false,
          'message': '读取失败：${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': '读取失败：$e',
      };
    }
  }

  /// 方案3：使用简单的 JSON API（需要自己的服务器）
  Future<Map<String, dynamic>> saveToJsonApi({
    required QuizReport report,
    required String apiUrl,
  }) async {
    try {
      final response = await _dio.post(
        '$apiUrl/reports',
        data: report.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'shareCode': report.shareCode,
          'shareUrl': '$apiUrl/shared/${report.shareCode}',
          'message': '保存成功',
        };
      } else {
        return {
          'success': false,
          'message': '保存失败：${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': '保存失败：$e',
      };
    }
  }

  /// 从 JSON API 读取数据
  Future<Map<String, dynamic>> loadFromJsonApi({
    required String shareCode,
    required String apiUrl,
  }) async {
    try {
      final response = await _dio.get('$apiUrl/reports/$shareCode');

      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': response.data,
        };
      } else {
        return {
          'success': false,
          'message': '读取失败：${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': '读取失败：$e',
      };
    }
  }

  /// 方案4：使用 URL 参数传递（无需服务器，适合小数据）
  String generateShareUrl({
    required QuizReport report,
    required String baseUrl,
  }) {
    // 将报告数据压缩并编码
    final jsonStr = jsonEncode(report.toJson());
    final bytes = utf8.encode(jsonStr);
    final base64Str = base64Url.encode(bytes);
    
    return '$baseUrl/shared?data=$base64Str';
  }

  /// 从 URL 参数解析数据
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
