import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
class SoundService {
  static SoundService? _instance;
  static SoundService get instance {
    _instance ??= SoundService._();
    return _instance!;
  }

  SoundService._();

  AudioPlayer? _clickPlayer;
  AudioPlayer? _selectPlayer;
  AudioPlayer? _successPlayer;
  AudioPlayer? _buttonPlayer;
  AudioPlayer? _switchPlayer;
  AudioPlayer? _tapPlayer;
  AudioPlayer? _notificationPlayer;
  AudioPlayer? _swipePlayer;
  AudioPlayer? _completePlayer;
  
  bool _soundEnabled = true;
  bool _hapticEnabled = true;
  bool _isInitialized = false;
  bool _hasAudioFiles = false;
  bool _isDesktop = false;

  bool get soundEnabled => _soundEnabled;
  bool get hapticEnabled => _hapticEnabled;
  Future<void> initialize() async {
    if (_isInitialized) return;
    
    // 检测是否为桌面平台
    _isDesktop = Platform.isWindows || Platform.isLinux || Platform.isMacOS;
    
    try {
      // 初始化化音频播放器
      _clickPlayer = AudioPlayer();
      _selectPlayer = AudioPlayer();
      _successPlayer = AudioPlayer();
      _buttonPlayer = AudioPlayer();
      _switchPlayer = AudioPlayer();
      _tapPlayer = AudioPlayer();
      _notificationPlayer = AudioPlayer();
      _swipePlayer = AudioPlayer();
      _completePlayer = AudioPlayer();
      
      // 设置音量
      await _clickPlayer?.setVolume(0.3);
      await _selectPlayer?.setVolume(0.4);
      await _successPlayer?.setVolume(0.5);
      await _buttonPlayer?.setVolume(0.35);
      await _switchPlayer?.setVolume(0.4);
      await _tapPlayer?.setVolume(0.3);
      await _notificationPlayer?.setVolume(0.45);
      await _swipePlayer?.setVolume(0.35);
      await _completePlayer?.setVolume(0.5);
      
      // 设置播放模式
      await _clickPlayer?.setReleaseMode(ReleaseMode.stop);
      await _selectPlayer?.setReleaseMode(ReleaseMode.stop);
      await _successPlayer?.setReleaseMode(ReleaseMode.stop);
      await _buttonPlayer?.setReleaseMode(ReleaseMode.stop);
      await _switchPlayer?.setReleaseMode(ReleaseMode.stop);
      await _tapPlayer?.setReleaseMode(ReleaseMode.stop);
      await _notificationPlayer?.setReleaseMode(ReleaseMode.stop);
      await _swipePlayer?.setReleaseMode(ReleaseMode.stop);
      await _completePlayer?.setReleaseMode(ReleaseMode.stop);
      
      // 音效文件已准备就
      _hasAudioFiles = true;
      debugPrint('Sound service initialized successfully with audio files');
    } catch (e) {
      debugPrint('AudioPlayer initialization error: $e');
      _hasAudioFiles = false;
    }
    
    _isInitialized = true;
  }
  void setSoundEnabled(bool enabled) {
    _soundEnabled = enabled;
  }
  void setHapticEnabled(bool enabled) {
    _hapticEnabled = enabled;
  }
  Future<void> playClick() async {
    if (!_soundEnabled) return;
    
    // 触觉反馈（仅移动平台
    if (!_isDesktop && _hapticEnabled) {
      HapticFeedback.lightImpact();
    }
    
    // 播放音效文件
    if (_hasAudioFiles) {
      try {
        await _clickPlayer?.stop();
        await _clickPlayer?.play(AssetSource('sounds/swipe.mp3'));
      } catch (e) {
        debugPrint('Click sound error: $e');
      }
    }
  }
  Future<void> playSelect() async {
    if (!_soundEnabled) return;
    
    // 触觉反馈（仅移动平台
    if (!_isDesktop && _hapticEnabled) {
      HapticFeedback.mediumImpact();
    }
    
    // 播放音效文件
    if (_hasAudioFiles) {
      try {
        await _selectPlayer?.stop();
        await _selectPlayer?.play(AssetSource('sounds/swipe.mp3'));
      } catch (e) {
        debugPrint('Select sound error: $e');
      }
    }
  }
  Future<void> playSuccess() async {
    if (!_soundEnabled) return;
    
    // 触觉反馈（仅移动平台
    if (!_isDesktop && _hapticEnabled) {
      HapticFeedback.heavyImpact();
    }
    
    // 播放音效文件
    if (_hasAudioFiles) {
      try {
        await _successPlayer?.stop();
        await _successPlayer?.play(AssetSource('sounds/swipe.mp3'));
      } catch (e) {
        debugPrint('Success sound error: $e');
      }
    }
  }
  Future<void> playButton() async {
    if (!_soundEnabled) return;
    
    // 触觉反馈（仅移动平台
    if (!_isDesktop && _hapticEnabled) {
      HapticFeedback.lightImpact();
    }
    
    // 播放音效文件
    if (_hasAudioFiles) {
      try {
        await _buttonPlayer?.stop();
        await _buttonPlayer?.play(AssetSource('sounds/swipe.mp3'));
      } catch (e) {
        debugPrint('Button sound error: $e');
      }
    }
  }
  Future<void> playSwitch() async {
    if (!_soundEnabled) return;
    
    // 触觉反馈（仅移动平台
    if (!_isDesktop && _hapticEnabled) {
      HapticFeedback.mediumImpact();
    }
    
    // 播放音效文件
    if (_hasAudioFiles) {
      try {
        await _switchPlayer?.stop();
        await _switchPlayer?.play(AssetSource('sounds/swipe.mp3'));
      } catch (e) {
        debugPrint('Switch sound error: $e');
      }
    }
  }
  Future<void> playTap() async {
    if (!_soundEnabled) return;
    
    // 触觉反馈（仅移动平台
    if (!_isDesktop && _hapticEnabled) {
      HapticFeedback.selectionClick();
    }
    
    // 播放音效文件 - 使用轻柔的滑动音
    if (_hasAudioFiles) {
      try {
        await _tapPlayer?.stop();
        await _tapPlayer?.play(AssetSource('sounds/swipe.mp3'));
      } catch (e) {
        debugPrint('Tap sound error: $e');
      }
    }
  }
  Future<void> playNotification() async {
    if (!_soundEnabled) return;
    
    // 触觉反馈（仅移动平台
    if (!_isDesktop && _hapticEnabled) {
      HapticFeedback.mediumImpact();
    }
    
    // 播放音效文件
    if (_hasAudioFiles) {
      try {
        await _notificationPlayer?.stop();
        await _notificationPlayer?.play(AssetSource('sounds/swipe.mp3'));
      } catch (e) {
        debugPrint('Notification sound error: $e');
      }
    }
  }
  Future<void> playSwipe() async {
    if (!_soundEnabled) return;
    
    // 触觉反馈（仅移动平台
    if (!_isDesktop && _hapticEnabled) {
      HapticFeedback.selectionClick();
    }
    
    // 播放音效文件
    if (_hasAudioFiles) {
      try {
        await _swipePlayer?.stop();
        await _swipePlayer?.play(AssetSource('sounds/swipe.mp3'));
      } catch (e) {
        debugPrint('Swipe sound error: $e');
      }
    }
  }
  Future<void> playComplete() async {
    if (!_soundEnabled) return;
    
    // 触觉反馈（仅移动平台
    if (!_isDesktop && _hapticEnabled) {
      HapticFeedback.heavyImpact();
    }
    
    // 播放音效文件
    if (_hasAudioFiles) {
      try {
        await _completePlayer?.stop();
        await _completePlayer?.play(AssetSource('sounds/swipe.mp3'));
      } catch (e) {
        debugPrint('Complete sound error: $e');
      }
    }
  }
  Future<void> dispose() async {
    await _clickPlayer?.dispose();
    await _selectPlayer?.dispose();
    await _successPlayer?.dispose();
    await _buttonPlayer?.dispose();
    await _switchPlayer?.dispose();
    await _tapPlayer?.dispose();
    await _notificationPlayer?.dispose();
    await _swipePlayer?.dispose();
    await _completePlayer?.dispose();
  }
}
class SoundEffects {
  static void click() => SoundService.instance.playClick();
  static void select() => SoundService.instance.playSelect();
  static void success() => SoundService.instance.playSuccess();
  static void button() => SoundService.instance.playButton();
  static void switchToggle() => SoundService.instance.playSwitch();
  static void tap() => SoundService.instance.playTap();
  static void notification() => SoundService.instance.playNotification();
  static void swipe() => SoundService.instance.playSwipe();
  static void complete() => SoundService.instance.playComplete();
}
