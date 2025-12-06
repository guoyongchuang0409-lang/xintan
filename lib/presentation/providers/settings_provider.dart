import 'package:flutter/foundation.dart';
import '../../domain/models/app_settings.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../data/repositories/settings_repository_impl.dart';
class SettingsProvider extends ChangeNotifier {
  final SettingsRepository _repository;
  
  AppSettings _settings = const AppSettings();
  bool _isLoading = false;
  String? _errorMessage;

  SettingsProvider({SettingsRepository? repository})
      : _repository = repository ?? SettingsRepositoryImpl();

  AppSettings get settings => _settings;
  bool get isLoading => _isLoading;
  bool get autoSaveScreenshot => _settings.autoSaveScreenshot;
  String? get errorMessage => _errorMessage;
  Future<void> loadSettings() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _settings = await _repository.getSettings();
    } catch (e) {
      _errorMessage = '加载设置失败';
      debugPrint('Error loading settings: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  Future<void> toggleAutoSaveScreenshot() async {
    _isLoading = true;
    notifyListeners();

    try {
      final newValue = !_settings.autoSaveScreenshot;
      await _repository.setAutoSaveScreenshot(newValue);
      _settings = _settings.copyWith(autoSaveScreenshot: newValue);
    } catch (e) {
      _errorMessage = '保存设置失败';
      debugPrint('Error toggling auto save screenshot: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  Future<bool> clearAllData() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // This will be called from settings page which will also clear reports
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = '清除数据失败';
      debugPrint('Error clearing all data: $e');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
