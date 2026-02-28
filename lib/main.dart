import 'package:flutter/foundation.dart' show kIsWeb, debugPrint;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app/app.dart';
import 'core/services/sound_service.dart';
import 'data/datasources/database_factory.dart';
import 'data/datasources/preferences_datasource.dart';

// 条件导入：只在非 Web 平台导入
import 'main_io.dart' if (dart.library.html) 'main_web.dart' as platform;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 平台特定初始化
  try {
    await platform.initializePlatform();
  } catch (e) {
    debugPrint('Platform initialization error (non-critical): $e');
  }
  
  // 设置系统UI样式（仅在支持的平台上）
  try {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Color(0xFF0D0D1A),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  } catch (e) {
    debugPrint('SystemChrome.setSystemUIOverlayStyle error (non-critical): $e');
  }
  
  // 设置首选屏幕方向（仅在支持的平台上）
  try {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  } catch (e) {
    debugPrint('SystemChrome.setPreferredOrientations error (non-critical): $e');
  }
  
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
      // 使用数据库工厂获取平台特定的实现
      final db = DatabaseFactory.instance;
      // 触发初始化（对于 SQLite 会打开数据库，对于 Web 会初始化 SharedPreferences）
      await db.getAllReports();
    } catch (e) {
      debugPrint('Database initialization error: $e');
      // Web 平台数据库初始化失败不应该阻止应用启动
      if (!kIsWeb) {
        rethrow;
      }
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
