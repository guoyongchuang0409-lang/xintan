import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/models/app_settings.dart';
class PreferencesDatasource {
  static const String _settingsKey = 'app_settings';
  static const String _autoSaveScreenshotKey = 'auto_save_screenshot';

  static PreferencesDatasource? _instance;
  SharedPreferences? _prefs;

  PreferencesDatasource._();

  static PreferencesDatasource get instance {
    _instance ??= PreferencesDatasource._();
    return _instance!;
  }

  Future<SharedPreferences> get _preferences async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }
  Future<AppSettings> getSettings() async {
    final prefs = await _preferences;
    final settingsJson = prefs.getString(_settingsKey);
    
    if (settingsJson == null) {
      return const AppSettings();
    }
    
    try {
      final data = jsonDecode(settingsJson) as Map<String, dynamic>;
      return AppSettings.fromJson(data);
    } catch (e) {
      return const AppSettings();
    }
  }
  Future<void> saveSettings(AppSettings settings) async {
    final prefs = await _preferences;
    final settingsJson = jsonEncode(settings.toJson());
    await prefs.setString(_settingsKey, settingsJson);
  }
  Future<bool> getAutoSaveScreenshot() async {
    final prefs = await _preferences;
    return prefs.getBool(_autoSaveScreenshotKey) ?? true;
  }
  Future<void> setAutoSaveScreenshot(bool value) async {
    final prefs = await _preferences;
    await prefs.setBool(_autoSaveScreenshotKey, value);
  }
  Future<void> clearAll() async {
    final prefs = await _preferences;
    await prefs.clear();
  }
}
