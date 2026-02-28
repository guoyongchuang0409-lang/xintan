import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/models/quiz_report.dart';
import 'database_interface.dart';

/// Web 平台数据库实现
/// 使用 SharedPreferences 存储数据
class WebDatabase implements DatabaseInterface {
  static const String _reportsKey = 'quiz_reports';
  
  static WebDatabase? _instance;
  SharedPreferences? _prefs;

  WebDatabase._();

  static WebDatabase get instance {
    _instance ??= WebDatabase._();
    return _instance!;
  }

  Future<SharedPreferences> get _preferences async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  @override
  Future<void> insertReport(QuizReport report) async {
    final prefs = await _preferences;
    final reports = await getAllReports();
    
    // 移除旧的同 ID 报告
    reports.removeWhere((r) => r.id == report.id);
    
    // 添加新报告
    reports.add(report);
    
    // 保存到 SharedPreferences
    final jsonList = reports.map((r) => r.toJson()).toList();
    await prefs.setString(_reportsKey, jsonEncode(jsonList));
  }

  @override
  Future<List<QuizReport>> getAllReports() async {
    final prefs = await _preferences;
    final jsonString = prefs.getString(_reportsKey);
    
    if (jsonString == null || jsonString.isEmpty) {
      return [];
    }
    
    try {
      final jsonList = jsonDecode(jsonString) as List;
      final reports = jsonList
          .map((json) => QuizReport.fromJson(json as Map<String, dynamic>))
          .toList();
      
      // 按创建时间降序排序
      reports.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      
      return reports;
    } catch (e) {
      print('Error loading reports: $e');
      return [];
    }
  }

  @override
  Future<QuizReport?> getReportById(String id) async {
    final reports = await getAllReports();
    try {
      return reports.firstWhere((r) => r.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> deleteReport(String id) async {
    final prefs = await _preferences;
    final reports = await getAllReports();
    
    reports.removeWhere((r) => r.id == id);
    
    final jsonList = reports.map((r) => r.toJson()).toList();
    await prefs.setString(_reportsKey, jsonEncode(jsonList));
  }

  @override
  Future<void> deleteAllReports() async {
    final prefs = await _preferences;
    await prefs.remove(_reportsKey);
  }

  @override
  Future<void> close() async {
    // SharedPreferences 不需要关闭
  }
}
