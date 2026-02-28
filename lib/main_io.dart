import 'dart:io';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

/// Platform-specific initialization for IO platforms (Windows, Linux, macOS, Android, iOS)
Future<void> initializePlatform() async {
  // 桌面端初始化 sqflite_ffi
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
}
