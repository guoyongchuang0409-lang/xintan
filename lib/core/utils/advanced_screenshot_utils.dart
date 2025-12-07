import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:gal/gal.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import '../services/path_manager.dart';
import '../theme/app_colors.dart';

class AdvancedScreenshotUtils {
  static final ScreenshotController _screenshotController = ScreenshotController();
  static ScreenshotController get controller => _screenshotController;
  
  /// 长截图方法 - 使用captureFromLongWidget
  static Future<Uint8List?> captureLongScreenshot({
    required Widget widget,
    double pixelRatio = 3.0,
    BuildContext? context,
    double targetWidth = 390,
    int delayMs = 500,
  }) async {
    try {
      debugPrint('长截图: captureFromLongWidget');
      final imageBytes = await _screenshotController.captureFromLongWidget(
        InheritedTheme.captureAll(
          context!,
          Material(
            color: AppColors.background,
            child: widget,
          ),
        ),
        pixelRatio: pixelRatio,
        delay: Duration(milliseconds: delayMs),
        context: context,
        constraints: BoxConstraints(
          maxWidth: targetWidth,
          minWidth: targetWidth,
        ),
      );
      return imageBytes;
    } catch (e) {
      debugPrint('长截图失败: $e');
      return null;
    }
  }

  static Future<SaveResult> saveScreenshot(
    Uint8List imageBytes, {
    String? fileName,
    bool useCustomPath = false,
  }) async {
    try {
      final name = fileName ?? 'quiz_report_${DateTime.now().millisecondsSinceEpoch}';
      
      if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
        return await _saveToDesktop(imageBytes, name, useCustomPath);
      } else {
        return await _saveToGallery(imageBytes, name);
      }
    } catch (e) {
      debugPrint('AdvancedScreenshotUtils: Error saving screenshot: $e');
      return SaveResult(
        success: false,
        message: '保存失败: $e',
      );
    }
  }

  static Future<SaveResult> _saveToDesktop(
    Uint8List imageBytes,
    String fileName,
    bool useCustomPath,
  ) async {
    try {
      String? filePath;
      
      if (useCustomPath) {
        filePath = await FilePicker.platform.saveFile(
          dialogTitle: '保存截图',
          fileName: '$fileName.png',
          type: FileType.image,
          allowedExtensions: ['png'],
        );
        
        if (filePath == null) {
          return SaveResult(
            success: false,
            message: '已取消保存',
          );
        }
      } else {
        final pathManager = PathManager.instance;
        filePath = await pathManager.generateFilePath(fileName);
      }
      
      final file = File(filePath);
      await file.writeAsBytes(imageBytes);
      
      return SaveResult(
        success: true,
        filePath: filePath,
        message: '已保存到: $filePath',
      );
    } catch (e) {
      debugPrint('AdvancedScreenshotUtils: Error saving to desktop: $e');
      return SaveResult(
        success: false,
        message: '保存失败: $e',
      );
    }
  }

  static Future<SaveResult> _saveToGallery(
    Uint8List imageBytes,
    String fileName,
  ) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final tempFile = File(path.join(tempDir.path, '$fileName.png'));
      await tempFile.writeAsBytes(imageBytes);
      
      await Gal.putImage(tempFile.path);
      await tempFile.delete();
      
      return SaveResult(
        success: true,
        message: '已保存到相册',
      );
    } catch (e) {
      debugPrint('AdvancedScreenshotUtils: Error saving to gallery: $e');
      return SaveResult(
        success: false,
        message: '保存到相册失败: $e',
      );
    }
  }

  static Future<String?> selectSavePath() async {
    try {
      final selectedPath = await FilePicker.platform.getDirectoryPath(
        dialogTitle: '选择截图保存路径',
      );
      
      if (selectedPath != null) {
        final pathManager = PathManager.instance;
        final success = await pathManager.setCustomPath(selectedPath);
        if (success) {
          return selectedPath;
        }
      }
      
      return null;
    } catch (e) {
      debugPrint('AdvancedScreenshotUtils: Error selecting path: $e');
      return null;
    }
  }
}

class SaveResult {
  final bool success;
  final String? filePath;
  final String message;

  const SaveResult({
    required this.success,
    this.filePath,
    required this.message,
  });
}
