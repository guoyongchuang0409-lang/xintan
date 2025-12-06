import 'package:flutter/material.dart';
class AppAnimations {
  AppAnimations._();

  // 动画时长
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 400);

  // 页面过渡动画时长
  static const Duration pageTransition = Duration(milliseconds: 300);
  static const Duration pageTransitionReverse = Duration(milliseconds: 200);

  // 动画曲线
  static const Curve defaultCurve = Curves.easeInOutCubic;
  static const Curve bounceCurve = Curves.elasticOut;
  static const Curve smoothCurve = Curves.easeOutQuart;

  // 发光动画配置
  static const Duration glowPulse = Duration(milliseconds: 1500);
  static const Duration glowFade = Duration(milliseconds: 300);

  // 进度条动
  static const Duration progressUpdate = Duration(milliseconds: 400);

  // 数据展示动画
  static const Duration dataReveal = Duration(milliseconds: 50); // 每行延迟
  static const Duration dataFadeIn = Duration(milliseconds: 300);

  // 选中状态动
  static const Duration selectionGlow = Duration(milliseconds: 250);

  // 卡片悬停动画
  static const Duration cardHover = Duration(milliseconds: 200);
  static PageRouteBuilder<T> createPageRoute<T>({
    required Widget page,
    required RouteSettings settings,
    SlideDirection direction = SlideDirection.rightToLeft,
  }) {
    return PageRouteBuilder<T>(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: pageTransition,
      reverseTransitionDuration: pageTransitionReverse,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return _buildSlideTransition(animation, child, direction);
      },
    );
  }
  static Widget _buildSlideTransition(
    Animation<double> animation,
    Widget child,
    SlideDirection direction,
  ) {
    final begin = _getSlideOffset(direction);
    const end = Offset.zero;

    final tween = Tween(begin: begin, end: end).chain(
      CurveTween(curve: defaultCurve),
    );

    return SlideTransition(
      position: animation.drive(tween),
      child: FadeTransition(
        opacity: CurvedAnimation(
          parent: animation,
          curve: smoothCurve,
        ),
        child: child,
      ),
    );
  }
  static Offset _getSlideOffset(SlideDirection direction) {
    switch (direction) {
      case SlideDirection.rightToLeft:
        return const Offset(1.0, 0.0);
      case SlideDirection.leftToRight:
        return const Offset(-1.0, 0.0);
      case SlideDirection.bottomToTop:
        return const Offset(0.0, 1.0);
      case SlideDirection.topToBottom:
        return const Offset(0.0, -1.0);
    }
  }
  static PageRouteBuilder<T> createFadeRoute<T>({
    required Widget page,
    required RouteSettings settings,
  }) {
    return PageRouteBuilder<T>(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: pageTransition,
      reverseTransitionDuration: pageTransitionReverse,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: smoothCurve,
          ),
          child: child,
        );
      },
    );
  }
  static PageRouteBuilder<T> createScaleRoute<T>({
    required Widget page,
    required RouteSettings settings,
  }) {
    return PageRouteBuilder<T>(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: pageTransition,
      reverseTransitionDuration: pageTransitionReverse,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final scaleAnimation = Tween<double>(
          begin: 0.9,
          end: 1.0,
        ).chain(CurveTween(curve: defaultCurve));

        return ScaleTransition(
          scale: animation.drive(scaleAnimation),
          child: FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: smoothCurve,
            ),
            child: child,
          ),
        );
      },
    );
  }
}
enum SlideDirection {
  rightToLeft,
  leftToRight,
  bottomToTop,
  topToBottom,
}
