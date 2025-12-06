import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
class ToastUtils {
  static OverlayEntry? _currentToast;
  static void showToast(
    BuildContext context,
    String message, {
    Color? backgroundColor,
    Duration duration = const Duration(seconds: 2),
    IconData? icon,
  }) {
    // 移除之前的Toast
    _currentToast?.remove();
    _currentToast = null;
    
    final overlay = Overlay.of(context);
    
    // 创建Toast Widget
    _currentToast = OverlayEntry(
      builder: (context) => _ToastWidget(
        message: message,
        backgroundColor: backgroundColor ?? AppColors.neonCyan,
        icon: icon,
      ),
    );
    
    // 插入Overlay
    overlay.insert(_currentToast!);
    
    // 设置自己测动消失
    Future.delayed(duration, () {
      _currentToast?.remove();
      _currentToast = null;
    });
  }
  static void showSuccess(BuildContext context, String message) {
    showToast(
      context,
      message,
      backgroundColor: AppColors.neonGreen,
      icon: Icons.check_circle_outline,
    );
  }
  static void showError(BuildContext context, String message) {
    showToast(
      context,
      message,
      backgroundColor: AppColors.error,
      icon: Icons.error_outline,
    );
  }
  static void showInfo(BuildContext context, String message) {
    showToast(
      context,
      message,
      backgroundColor: AppColors.neonCyan,
      icon: Icons.info_outline,
    );
  }
  static void showWarning(BuildContext context, String message) {
    showToast(
      context,
      message,
      backgroundColor: AppColors.neonOrange,
      icon: Icons.warning_amber_outlined,
    );
  }
}
class _ToastWidget extends StatefulWidget {
  final String message;
  final Color backgroundColor;
  final IconData? icon;
  
  const _ToastWidget({
    required this.message,
    required this.backgroundColor,
    this.icon,
  });
  
  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  
  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));
    
    _controller.forward();
    
    // 自己测动淡出
    Future.delayed(const Duration(milliseconds: 1700), () {
      if (mounted) {
        _controller.reverse();
      }
    });
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _fadeAnimation.value,
              child: Center(
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: widget.backgroundColor.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: widget.backgroundColor.withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: Border.all(
                        color: widget.backgroundColor,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget.icon != null) ...[
                          Icon(
                            widget.icon,
                            color: Colors.white,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                        ],
                        Flexible(
                          child: Text(
                            widget.message,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
void showToast(BuildContext context, String message, [Color? color]) {
  ToastUtils.showToast(context, message, backgroundColor: color);
}
