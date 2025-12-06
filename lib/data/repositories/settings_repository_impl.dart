import '../../domain/models/app_settings.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/preferences_datasource.dart';
class SettingsRepositoryImpl implements SettingsRepository {
  final PreferencesDatasource _datasource;

  SettingsRepositoryImpl({PreferencesDatasource? datasource})
      : _datasource = datasource ?? PreferencesDatasource.instance;
  @override
  Future<AppSettings> getSettings() async {
    return await _datasource.getSettings();
  }
  @override
  Future<void> saveSettings(AppSettings settings) async {
    await _datasource.saveSettings(settings);
  }
  @override
  Future<bool> getAutoSaveScreenshot() async {
    return await _datasource.getAutoSaveScreenshot();
  }
  @override
  Future<void> setAutoSaveScreenshot(bool value) async {
    await _datasource.setAutoSaveScreenshot(value);
  }
}
