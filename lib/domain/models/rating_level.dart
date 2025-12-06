enum RatingLevel {
  sss('SSS', '非常喜欢', '🖤', 'SSS'),
  ss('SS', '喜欢', '💜', 'SS'),
  s('S', '无所谓', '💚', 'S'),
  q('Q', '不喜欢但会做', '💙', 'Q'),
  n('N', '绝不', '❤️', 'N'),
  w('W', '未知', '⚪', 'W');

  final String code;
  final String description;
  final String emoji;
  final String label;

  const RatingLevel(this.code, this.description, this.emoji, this.label);

  String toJson() => code;

  static RatingLevel fromJson(String code) {
    return RatingLevel.values.firstWhere(
      (level) => level.code == code,
      orElse: () => RatingLevel.w,
    );
  }
}
