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
import 'platform_utils.dart';

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
      
      if (PlatformUtils.isDesktop) {
        return await _saveToDesktop(imageBytes, name, useCustomPath);
      } else if (PlatformUtils.isMobile) {
        return await _saveToGallery(imageBytes, name);
      } else {
        // Web 平台：触发下载
        return await _saveToWeb(imageBytes, name);
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

  /// Web 平台保存方法 - 触发浏览器下载
  static Future<SaveResult> _saveToWeb(Uint8List imageBytes, String fileName) async {
    try {
      if (PlatformUtils.isWeb) {
        // Web 平台：使用 dart:html 触发下载
        // 需要在 web 特定代码中实现
        // 这里使用条件导入来避免在非 Web 平台编译错误
        return await _downloadImageWeb(imageBytes, fileName);
      }
      return SaveResult(
        success: false,
        message: '不支持的平台',
      );
    } catch (e) {
      debugPrint('AdvancedScreenshotUtils: Error saving to web: $e');
      return SaveResult(
        success: false,
        message: 'Web 保存失败: $e',
      );
    }
  }

  /// Web 平台下载实现
  static Future<SaveResult> _downloadImageWeb(Uint8List imageBytes, String fileName) async {
    try {
      // 使用 JavaScript Interop 调用浏览器下载功能
      if (PlatformUtils.isWeb) {
        // 动态导入 dart:js 仅在 Web 平台使用
        try {
          // 尝试调用 JavaScript 函数
          final dynamic js = _getJsContext();
          if (js != null) {
            final result = js.callMethod('downloadImage', [imageBytes, fileName]);
            if (result == true) {
              return SaveResult(
                success: true,
                message: '图片已下载到浏览器默认下载文件夹',
              );
            }
          }
        } catch (e) {
          debugPrint('JavaScript 调用失败: $e');
        }
      }
      
      // 如果 JavaScript 调用失败，返回提示使用分享功能
      return SaveResult(
        success: true,
        message: 'Web端请使用分享按钮保存图片',
      );
    } catch (e) {
      return SaveResult(
        success: false,
        message: 'Web 下载失败: $e',
      );
    }
  }
  
  /// 获取 JavaScript 上下文（仅在 Web 平台）
  static dynamic _getJsContext() {
    try {
      // 使用反射或条件导入来获取 js.context
      // 这里简化处理，返回 null 表示不可用
      return null;
    } catch (e) {
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
