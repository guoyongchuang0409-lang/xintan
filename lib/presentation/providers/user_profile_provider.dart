import 'package:flutter/foundation.dart';
import '../../domain/models/user_profile.dart';
import '../../data/datasources/user_profile_datasource.dart';

/// 用户资料 Provider
class UserProfileProvider with ChangeNotifier {
  final UserProfileDatasource _datasource;
  UserProfile _profile = const UserProfile(nickname: '未设置昵称');
  bool _isLoading = false;

  UserProfileProvider({UserProfileDatasource? datasource})
      : _datasource = datasource ?? UserProfileDatasource.instance {
    loadProfile();
  }

  UserProfile get profile => _profile;
  bool get isLoading => _isLoading;

  /// 加载用户资料
  Future<void> loadProfile() async {
    _isLoading = true;
    notifyListeners();

    try {
      _profile = await _datasource.getUserProfile();
    } catch (e) {
      debugPrint('Error loading user profile: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// 更新用户资料
  Future<bool> updateProfile(UserProfile newProfile) async {
    try {
      final success = await _datasource.saveUserProfile(newProfile);
      if (success) {
        _profile = newProfile;
        notifyListeners();
      }
      return success;
    } catch (e) {
      debugPrint('Error updating user profile: $e');
      return false;
    }
  }

  /// 更新昵称
  Future<bool> updateNickname(String nickname) async {
    if (nickname.trim().isEmpty) return false;
    
    try {
      final success = await _datasource.updateNickname(nickname);
      if (success) {
        _profile = _profile.copyWith(nickname: nickname);
        notifyListeners();
      }
      return success;
    } catch (e) {
      debugPrint('Error updating nickname: $e');
      return false;
    }
  }

  /// 更新年龄
  Future<bool> updateAge(int? age) async {
    try {
      final success = await _datasource.updateAge(age);
      if (success) {
        _profile = _profile.copyWith(age: age);
        notifyListeners();
      }
      return success;
    } catch (e) {
      debugPrint('Error updating age: $e');
      return false;
    }
  }

  /// 更新性别
  Future<bool> updateGender(String? gender) async {
    try {
      final success = await _datasource.updateGender(gender);
      if (success) {
        _profile = _profile.copyWith(gender: gender);
        notifyListeners();
      }
      return success;
    } catch (e) {
      debugPrint('Error updating gender: $e');
      return false;
    }
  }

  /// 清除用户资料
  Future<bool> clearProfile() async {
    try {
      final success = await _datasource.clearUserProfile();
      if (success) {
        _profile = const UserProfile(nickname: '未设置昵称');
        notifyListeners();
      }
      return success;
    } catch (e) {
      debugPrint('Error clearing user profile: $e');
      return false;
    }
  }
}
