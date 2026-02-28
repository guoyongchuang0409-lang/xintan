import '../../domain/models/quiz_report.dart';

/// 数据库接口
/// 提供统一的数据存储接口，支持不同平台的实现
abstract class DatabaseInterface {
  Future<void> insertReport(QuizReport report);
  Future<List<QuizReport>> getAllReports();
  Future<QuizReport?> getReportById(String id);
  Future<void> deleteReport(String id);
  Future<void> deleteAllReports();
  Future<void> close();
}
