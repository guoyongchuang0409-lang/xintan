import 'package:flutter/foundation.dart';
import '../../domain/models/quiz_type.dart';
import '../../domain/models/rating_level.dart';
import '../../domain/models/quiz_report.dart';
class QuizProvider extends ChangeNotifier {
  QuizType? _currentQuizType;
  final Map<String, RatingLevel> _ratings = {};
  int _currentCategoryIndex = 0;

  QuizType? get currentQuizType => _currentQuizType;
  Map<String, RatingLevel> get ratings => Map.unmodifiable(_ratings);
  int get currentCategoryIndex => _currentCategoryIndex;

  void selectQuizType(QuizType type) {
    _currentQuizType = type;
    _ratings.clear();
    _currentCategoryIndex = 0;
    notifyListeners();
  }

  void setRating(String itemId, RatingLevel level) {
    _ratings[itemId] = level;
    notifyListeners();
  }

  void nextCategory() {
    if (_currentQuizType != null &&
        _currentCategoryIndex < _currentQuizType!.categories.length - 1) {
      _currentCategoryIndex++;
      notifyListeners();
    }
  }

  void previousCategory() {
    if (_currentCategoryIndex > 0) {
      _currentCategoryIndex--;
      notifyListeners();
    }
  }

  QuizReport? generateReport() {
    // TODO: 实现报告生成逻辑
    return null;
  }

  void reset() {
    _currentQuizType = null;
    _ratings.clear();
    _currentCategoryIndex = 0;
    notifyListeners();
  }
}
