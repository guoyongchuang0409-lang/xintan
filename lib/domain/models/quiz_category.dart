import 'quiz_item.dart';
class QuizCategory {
  final String id;
  final String name;
  final String quizTypeId;
  final List<QuizItem> items;

  const QuizCategory({
    required this.id,
    required this.name,
    required this.quizTypeId,
    this.items = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'quizTypeId': quizTypeId,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  factory QuizCategory.fromJson(Map<String, dynamic> json) {
    return QuizCategory(
      id: json['id'] as String,
      name: json['name'] as String,
      quizTypeId: json['quizTypeId'] as String,
      items: (json['items'] as List<dynamic>?)
              ?.map((item) => QuizItem.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuizCategory &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          quizTypeId == other.quizTypeId;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ quizTypeId.hashCode;
}
