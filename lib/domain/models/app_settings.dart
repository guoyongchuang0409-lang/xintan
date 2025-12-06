class AppSettings {
  final bool autoSaveScreenshot;

  const AppSettings({
    this.autoSaveScreenshot = true,
  });

  Map<String, dynamic> toJson() {
    return {
      'autoSaveScreenshot': autoSaveScreenshot,
    };
  }

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      autoSaveScreenshot: json['autoSaveScreenshot'] as bool? ?? true,
    );
  }

  AppSettings copyWith({
    bool? autoSaveScreenshot,
  }) {
    return AppSettings(
      autoSaveScreenshot: autoSaveScreenshot ?? this.autoSaveScreenshot,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppSettings &&
          runtimeType == other.runtimeType &&
          autoSaveScreenshot == other.autoSaveScreenshot;

  @override
  int get hashCode => autoSaveScreenshot.hashCode;
}
