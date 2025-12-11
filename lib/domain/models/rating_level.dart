enum RatingLevel {
  sss('SR', '特别喜欢', '🖤', 'SR'),
  s('S', '可以', '💚', 'S'),
  n('N', '跳过', '⚪', 'N');

  final String code;
  final String description;
  final String emoji;
  final String label;

  const RatingLevel(this.code, this.description, this.emoji, this.label);

  String toJson() => code;

  static RatingLevel fromJson(String code) {
    return RatingLevel.values.firstWhere(
      (level) => level.code == code,
      orElse: () => RatingLevel.n,
    );
  }
  
  /// 是否应该在报告中显示（只显示SR和S）
  bool get shouldShowInReport => this == RatingLevel.sss || this == RatingLevel.s;
}
