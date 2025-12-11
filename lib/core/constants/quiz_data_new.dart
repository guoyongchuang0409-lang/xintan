import '../../domain/models/quiz_type.dart';
import 'female_desire_quiz_data.dart';
import 'female_m_quiz_data.dart';
import 'male_m_quiz_data.dart';
import 'cuckold_quiz_data.dart';
import 'male_s_quiz_data.dart';
import 'female_s_quiz_data.dart';

class QuizData {
  QuizData._();

  // 静态属性，直接访问各模块的quizType
  static QuizType get femaleMQuizType => FemaleMQuizData.quizType;
  static QuizType get maleMQuizType => MaleMQuizData.quizType;
  static QuizType get cuckoldQuizType => CuckoldQuizData.quizType;
  static QuizType get femaleDesireQuizType => FemaleDesireQuizData.quizType;
  static QuizType get femaleSQuizType => FemaleSQuizData.quizType;
  static QuizType get maleSQuizType => MaleSQuizData.quizType;

  static List<QuizType> getAllQuizTypes() {
    return [
      FemaleDesireQuizData.quizType,
      FemaleSQuizData.quizType,
      MaleSQuizData.quizType,
      FemaleMQuizData.quizType,
      MaleMQuizData.quizType,
      CuckoldQuizData.quizType,
    ];
  }

  static QuizType? getQuizTypeById(String id) {
    try {
      return getAllQuizTypes().firstWhere((type) => type.id == id);
    } catch (_) {
      return null;
    }
  }
}
