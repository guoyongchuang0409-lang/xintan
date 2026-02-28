import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
class PathManager {
  static PathManager? _instance;
  static PathManager get instance => _instance ??= PathManager._();
  
  PathManager._();
  
  static const String _customPathKey = 'custom_screenshot_path';
  String? _customPath;
  Future<String> getCurrentPath() async {
    // Web 平台直接返回默认路径
    if (kIsWeb) {
      return await getDefaultPath();
    }
    
    // 如果有自己测定义路径，使用自己测定义路径
    if (_customPath != null && await Directory(_customPath!).exists()) {
      return _customPath!;
    }
    
    // 从SharedPreferences加载
    final prefs = await SharedPreferences.getInstance();
    final savedPath = prefs.getString(_customPathKey);
    
    if (savedPath != null && await Directory(savedPath).exists()) {
      _customPath = savedPath;
      return savedPath;
    }
    
    // 返回默认路径
    return await getDefaultPath();
  }
  Future<bool> setCustomPath(String? newPath) async {
    // Web 平台不支持自定义路径
    if (kIsWeb) {
      return false;
    }
    
    if (newPath == null) {
      // 清除自己测定义路
      _customPath = null;
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_customPathKey);
      return true;
    }
    
    // 验证路径是否存在
    final directory = Directory(newPath);
    if (!await directory.exists()) {
      // 尝试创建目录
      try {
        await directory.create(recursive: true);
      } catch (e) {
        return false;
      }
    }
    
    // 保存路径
    _customPath = newPath;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_customPathKey, newPath);
    return true;
  }
  Future<String> getDefaultPath() async {
    // Web 平台不支持文件系统操作
    if (kIsWeb) {
      return '/downloads'; // Web 平台返回虚拟路径
    }
    
    if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
      // 电脑端：文档目录下的QuizReports文件
      final directory = await getApplicationDocumentsDirectory();
      final screenshotsDir = Directory(path.join(directory.path, 'QuizReports'));
      
      if (!await screenshotsDir.exists()) {
        await screenshotsDir.create(recursive: true);
      }
      
      return screenshotsDir.path;
    } else {
      // 移动端：使用临时目录（因为会保存到相册）
      final directory = await getTemporaryDirectory();
      return directory.path;
    }
  }
  Future<bool> hasCustomPath() async {
    // Web 平台不支持自定义路径
    if (kIsWeb) {
      return false;
    }
    
    if (_customPath != null) return true;
    
    final prefs = await SharedPreferences.getInstance();
    final savedPath = prefs.getString(_customPathKey);
    
    if (savedPath != null && await Directory(savedPath).exists()) {
      _customPath = savedPath;
      return true;
    }
    
    return false;
  }
  Future<void> clearCustomPath() async {
    _customPath = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_customPathKey);
  }
  Future<String> generateFilePath(String fileName) async {
    final directory = await getCurrentPath();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final fileNameWithTimestamp = '${fileName}_$timestamp.png';
    return path.join(directory, fileNameWithTimestamp);
  }
}
