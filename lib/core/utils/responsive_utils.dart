import 'package:flutter/material.dart';

/// 响应式布局工具类
class ResponsiveUtils {
  /// 屏幕断点
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 800; // 降低桌面端断点，使侧边栏更早生效

  /// 判断是否为移动端
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < mobileBreakpoint;
  }

  /// 判断是否为平板
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= mobileBreakpoint && width < desktopBreakpoint;
  }

  /// 判断是否为桌面端
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= desktopBreakpoint;
  }

  /// 获取屏幕宽度
  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// 获取屏幕高度
  static double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// 获取响应式值
  static T getValue<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop(context) && desktop != null) {
      return desktop;
    }
    if (isTablet(context) && tablet != null) {
      return tablet;
    }
    return mobile;
  }

  /// 获取横向内边距
  static double getHorizontalPadding(BuildContext context) {
    final width = getWidth(context);
    if (width >= desktopBreakpoint) {
      // 桌面端:使用最大宽度限制,居中显示
      return (width - 800) / 2;
    } else if (width >= tabletBreakpoint) {
      // 平板:适中的边距
      return 32;
    } else {
      // 移动端:较小边距
      return 16;
    }
  }

  /// 获取内容最大宽度
  static double getMaxContentWidth(BuildContext context) {
    final width = getWidth(context);
    if (width >= desktopBreakpoint) {
      return 800; // 桌面端限制最大宽度
    }
    return width; // 移动端和平板使用全宽
  }

  /// 获取卡片间距
  static double getCardSpacing(BuildContext context) {
    final height = getHeight(context);
    // 根据屏幕高度动态计算卡片间距，使用更精确的比例
    if (height > 900) {
      return 12;
    } else if (height > 800) {
      return 10;
    } else if (height > 700) {
      return 8;
    } else if (height > 600) {
      return 6;
    } else {
      return 4;
    }
  }

  /// 获取头部高度
  /// 根据屏幕高度动态计算头部高度，确保头部占据合适的比例
  static double getHeaderHeight(BuildContext context) {
    final height = getHeight(context);
    // 头部高度占屏幕高度的比例约为 10-12%
    // 约束在 60px-130px 之间
    final dynamicHeight = height * 0.11;
    return dynamicHeight.clamp(60.0, 130.0);
  }

  /// 获取头部Logo尺寸
  /// 根据头部高度动态计算Logo尺寸，保持比例协调
  static double getHeaderLogoSize(BuildContext context) {
    final headerHeight = getHeaderHeight(context);
    // Logo尺寸约为头部高度的 40-45%
    return (headerHeight * 0.42).clamp(32.0, 56.0);
  }

  /// 获取头部标题字号
  /// 根据头部高度动态计算标题字号
  static double getHeaderTitleFontSize(BuildContext context) {
    final headerHeight = getHeaderHeight(context);
    // 标题字号约为头部高度的 20-22%
    return (headerHeight * 0.21).clamp(16.0, 28.0);
  }

  /// 获取头部副标题字号
  /// 根据头部高度动态计算副标题字号
  static double getHeaderSubtitleFontSize(BuildContext context) {
    final headerHeight = getHeaderHeight(context);
    // 副标题字号约为头部高度的 8-10%
    return (headerHeight * 0.09).clamp(9.0, 12.0);
  }

  /// 获取头部垂直内边距
  /// 根据头部高度动态计算垂直内边距
  static double getHeaderVerticalPadding(BuildContext context) {
    final headerHeight = getHeaderHeight(context);
    // 垂直内边距约为头部高度的 8-12%
    return (headerHeight * 0.1).clamp(4.0, 14.0);
  }

  /// 获取头部元素间距
  /// 根据头部高度动态计算元素间距
  static double getHeaderElementSpacing(BuildContext context) {
    final headerHeight = getHeaderHeight(context);
    // 元素间距约为头部高度的 4-6%
    return (headerHeight * 0.05).clamp(2.0, 8.0);
  }

  /// 获取卡片内边距
  static EdgeInsets getCardPadding(BuildContext context) {
    final height = getHeight(context);
    if (height > 900) {
      return const EdgeInsets.all(16);
    } else if (height > 700) {
      return const EdgeInsets.all(14);
    } else {
      return const EdgeInsets.all(12);
    }
  }

  /// 获取列表顶部间距
  static double getListTopPadding(BuildContext context) {
    final height = getHeight(context);
    // 添加适当的顶部间距，避免和头部贴太紧
    if (height > 900) {
      return 12;
    } else if (height > 800) {
      return 10;
    } else if (height > 700) {
      return 8;
    } else if (height > 600) {
      return 6;
    } else {
      return 4;
    }
  }

  /// 获取列表底部间距
  static double getListBottomPadding(BuildContext context) {
    final height = getHeight(context);
    // 添加适当的底部间距，避免和底部导航栏贴太紧
    if (height > 900) {
      return 12;
    } else if (height > 800) {
      return 10;
    } else if (height > 700) {
      return 8;
    } else if (height > 600) {
      return 6;
    } else {
      return 4;
    }
  }

  /// 获取网格列数
  static int getGridColumns(BuildContext context) {
    final width = getWidth(context);
    if (width >= desktopBreakpoint) {
      return 2; // 桌面端显示2列
    } else if (width >= tabletBreakpoint) {
      return 2; // 平板显示2列
    } else {
      return 1; // 移动端显示1列
    }
  }

  /// 获取字体缩放比例
  static double getFontScale(BuildContext context) {
    return getValue(
      context,
      mobile: 1.0,
      tablet: 1.1,
      desktop: 1.0,
    );
  }

  /// 获取底部导航栏高度
  static double getBottomNavHeight(BuildContext context) {
    return getValue(
      context,
      mobile: 72,
      tablet: 80,
      desktop: 0, // 桌面端使用侧边栏
    );
  }

  /// 是否显示底部导航栏
  static bool shouldShowBottomNav(BuildContext context) {
    return !isDesktop(context);
  }

  /// 是否使用侧边栏布局
  static bool shouldUseSideNav(BuildContext context) {
    return isDesktop(context);
  }

  /// 获取列表可用高度
  /// 计算去除头部、底部导航栏和SafeArea后的可用空间
  static double getAvailableListHeight(BuildContext context) {
    final screenHeight = getHeight(context);
    final headerHeight = getHeaderHeight(context);
    final bottomNavHeight = shouldShowBottomNav(context) ? getBottomNavHeight(context) : 0;
    final safeAreaTop = MediaQuery.of(context).padding.top;
    final safeAreaBottom = MediaQuery.of(context).padding.bottom;
    
    // 可用空间 = 屏幕高度 - 头部高度 - 底部导航栏高度 - SafeArea边距
    return screenHeight - headerHeight - bottomNavHeight - safeAreaTop - safeAreaBottom;
  }

  /// 计算自适应卡片高度
  /// 根据可用空间和卡片数量计算每个卡片的高度，确保列表充满可用空间
  /// 卡片高度约束在70px-120px之间
  static double getAdaptiveCardHeight(BuildContext context, int itemCount) {
    if (itemCount <= 0) return 100.0; // 默认高度
    
    final availableHeight = getAvailableListHeight(context);
    final cardSpacing = getCardSpacing(context);
    final listTopPadding = getListTopPadding(context);
    final listBottomPadding = getListBottomPadding(context);
    
    // 总间距 = (卡片数量 - 1) × 间距 + 顶部间距 + 底部间距
    final totalSpacing = cardSpacing * (itemCount - 1) + listTopPadding + listBottomPadding;
    
    // 单个卡片高度 = (可用空间 - 总间距) / 卡片数量
    final cardHeight = (availableHeight - totalSpacing) / itemCount;
    
    // 约束卡片高度在70px-120px之间
    return cardHeight.clamp(70.0, 120.0);
  }

  /// 获取卡片内部元素的缩放因子
  /// 基准卡片高度为100px，根据实际卡片高度计算缩放比例
  static double getCardScaleFactor(double cardHeight) {
    const baseCardHeight = 100.0;
    return cardHeight / baseCardHeight;
  }

  /// 获取自适应图标尺寸
  /// 根据卡片高度计算图标尺寸，约束在36px-52px之间
  static double getAdaptiveIconSize(double cardHeight) {
    final scaleFactor = getCardScaleFactor(cardHeight);
    return (48 * scaleFactor).clamp(36.0, 52.0);
  }

  /// 获取自适应标题字号
  /// 根据卡片高度计算标题字号，约束在14px-17px之间
  static double getAdaptiveTitleFontSize(double cardHeight) {
    final scaleFactor = getCardScaleFactor(cardHeight);
    return (16 * scaleFactor).clamp(14.0, 17.0);
  }

  /// 获取自适应描述字号
  /// 根据卡片高度计算描述字号，约束在11px-13px之间
  static double getAdaptiveDescFontSize(double cardHeight) {
    final scaleFactor = getCardScaleFactor(cardHeight);
    return (12 * scaleFactor).clamp(11.0, 13.0);
  }
}
