import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import '../services/path_manager.dart';
class AdvancedScreenshotUtils {
  static final ScreenshotController _screenshotController = ScreenshotController();
  static ScreenshotController get controller => _screenshotController;
  static Future<Uint8List?> captureLongScreenshot({
    required Widget widget,
    double pixelRatio = 3.0,
  }) async {
    try {
      // 使用Screenshot包捕获widget
      final imageBytes = await _screenshotController.captureFromWidget(
        widget,
        pixelRatio: pixelRatio,
        context: null,
      );
      
      return imageBytes;
    } catch (e) {
      debugPrint('AdvancedScreenshotUtils: Error capturing long screenshot: $e');
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
      
      // 判断平台
      if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
        // 电脑端：使用PathManager或文件选择
        return await _saveToDesktop(imageBytes, name, useCustomPath);
      } else {
        // 移动端：保存到相
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
        // 让用户临时选择保存路径（单次使用）
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
        // 使用PathManager管理的路
        final pathManager = PathManager.instance;
        filePath = await pathManager.generateFilePath(fileName);
      }
      
      // 写入文件
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
      final result = await ImageGallerySaverPlus.saveImage(
        imageBytes,
        quality: 100,
        name: fileName,
      );

      if (result != null && result['isSuccess'] == true) {
        return SaveResult(
          success: true,
          filePath: result['filePath'] as String?,
          message: '已保存到相册',
        );
      } else {
        return SaveResult(
          success: false,
          message: result?['errorMessage'] as String? ?? '保存失败',
        );
      }
    } catch (e) {
      debugPrint('AdvancedScreenshotUtils: Error saving to gallery: $e');
      return SaveResult(
        success: false,
        message: '保存到相册失 $e',
      );
    }
  }
  static Future<List<SaveResult>> saveMultipleScreenshots(
    List<Uint8List> imageBytesList, {
    String? baseFileName,
    bool useCustomPath = false,
  }) async {
    final results = <SaveResult>[];
    final baseName = baseFileName ?? 'quiz_report';
    
    // 如果是电脑端且使用自己测定义路径，先选择目录
    String? selectedDirectory;
    if ((Platform.isWindows || Platform.isMacOS || Platform.isLinux) && useCustomPath) {
      selectedDirectory = await FilePicker.platform.getDirectoryPath(
        dialogTitle: '选择保存目录',
      );
      
      if (selectedDirectory == null) {
        return [SaveResult(
          success: false,
          message: '已取消保存',
        )];
      }
    }
    
    // 保存每张图片
    for (int i = 0; i < imageBytesList.length; i++) {
      final fileName = '${baseName}_${i + 1}_${DateTime.now().millisecondsSinceEpoch}';
      
      SaveResult result;
      if (selectedDirectory != null) {
        // 保存到选定的目
        final filePath = path.join(selectedDirectory, '$fileName.png');
        final file = File(filePath);
        try {
          await file.writeAsBytes(imageBytesList[i]);
          result = SaveResult(
            success: true,
            filePath: filePath,
            message: '已保存到: $filePath',
          );
        } catch (e) {
          result = SaveResult(
            success: false,
            message: '保存失败: $e',
          );
        }
      } else {
        // 使用默认保存方向法
        result = await saveScreenshot(
          imageBytesList[i],
          fileName: fileName,
          useCustomPath: false,
        );
      }
      
      results.add(result);
    }
    
    return results;
  }
  static Future<String?> selectSavePath() async {
    try {
      final selectedPath = await FilePicker.platform.getDirectoryPath(
        dialogTitle: '选择截图保存路径',
      );
      
      if (selectedPath != null) {
        // 保存选择的路
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
