/// 用户资料模型
class UserProfile {
  final String nickname;
  final int? age;
  final String? gender; // 'male', 'female', 'other'
  final String? avatar; // 头像路径或 URL

  const UserProfile({
    required this.nickname,
    this.age,
    this.gender,
    this.avatar,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      nickname: json['nickname'] as String? ?? '未设置昵称',
      age: json['age'] as int?,
      gender: json['gender'] as String?,
      avatar: json['avatar'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nickname': nickname,
      'age': age,
      'gender': gender,
      'avatar': avatar,
    };
  }

  UserProfile copyWith({
    String? nickname,
    int? age,
    String? gender,
    String? avatar,
  }) {
    return UserProfile(
      nickname: nickname ?? this.nickname,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      avatar: avatar ?? this.avatar,
    );
  }

  String get genderDisplay {
    switch (gender) {
      case 'male':
        return '男';
      case 'female':
        return '女';
      case 'other':
        return '其他';
      default:
        return '未设置';
    }
  }

  String get ageDisplay {
    return age != null ? '$age 岁' : '未设置';
  }
}
