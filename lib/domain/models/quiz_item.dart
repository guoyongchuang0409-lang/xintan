class QuizItem {
  final String id;
  final String name;
  final String categoryId;
  final String? description; // 任务详细描述

  const QuizItem({
    required this.id,
    required this.name,
    required this.categoryId,
    this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'categoryId': categoryId,
      'description': description,
    };
  }

  factory QuizItem.fromJson(Map<String, dynamic> json) {
    return QuizItem(
      id: json['id'] as String,
      name: json['name'] as String,
      categoryId: json['categoryId'] as String,
      description: json['description'] as String?,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuizItem &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          categoryId == other.categoryId &&
          description == other.description;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ categoryId.hashCode ^ description.hashCode;
}
