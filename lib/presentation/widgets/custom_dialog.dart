import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/services/sound_service.dart';
class CustomDialog {
  static OverlayEntry? _loadingEntry;
  static void showLoading(
    BuildContext context, {
    String? message,
    Color? color,
  }) {
    dismissLoading();
    
    final overlay = Overlay.of(context);
    
    _loadingEntry = OverlayEntry(
      builder: (context) => _LoadingDialog(
        message: message ?? '处理..',
        color: color ?? AppColors.neonCyan,
      ),
    );
    
    overlay.insert(_loadingEntry!);
  }
  static void dismissLoading() {
    _loadingEntry?.remove();
    _loadingEntry = null;
  }
  static Future<bool> showConfirm(
    BuildContext context, {
    required String title,
    required String content,
    String? confirmText,
    String? cancelText,
    Color? color,
  }) async {
    final result = await showGeneralDialog<bool>(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return _ConfirmDialog(
          title: title,
          content: content,
          confirmText: confirmText ?? '确定',
          cancelText: cancelText ?? '取消',
          color: color ?? AppColors.neonCyan,
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutBack,
            ),
            child: child,
          ),
        );
      },
    );
    
    return result ?? false;
  }
  static Future<void> showInfo(
    BuildContext context, {
    required String title,
    required String content,
    String? buttonText,
    Color? color,
  }) async {
    await showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return _InfoDialog(
          title: title,
          content: content,
          buttonText: buttonText ?? '知道了了',
          color: color ?? AppColors.neonCyan,
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutBack,
            ),
            child: child,
          ),
        );
      },
    );
  }
}
class _LoadingDialog extends StatefulWidget {
  final String message;
  final Color color;
  
  const _LoadingDialog({
    required this.message,
    required this.color,
  });
  
  @override
  State<_LoadingDialog> createState() => _LoadingDialogState();
}

class _LoadingDialogState extends State<_LoadingDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotation;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    
    _rotation = Tween<double>(
      begin: 0,
      end: 2 * 3.14159,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Material(
        color: Colors.black54,
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: widget.color.withOpacity(0.3),
                  blurRadius: 30,
                  spreadRadius: 5,
                ),
              ],
              border: Border.all(
                color: widget.color.withOpacity(0.5),
                width: 2,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedBuilder(
                  animation: _rotation,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _rotation.value,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.transparent,
                            width: 3,
                          ),
                          gradient: SweepGradient(
                            colors: [
                              widget.color.withOpacity(0),
                              widget.color.withOpacity(0.5),
                              widget.color,
                              widget.color.withOpacity(0.5),
                              widget.color.withOpacity(0),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
                Text(
                  widget.message,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                    shadows: [
                      Shadow(
                        color: widget.color.withOpacity(0.5),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class _ConfirmDialog extends StatelessWidget {
  final String title;
  final String content;
  final String confirmText;
  final String cancelText;
  final Color color;
  
  const _ConfirmDialog({
    required this.title,
    required this.content,
    required this.confirmText,
    required this.cancelText,
    required this.color,
  });
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(32),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 30,
              spreadRadius: 5,
            ),
          ],
          border: Border.all(
            color: color.withOpacity(0.5),
            width: 2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: color.withOpacity(0.5),
                    blurRadius: 10,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              content,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _DialogButton(
                    text: cancelText,
                    color: Colors.grey,
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _DialogButton(
                    text: confirmText,
                    color: color,
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
class _InfoDialog extends StatelessWidget {
  final String title;
  final String content;
  final String buttonText;
  final Color color;
  
  const _InfoDialog({
    required this.title,
    required this.content,
    required this.buttonText,
    required this.color,
  });
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(32),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 30,
              spreadRadius: 5,
            ),
          ],
          border: Border.all(
            color: color.withOpacity(0.5),
            width: 2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: color.withOpacity(0.5),
                    blurRadius: 10,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              content,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: _DialogButton(
                text: buttonText,
                color: color,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class _DialogButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;
  
  const _DialogButton({
    required this.text,
    required this.color,
    required this.onPressed,
  });
  
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          SoundService.instance.playClick();
          onPressed();
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [
                color.withOpacity(0.8),
                color,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
