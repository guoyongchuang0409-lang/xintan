import 'quiz_category.dart';
class QuizType {
  final String id;
  final String name;
  final String description;
  final String iconPath;
  final List<QuizCategory> categories;

  const QuizType({
    required this.id,
    required this.name,
    required this.description,
    required this.iconPath,
    required this.categories,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'iconPath': iconPath,
      'categories': categories.map((cat) => cat.toJson()).toList(),
    };
  }

  factory QuizType.fromJson(Map<String, dynamic> json) {
    return QuizType(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      iconPath: json['iconPath'] as String,
      categories: (json['categories'] as List<dynamic>?)
              ?.map((cat) => QuizCategory.fromJson(cat as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuizType &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
