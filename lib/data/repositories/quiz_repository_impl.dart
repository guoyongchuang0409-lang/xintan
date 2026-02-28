import '../../core/constants/quiz_data.dart';
import '../../domain/models/quiz_type.dart';
import '../../domain/models/quiz_category.dart';
import '../../domain/models/quiz_item.dart';
import '../../domain/models/quiz_report.dart';
import '../../domain/repositories/quiz_repository.dart';
import '../datasources/database_interface.dart';
import '../datasources/database_factory.dart';

class QuizRepositoryImpl implements QuizRepository {
  final DatabaseInterface _database;

  QuizRepositoryImpl({DatabaseInterface? database})
      : _database = database ?? DatabaseFactory.instance;

  @override
  Future<List<QuizType>> getQuizTypes() async {
    return QuizData.getAllQuizTypes();
  }

  @override
  Future<List<QuizCategory>> getCategoriesByType(String typeId) async {
    final quizType = QuizData.getQuizTypeById(typeId);
    return quizType?.categories ?? [];
  }

  @override
  Future<List<QuizItem>> getItemsByCategory(String categoryId) async {
    final quizTypes = QuizData.getAllQuizTypes();
    for (final type in quizTypes) {
      for (final category in type.categories) {
        if (category.id == categoryId) {
          return category.items;
        }
      }
    }
    return [];
  }

  @override
  Future<void> saveQuizReport(QuizReport report) async {
    await _database.insertReport(report);
  }

  @override
  Future<List<QuizReport>> getQuizReports() async {
    return await _database.getAllReports();
  }

  @override
  Future<QuizReport?> getReportById(String id) async {
    return await _database.getReportById(id);
  }

  @override
  Future<void> deleteReport(String id) async {
    await _database.deleteReport(id);
  }

  @override
  Future<void> deleteAllReports() async {
    await _database.deleteAllReports();
  }
}
