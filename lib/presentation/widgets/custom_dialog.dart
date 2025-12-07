import 'dart:math';
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
      builder: (context) => _MysticLoadingDialog(
        message: message ?? '处理中...',
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
      barrierColor: Colors.black.withOpacity(0.7),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) {
        return _MysticConfirmDialog(
          title: title,
          content: content,
          confirmText: confirmText ?? '确定',
          cancelText: cancelText ?? '取消',
          color: color ?? AppColors.neonCyan,
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          ),
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: animation,
              curve: Curves.elasticOut,
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
      barrierColor: Colors.black.withOpacity(0.7),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) {
        return _MysticInfoDialog(
          title: title,
          content: content,
          buttonText: buttonText ?? '知道了',
          color: color ?? AppColors.neonCyan,
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          ),
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: animation,
              curve: Curves.elasticOut,
            ),
            child: child,
          ),
        );
      },
    );
  }
}

// 玄幻加载弹窗
class _MysticLoadingDialog extends StatefulWidget {
  final String message;
  final Color color;
  
  const _MysticLoadingDialog({
    required this.message,
    required this.color,
  });
  
  @override
  State<_MysticLoadingDialog> createState() => _MysticLoadingDialogState();
}

class _MysticLoadingDialogState extends State<_MysticLoadingDialog>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _pulseController;
  late AnimationController _particleController;
  late Animation<double> _pulseAnimation;
  
  final List<_MysticParticle> _particles = [];
  final Random _random = Random();
  
  @override
  void initState() {
    super.initState();
    
    _rotationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
    
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    
    _particleController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    
    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
    
    _generateParticles();
  }
  
  void _generateParticles() {
    for (int i = 0; i < 20; i++) {
      _particles.add(_MysticParticle(
        angle: _random.nextDouble() * 2 * pi,
        radius: 40 + _random.nextDouble() * 30,
        speed: 0.3 + _random.nextDouble() * 0.7,
        size: 2 + _random.nextDouble() * 3,
        delay: _random.nextDouble(),
      ));
    }
  }
  
  @override
  void dispose() {
    _rotationController.dispose();
    _pulseController.dispose();
    _particleController.dispose();
    super.dispose();
  }
  
  Color get _secondaryColor {
    final hsl = HSLColor.fromColor(widget.color);
    return hsl.withHue((hsl.hue + 40) % 360).toColor();
  }
  
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Material(
        color: Colors.black.withOpacity(0.7),
        child: Center(
          child: AnimatedBuilder(
            animation: Listenable.merge([_rotationController, _pulseController, _particleController]),
            builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  // 外层光晕
                  Transform.scale(
                    scale: _pulseAnimation.value,
                    child: Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: widget.color.withOpacity(0.3),
                            blurRadius: 60,
                            spreadRadius: 20,
                          ),
                          BoxShadow(
                            color: _secondaryColor.withOpacity(0.2),
                            blurRadius: 80,
                            spreadRadius: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // 粒子效果
                  ..._buildParticles(),
                  // 主体容器
                  _buildMainContainer(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
  
  List<Widget> _buildParticles() {
    return _particles.map((particle) {
      final progress = (_particleController.value + particle.delay) % 1.0;
      final currentAngle = particle.angle + _rotationController.value * 2 * pi * particle.speed;
      final x = cos(currentAngle) * particle.radius;
      final y = sin(currentAngle) * particle.radius;
      final opacity = 0.3 + sin(progress * pi) * 0.7;
      
      return Positioned(
        left: 90 + x - particle.size / 2,
        top: 90 + y - particle.size / 2,
        child: Container(
          width: particle.size,
          height: particle.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.color.withOpacity(opacity),
            boxShadow: [
              BoxShadow(
                color: widget.color.withOpacity(opacity * 0.5),
                blurRadius: particle.size * 3,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
      );
    }).toList();
  }
  
  Widget _buildMainContainer() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            AppColors.cardBackground.withOpacity(0.95),
            AppColors.cardBackground.withOpacity(0.85),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: widget.color.withOpacity(0.5),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: widget.color.withOpacity(0.4),
            blurRadius: 30,
            spreadRadius: 5,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildMysticSpinner(),
          const SizedBox(height: 24),
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [
                widget.color,
                _secondaryColor,
                widget.color,
              ],
            ).createShader(bounds),
            child: Text(
              widget.message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildMysticSpinner() {
    return SizedBox(
      width: 70,
      height: 70,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 外圈
          Transform.rotate(
            angle: _rotationController.value * 2 * pi,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: SweepGradient(
                  colors: [
                    widget.color.withOpacity(0),
                    widget.color.withOpacity(0.3),
                    widget.color,
                    widget.color.withOpacity(0.3),
                    widget.color.withOpacity(0),
                  ],
                ),
              ),
            ),
          ),
          // 内圈（反向旋转）
          Transform.rotate(
            angle: -_rotationController.value * 2 * pi * 1.5,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: SweepGradient(
                  colors: [
                    _secondaryColor.withOpacity(0),
                    _secondaryColor.withOpacity(0.5),
                    _secondaryColor,
                    _secondaryColor.withOpacity(0.5),
                    _secondaryColor.withOpacity(0),
                  ],
                ),
              ),
            ),
          ),
          // 中心点
          Transform.scale(
            scale: _pulseAnimation.value,
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.color,
                boxShadow: [
                  BoxShadow(
                    color: widget.color.withOpacity(0.8),
                    blurRadius: 15,
                    spreadRadius: 3,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 玄幻确认弹窗
class _MysticConfirmDialog extends StatefulWidget {
  final String title;
  final String content;
  final String confirmText;
  final String cancelText;
  final Color color;
  
  const _MysticConfirmDialog({
    required this.title,
    required this.content,
    required this.confirmText,
    required this.cancelText,
    required this.color,
  });
  
  @override
  State<_MysticConfirmDialog> createState() => _MysticConfirmDialogState();
}

class _MysticConfirmDialogState extends State<_MysticConfirmDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _glowController;
  late Animation<double> _glowAnimation;
  
  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);
    
    _glowAnimation = Tween<double>(
      begin: 0.3,
      end: 0.7,
    ).animate(CurvedAnimation(
      parent: _glowController,
      curve: Curves.easeInOut,
    ));
  }
  
  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }
  
  Color get _secondaryColor {
    final hsl = HSLColor.fromColor(widget.color);
    return hsl.withHue((hsl.hue + 40) % 360).toColor();
  }
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _glowAnimation,
        builder: (context, child) {
          return Container(
            margin: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: widget.color.withOpacity(_glowAnimation.value),
                  blurRadius: 40,
                  spreadRadius: 5,
                ),
                BoxShadow(
                  color: _secondaryColor.withOpacity(_glowAnimation.value * 0.5),
                  blurRadius: 60,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.cardBackground.withOpacity(0.95),
                      AppColors.cardBackground.withOpacity(0.85),
                      AppColors.cardBackground.withOpacity(0.9),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: widget.color.withOpacity(0.6),
                    width: 2,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitle(),
                    const SizedBox(height: 16),
                    _buildContent(),
                    const SizedBox(height: 28),
                    _buildButtons(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTitle() {
    return Row(
      children: [
        Container(
          width: 4,
          height: 24,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [widget.color, _secondaryColor],
            ),
            borderRadius: BorderRadius.circular(2),
            boxShadow: [
              BoxShadow(
                color: widget.color.withOpacity(0.5),
                blurRadius: 8,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [widget.color, _secondaryColor],
            ).createShader(bounds),
            child: Text(
              widget.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildContent() {
    return Text(
      widget.content,
      style: TextStyle(
        color: Colors.white.withOpacity(0.8),
        fontSize: 14,
        height: 1.6,
        letterSpacing: 0.3,
      ),
    );
  }

  Widget _buildButtons() {
    return Row(
      children: [
        Expanded(
          child: _MysticButton(
            text: widget.cancelText,
            color: Colors.grey.shade600,
            isOutlined: true,
            onPressed: () => Navigator.of(context).pop(false),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _MysticButton(
            text: widget.confirmText,
            color: widget.color,
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ),
      ],
    );
  }
}

// 玄幻信息弹窗
class _MysticInfoDialog extends StatefulWidget {
  final String title;
  final String content;
  final String buttonText;
  final Color color;
  
  const _MysticInfoDialog({
    required this.title,
    required this.content,
    required this.buttonText,
    required this.color,
  });
  
  @override
  State<_MysticInfoDialog> createState() => _MysticInfoDialogState();
}

class _MysticInfoDialogState extends State<_MysticInfoDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _glowController;
  late Animation<double> _glowAnimation;
  
  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);
    
    _glowAnimation = Tween<double>(
      begin: 0.3,
      end: 0.7,
    ).animate(CurvedAnimation(
      parent: _glowController,
      curve: Curves.easeInOut,
    ));
  }
  
  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }
  
  Color get _secondaryColor {
    final hsl = HSLColor.fromColor(widget.color);
    return hsl.withHue((hsl.hue + 40) % 360).toColor();
  }
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _glowAnimation,
        builder: (context, child) {
          return Container(
            margin: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: widget.color.withOpacity(_glowAnimation.value),
                  blurRadius: 40,
                  spreadRadius: 5,
                ),
                BoxShadow(
                  color: _secondaryColor.withOpacity(_glowAnimation.value * 0.5),
                  blurRadius: 60,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.cardBackground.withOpacity(0.95),
                      AppColors.cardBackground.withOpacity(0.85),
                      AppColors.cardBackground.withOpacity(0.9),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: widget.color.withOpacity(0.6),
                    width: 2,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitle(),
                    const SizedBox(height: 16),
                    _buildContent(),
                    const SizedBox(height: 28),
                    SizedBox(
                      width: double.infinity,
                      child: _MysticButton(
                        text: widget.buttonText,
                        color: widget.color,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  
  Widget _buildTitle() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [widget.color, _secondaryColor],
            ),
            boxShadow: [
              BoxShadow(
                color: widget.color.withOpacity(0.5),
                blurRadius: 12,
                spreadRadius: 2,
              ),
            ],
          ),
          child: const Icon(
            Icons.info_outline,
            color: Colors.white,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [widget.color, _secondaryColor],
            ).createShader(bounds),
            child: Text(
              widget.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildContent() {
    return Text(
      widget.content,
      style: TextStyle(
        color: Colors.white.withOpacity(0.8),
        fontSize: 14,
        height: 1.6,
        letterSpacing: 0.3,
      ),
    );
  }
}

// 玄幻按钮
class _MysticButton extends StatefulWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;
  final bool isOutlined;
  
  const _MysticButton({
    required this.text,
    required this.color,
    required this.onPressed,
    this.isOutlined = false,
  });
  
  @override
  State<_MysticButton> createState() => _MysticButtonState();
}

class _MysticButtonState extends State<_MysticButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;
  
  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeInOut,
    ));
  }
  
  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }
  
  Color get _secondaryColor {
    final hsl = HSLColor.fromColor(widget.color);
    return hsl.withHue((hsl.hue + 30) % 360).toColor();
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => _isPressed = true);
        _hoverController.forward();
      },
      onTapUp: (_) {
        setState(() => _isPressed = false);
        _hoverController.reverse();
      },
      onTapCancel: () {
        setState(() => _isPressed = false);
        _hoverController.reverse();
      },
      onTap: () {
        SoundService.instance.playClick();
        widget.onPressed();
      },
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 14,
              ),
              decoration: BoxDecoration(
                gradient: widget.isOutlined ? null : LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    widget.color,
                    _secondaryColor,
                    widget.color,
                  ],
                ),
                color: widget.isOutlined ? Colors.transparent : null,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: widget.isOutlined 
                      ? widget.color.withOpacity(0.5) 
                      : Colors.white.withOpacity(0.2),
                  width: 1.5,
                ),
                boxShadow: widget.isOutlined ? null : [
                  BoxShadow(
                    color: widget.color.withOpacity(_isPressed ? 0.6 : 0.4),
                    blurRadius: _isPressed ? 20 : 15,
                    spreadRadius: _isPressed ? 2 : 0,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  widget.text,
                  style: TextStyle(
                    color: widget.isOutlined 
                        ? widget.color 
                        : Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                    shadows: widget.isOutlined ? null : [
                      const Shadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// 粒子类
class _MysticParticle {
  final double angle;
  final double radius;
  final double speed;
  final double size;
  final double delay;
  
  _MysticParticle({
    required this.angle,
    required this.radius,
    required this.speed,
    required this.size,
    required this.delay,
  });
}
