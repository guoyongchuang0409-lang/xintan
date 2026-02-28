import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/models/user_profile.dart';

/// 用户资料数据源
class UserProfileDatasource {
  static const String _userProfileKey = 'user_profile';
  
  static UserProfileDatasource? _instance;
  SharedPreferences? _prefs;

  UserProfileDatasource._();

  static UserProfileDatasource get instance {
    _instance ??= UserProfileDatasource._();
    return _instance!;
  }

  Future<SharedPreferences> get _preferences async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  /// 获取用户资料
  Future<UserProfile> getUserProfile() async {
    final prefs = await _preferences;
    final jsonString = prefs.getString(_userProfileKey);
    
    if (jsonString == null || jsonString.isEmpty) {
      // 返回默认用户资料
      return const UserProfile(nickname: '未设置昵称');
    }
    
    try {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return UserProfile.fromJson(json);
    } catch (e) {
      print('Error loading user profile: $e');
      return const UserProfile(nickname: '未设置昵称');
    }
  }

  /// 保存用户资料
  Future<bool> saveUserProfile(UserProfile profile) async {
    try {
      final prefs = await _preferences;
      final jsonString = jsonEncode(profile.toJson());
      return await prefs.setString(_userProfileKey, jsonString);
    } catch (e) {
      print('Error saving user profile: $e');
      return false;
    }
  }

  /// 更新昵称
  Future<bool> updateNickname(String nickname) async {
    final profile = await getUserProfile();
    final updatedProfile = profile.copyWith(nickname: nickname);
    return await saveUserProfile(updatedProfile);
  }

  /// 更新年龄
  Future<bool> updateAge(int? age) async {
    final profile = await getUserProfile();
    final updatedProfile = profile.copyWith(age: age);
    return await saveUserProfile(updatedProfile);
  }

  /// 更新性别
  Future<bool> updateGender(String? gender) async {
    final profile = await getUserProfile();
    final updatedProfile = profile.copyWith(gender: gender);
    return await saveUserProfile(updatedProfile);
  }

  /// 清除用户资料
  Future<bool> clearUserProfile() async {
    try {
      final prefs = await _preferences;
      return await prefs.remove(_userProfileKey);
    } catch (e) {
      print('Error clearing user profile: $e');
      return false;
    }
  }
}
