import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'app/app.dart';
import 'core/services/sound_service.dart';
import 'data/datasources/local_database.dart';
import 'data/datasources/preferences_datasource.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 桌面端初始化化 sqflite_ffi
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  
  // 设置系统UI样式为深色主题题
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF0D0D1A),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  
  // 设置首选屏幕方向向
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  runApp(const QuizApp());
}
class AppInitializer {
  static bool _isInitialized = false;
  
  static bool get isInitialized => _isInitialized;
  static Future<void> initialize() async {
    if (_isInitialized) return;
    
    try {
      // 并行初始化化数据库、设置和音效
      await Future.wait([
        _initDatabase(),
        _initPreferences(),
        _initSound(),
      ]);
      
      _isInitialized = true;
    } catch (e) {
      debugPrint('App initialization error: $e');
      // 即使初始化化失败也标记为已初始化化，让应用继续运行行
      _isInitialized = true;
      rethrow;
    }
  }
  static Future<void> _initDatabase() async {
    try {
      // 触发数据库初始化化
      await LocalDatabase.instance.database;
    } catch (e) {
      debugPrint('Database initialization error: $e');
      rethrow;
    }
  }
  static Future<void> _initPreferences() async {
    try {
      // 触发SharedPreferences初始化化
      await PreferencesDatasource.instance.getSettings();
    } catch (e) {
      debugPrint('Preferences initialization error: $e');
      rethrow;
    }
  }
  static Future<void> _initSound() async {
    try {
      await SoundService.instance.initialize();
    } catch (e) {
      debugPrint('Sound service initialization error: $e');
      // 音效初始化化失败不影响应用运行行
    }
  }
}
