import 'package:flutter/foundation.dart' show kIsWeb;
import 'database_interface.dart';
import 'local_database.dart';
import 'web_database.dart';

/// 数据库工厂
/// 根据平台返回合适的数据库实现
class DatabaseFactory {
  static DatabaseInterface? _instance;

  static DatabaseInterface get instance {
    if (_instance == null) {
      if (kIsWeb) {
        _instance = WebDatabase.instance;
      } else {
        _instance = LocalDatabase.instance;
      }
    }
    return _instance!;
  }
}
