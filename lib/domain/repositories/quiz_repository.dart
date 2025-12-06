import '../models/quiz_type.dart';
import '../models/quiz_category.dart';
import '../models/quiz_item.dart';
import '../models/quiz_report.dart';
abstract class QuizRepository {
  Future<List<QuizType>> getQuizTypes();
  Future<List<QuizCategory>> getCategoriesByType(String typeId);
  Future<List<QuizItem>> getItemsByCategory(String categoryId);
  Future<void> saveQuizReport(QuizReport report);
  Future<List<QuizReport>> getQuizReports();
  Future<QuizReport?> getReportById(String id);
  Future<void> deleteReport(String id);
  Future<void> deleteAllReports();
}
