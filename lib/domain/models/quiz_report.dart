import 'rating_level.dart';
import 'quiz_item.dart';
class SelectionDetail {
  final QuizItem item;
  final RatingLevel rating;

  const SelectionDetail({
    required this.item,
    required this.rating,
  });

  Map<String, dynamic> toJson() {
    return {
      'item': item.toJson(),
      'rating': rating.toJson(),
    };
  }

  factory SelectionDetail.fromJson(Map<String, dynamic> json) {
    return SelectionDetail(
      item: QuizItem.fromJson(json['item'] as Map<String, dynamic>),
      rating: RatingLevel.fromJson(json['rating'] as String),
    );
  }
}
class CategoryStats {
  final String categoryName;
  final Map<RatingLevel, int> levelCounts;
  final Map<RatingLevel, double> levelPercentages;
  final List<SelectionDetail> selections; // 新增：该分类下的所有选择详情

  const CategoryStats({
    required this.categoryName,
    required this.levelCounts,
    required this.levelPercentages,
    this.selections = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'categoryName': categoryName,
      'levelCounts': levelCounts.map(
        (key, value) => MapEntry(key.toJson(), value),
      ),
      'levelPercentages': levelPercentages.map(
        (key, value) => MapEntry(key.toJson(), value),
      ),
      'selections': selections.map((s) => s.toJson()).toList(),
    };
  }

  factory CategoryStats.fromJson(Map<String, dynamic> json) {
    return CategoryStats(
      categoryName: json['categoryName'] as String,
      levelCounts: (json['levelCounts'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(RatingLevel.fromJson(key), value as int),
      ),
      levelPercentages: (json['levelPercentages'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(RatingLevel.fromJson(key), (value as num).toDouble()),
      ),
      selections: json['selections'] != null
          ? (json['selections'] as List<dynamic>)
              .map((s) => SelectionDetail.fromJson(s as Map<String, dynamic>))
              .toList()
          : [],
    );
  }
}
class QuizReport {
  final String id;
  final String quizTypeId;
  final String quizTypeName;
  final DateTime createdAt;
  final Map<String, RatingLevel> ratings;
  final Map<String, CategoryStats> categoryStats;
  final String? shareCode; // 新增：分享码
  final DateTime? lastViewedAt; // 新增：最后查看时

  const QuizReport({
    required this.id,
    required this.quizTypeId,
    required this.quizTypeName,
    required this.createdAt,
    required this.ratings,
    required this.categoryStats,
    this.shareCode,
    this.lastViewedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quizTypeId': quizTypeId,
      'quizTypeName': quizTypeName,
      'createdAt': createdAt.toIso8601String(),
      'ratings': ratings.map(
        (key, value) => MapEntry(key, value.toJson()),
      ),
      'categoryStats': categoryStats.map(
        (key, value) => MapEntry(key, value.toJson()),
      ),
      'shareCode': shareCode,
      'lastViewedAt': lastViewedAt?.toIso8601String(),
    };
  }

  factory QuizReport.fromJson(Map<String, dynamic> json) {
    return QuizReport(
      id: json['id'] as String,
      quizTypeId: json['quizTypeId'] as String,
      quizTypeName: json['quizTypeName'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      ratings: (json['ratings'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(key, RatingLevel.fromJson(value as String)),
      ),
      categoryStats: (json['categoryStats'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(
          key,
          CategoryStats.fromJson(value as Map<String, dynamic>),
        ),
      ),
      shareCode: json['shareCode'] as String?,
      lastViewedAt: json['lastViewedAt'] != null 
          ? DateTime.parse(json['lastViewedAt'] as String) 
          : null,
    );
  }
  static String generateShareCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = DateTime.now().millisecondsSinceEpoch;
    String code = '';
    for (int i = 0; i < 6; i++) {
      code += chars[(random + i * 7) % chars.length];
    }
    return code;
  }
  QuizReport copyWithShareCode() {
    return QuizReport(
      id: id,
      quizTypeId: quizTypeId,
      quizTypeName: quizTypeName,
      createdAt: createdAt,
      ratings: ratings,
      categoryStats: categoryStats,
      shareCode: shareCode ?? generateShareCode(),
      lastViewedAt: DateTime.now(),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuizReport &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
