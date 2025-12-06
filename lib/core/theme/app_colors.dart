import 'package:flutter/material.dart';
class AppColors {
  AppColors._();

  // 主题背景色 - 进一步提升亮度
  static const Color background = Color(0xFF1E293B);
  static const Color surface = Color(0xFF334155);
  static const Color surfaceLight = Color(0xFF475569);
  static const Color cardBackground = Color(0xFF3B4A5F);

  // 霓虹主题色 - 更加明亮鲜艳
  static const Color neonCyan = Color(0xFF06B6D4);
  static const Color neonPink = Color(0xFFF472B6);
  static const Color neonPurple = Color(0xFFC084FC);
  static const Color neonBlue = Color(0xFF60A5FA);
  static const Color neonGreen = Color(0xFF34D399);
  static const Color neonOrange = Color(0xFFFBBF24);

  // 文字颜色 - 进一步提高对比度
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFE5E7EB);
  static const Color textMuted = Color(0xFFD1D5DB);

  // 评分级别颜色 - 更鲜艳明亮
  static const Color ratingSSS = Color(0xFFF472B6); // 超爱 - 亮粉
  static const Color ratingSS = Color(0xFFC084FC);  // 喜欢 - 亮紫
  static const Color ratingS = Color(0xFF06B6D4);   // 可以 - 亮青
  static const Color ratingQ = Color(0xFF34D399);   // 勉强 - 亮绿
  static const Color ratingN = Color(0xFFF87171);   // 拒绝 - 亮红
  static const Color ratingW = Color(0xFFD1D5DB);   // 不懂 - 亮灰

  // 功能色 - 更鲜艳明快
  static const Color success = Color(0xFF34D399);
  static const Color warning = Color(0xFFFBBF24);
  static const Color error = Color(0xFFF87171);

  // 渐变
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [neonCyan, neonPurple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [
      Color(0xFF3F4B5E),
      Color(0xFF37415A),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // 霓虹渐变
  static const LinearGradient neonGradient = LinearGradient(
    colors: [neonCyan, neonPink],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient purpleGradient = LinearGradient(
    colors: [neonPurple, neonPink],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // 进度条渐变
  static const LinearGradient progressGradient = LinearGradient(
    colors: [neonCyan, neonPurple, neonPink],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
class AppDecorations {
  AppDecorations._();
  static List<BoxShadow> neonGlow({
    required Color color,
    double intensity = 0.6,
    double spread = 8.0,
  }) {
    // 确保视觉效果柔和不刺眼(Requirements: 10.6)
    final clampedIntensity = intensity.clamp(0.0, 0.8);
    return [
      BoxShadow(
        color: color.withOpacity(clampedIntensity * 0.4),
        blurRadius: spread,
        spreadRadius: 0,
      ),
      BoxShadow(
        color: color.withOpacity(clampedIntensity * 0.2),
        blurRadius: spread * 2,
        spreadRadius: spread * 0.5,
      ),
    ];
  }
  static BoxDecoration neonCardDecoration({
    Color glowColor = AppColors.neonCyan,
    double borderRadius = 16.0,
    bool isHovered = false,
  }) {
    final intensity = isHovered ? 0.8 : 0.5;
    return BoxDecoration(
      gradient: AppColors.cardGradient,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: glowColor.withOpacity(intensity),
        width: isHovered ? 2.0 : 1.0,
      ),
      boxShadow: neonGlow(
        color: glowColor,
        intensity: intensity,
        spread: isHovered ? 12.0 : 6.0,
      ),
    );
  }
  static BoxDecoration glowButtonDecoration({
    Color glowColor = AppColors.neonCyan,
    bool isPressed = false,
  }) {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          glowColor,
          glowColor.withOpacity(0.8),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: neonGlow(
        color: glowColor,
        intensity: isPressed ? 0.9 : 0.6,
        spread: isPressed ? 16.0 : 10.0,
      ),
    );
  }
  static BoxDecoration selectionGlowDecoration({
    required Color color,
    bool isSelected = false,
  }) {
    if (!isSelected) {
      return BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.textMuted.withOpacity(0.3),
          width: 1,
        ),
      );
    }
    return BoxDecoration(
      color: color.withOpacity(0.15),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: color,
        width: 2,
      ),
      boxShadow: neonGlow(
        color: color,
        intensity: 0.7,
        spread: 10.0,
      ),
    );
  }
  static BoxDecoration progressBarDecoration() {
    return BoxDecoration(
      gradient: AppColors.progressGradient,
      borderRadius: BorderRadius.circular(4),
      boxShadow: neonGlow(
        color: AppColors.neonCyan,
        intensity: 0.5,
        spread: 4.0,
      ),
    );
  }
  static BoxDecoration progressBarBackgroundDecoration() {
    return BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(4),
      border: Border.all(
        color: AppColors.textMuted.withOpacity(0.2),
        width: 1,
      ),
    );
  }
  static BoxDecoration tableCellDecoration({
    bool isHeader = false,
    bool isAlternate = false,
  }) {
    return BoxDecoration(
      color: isHeader
          ? AppColors.surfaceLight
          : (isAlternate ? AppColors.surface.withOpacity(0.5) : AppColors.surface),
      border: Border(
        bottom: BorderSide(
          color: AppColors.textMuted.withOpacity(0.2),
          width: 1,
        ),
      ),
    );
  }
}
