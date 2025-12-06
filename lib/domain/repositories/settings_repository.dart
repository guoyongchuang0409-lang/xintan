import '../models/app_settings.dart';
abstract class SettingsRepository {
  Future<AppSettings> getSettings();
  Future<void> saveSettings(AppSettings settings);
  Future<bool> getAutoSaveScreenshot();
  Future<void> setAutoSaveScreenshot(bool value);
}
