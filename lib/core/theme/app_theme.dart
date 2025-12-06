import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_animations.dart';
class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.neonCyan,
        secondary: AppColors.neonPurple,
        surface: AppColors.surface,
        error: AppColors.error,
        onPrimary: AppColors.background,
        onSecondary: AppColors.textPrimary,
        onSurface: AppColors.textPrimary,
        onError: AppColors.textPrimary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.neonCyan,
          foregroundColor: AppColors.background,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.neonCyan,
        ),
      ),
      iconTheme: const IconThemeData(
        color: AppColors.neonCyan,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        headlineSmall: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 16,
        ),
        bodyMedium: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 14,
        ),
        bodySmall: TextStyle(
          color: AppColors.textMuted,
          fontSize: 12,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.neonCyan,
        unselectedItemColor: AppColors.textMuted,
      ),
      // 页面过渡动画配置 (Requirements: 10.2)
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: _NeonPageTransitionsBuilder(),
          TargetPlatform.iOS: _NeonPageTransitionsBuilder(),
          TargetPlatform.windows: _NeonPageTransitionsBuilder(),
          TargetPlatform.macOS: _NeonPageTransitionsBuilder(),
          TargetPlatform.linux: _NeonPageTransitionsBuilder(),
        },
      ),
      // 对话框主题
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        titleTextStyle: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      // 底部弹出框主题
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),
      // 开关主题
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.neonCyan;
          }
          return AppColors.textMuted;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.neonCyan.withOpacity(0.3);
          }
          return AppColors.surface;
        }),
      ),
      // 滑块主题题
      sliderTheme: SliderThemeData(
        activeTrackColor: AppColors.neonCyan,
        inactiveTrackColor: AppColors.surface,
        thumbColor: AppColors.neonCyan,
        overlayColor: AppColors.neonCyan.withOpacity(0.2),
      ),
      // 进度指示器主题
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.neonCyan,
        linearTrackColor: AppColors.surface,
      ),
      // Snackbar主题题
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.surfaceLight,
        contentTextStyle: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 14,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
class _NeonPageTransitionsBuilder extends PageTransitionsBuilder {
  const _NeonPageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: AppAnimations.defaultCurve,
      ),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.05, 0),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: AppAnimations.defaultCurve,
        )),
        child: child,
      ),
    );
  }
}
class AppPageRoute {
  AppPageRoute._();
  static PageRouteBuilder<T> fadeSlide<T>({
    required Widget page,
    RouteSettings? settings,
  }) {
    return PageRouteBuilder<T>(
      settings: settings,
      transitionDuration: AppAnimations.pageTransition,
      reverseTransitionDuration: AppAnimations.pageTransitionReverse,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: AppAnimations.defaultCurve,
          ),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.1, 0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: AppAnimations.defaultCurve,
            )),
            child: child,
          ),
        );
      },
    );
  }
  static PageRouteBuilder<T> scaleIn<T>({
    required Widget page,
    RouteSettings? settings,
  }) {
    return PageRouteBuilder<T>(
      settings: settings,
      transitionDuration: AppAnimations.pageTransition,
      reverseTransitionDuration: AppAnimations.pageTransitionReverse,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: AppAnimations.defaultCurve,
          ),
          child: ScaleTransition(
            scale: Tween<double>(
              begin: 0.95,
              end: 1.0,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: AppAnimations.defaultCurve,
            )),
            child: child,
          ),
        );
      },
    );
  }
}
