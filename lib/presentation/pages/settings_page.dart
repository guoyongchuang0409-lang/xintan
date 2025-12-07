import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_animations.dart';
import '../../core/utils/toast_utils.dart';
import '../../core/services/path_manager.dart';
import '../../core/services/sound_service.dart';
import '../../core/utils/advanced_screenshot_utils.dart';
import '../providers/settings_provider.dart';

import '../widgets/neon_card.dart';
import '../widgets/custom_dialog.dart';
import '../widgets/mystic_background.dart';
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late List<Animation<double>> _itemAnimations;
  String? _currentSavePath;
  final PathManager _pathManager = PathManager.instance;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
      ),
    );
    
    // 为每个组件创建交错动画
    _itemAnimations = List.generate(4, (index) {
      final start = 0.1 + (index * 0.15);
      final end = start + 0.4;
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            start.clamp(0.0, 1.0),
            end.clamp(0.0, 1.0),
            curve: Curves.easeOutCubic,
          ),
        ),
      );
    });
    
    _animationController.forward();
    
    // Load settings when page opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SettingsProvider>().loadSettings();
      _loadCurrentPath();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadCurrentPath() async {
    final path = await _pathManager.getCurrentPath();
    if (mounted) {
      setState(() {
        _currentSavePath = path;
      });
    }
  }

  Future<void> _selectSavePath() async {
    CustomDialog.showLoading(context, message: '选择保存路径...');
    
    final selectedPath = await AdvancedScreenshotUtils.selectSavePath();
    
    CustomDialog.dismissLoading();
    
    if (selectedPath != null) {
      setState(() {
        _currentSavePath = selectedPath;
      });
      
      if (mounted) {
        ToastUtils.showSuccess(context, '路径已设置');
      }
    }
  }
  
  Future<void> _resetSavePath() async {
    final confirmed = await CustomDialog.showConfirm(
      context,
      title: '重试置保存路径',
      content: '确定要重试置为默认路径吗？',
      confirmText: '重试置',
      cancelText: '取消',
      color: AppColors.neonOrange,
    );
    
    if (confirmed) {
      await _pathManager.clearCustomPath();
      await _loadCurrentPath();
      
      if (mounted) {
        ToastUtils.showSuccess(context, '已重试置为默认路径');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface.withOpacity(0.95),
        title: Text(
          '设置',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: MysticBackground(
        primaryColor: AppColors.neonPurple,
        secondaryColor: AppColors.neonPink.withOpacity(0.5),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Consumer<SettingsProvider>(
            builder: (context, provider, child) {
              return ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _buildAnimatedItem(0, _buildContactSection()),
                    const SizedBox(height: 20),
                    _buildAnimatedItem(1, _buildScreenshotSection(provider)),
                    const SizedBox(height: 20),
                    _buildAnimatedItem(2, _buildPathSection()),
                    const SizedBox(height: 20),
                    _buildAnimatedItem(3, _buildAboutSection()),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // 添加动画包装器
  Widget _buildAnimatedItem(int index, Widget child) {
    return FadeTransition(
      opacity: _itemAnimations[index],
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.3),
          end: Offset.zero,
        ).animate(_itemAnimations[index]),
        child: child,
      ),
    );
  }

  Widget _buildScreenshotSection(SettingsProvider provider) {
    return NeonCard(
      borderColor: AppColors.neonCyan,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.camera_alt_outlined,
                color: AppColors.neonCyan,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                '截图设置',
                style: TextStyle(
                  color: AppColors.neonCyan,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSwitchTile(
            title: '自己测动保存截图',
            subtitle: '生成报告时自己测动保存截图到相册',
            value: provider.autoSaveScreenshot,
            onChanged: (value) {
              SoundService.instance.playSwitch();
              provider.toggleAutoSaveScreenshot();
            },
            color: AppColors.neonCyan,
          ),
        ],
      ),
    );
  }

  Widget _buildPathSection() {
    final isDesktop = Platform.isWindows || Platform.isMacOS || Platform.isLinux;
    
    if (!isDesktop) {
      return const SizedBox.shrink();
    }
    
    return NeonCard(
      borderColor: AppColors.neonBlue,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.folder_outlined,
                color: AppColors.neonBlue,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                '保存路径',
                style: TextStyle(
                  color: AppColors.neonBlue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.neonBlue.withOpacity(0.3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '当前路径',
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _currentSavePath ?? '加载..',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 13,
                    fontFamily: 'monospace',
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildPathButton(
                  title: '选择路径',
                  icon: Icons.folder_open,
                  color: AppColors.neonGreen,
                  onTap: _selectSavePath,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildPathButton(
                  title: '重试置默认',
                  icon: Icons.restore,
                  color: AppColors.neonOrange,
                  onTap: _resetSavePath,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildPathButton({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          SoundService.instance.playClick();
          onTap();
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: color.withOpacity(0.5),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: color,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required Color color,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: color,
          activeTrackColor: color.withOpacity(0.3),
          inactiveThumbColor: AppColors.textMuted,
          inactiveTrackColor: AppColors.surface,
        ),
      ],
    );
  }
  Widget _buildContactSection() {
    return NeonCard(
      borderColor: AppColors.neonGreen,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.card_giftcard,
                color: AppColors.neonGreen,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                '福利专区',
                style: TextStyle(
                  color: AppColors.neonGreen,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.neonPink, AppColors.neonPurple],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  '免费',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // 福利提示
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.neonPurple.withOpacity(0.15),
                  AppColors.neonPink.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.neonPurple.withOpacity(0.3),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.auto_awesome,
                  color: AppColors.neonPink,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '🎁 添加好友，领取更多免费软件',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '定期更新 · 永久免费 · 专属福利',
                        style: TextStyle(
                          color: AppColors.neonPink,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildContactTile(
            icon: Icons.chat_bubble_outline,
            title: '微信',
            value: 'ntr1763561812',
            color: AppColors.neonGreen,
            hint: '点击复制，添加好友',
          ),
          const SizedBox(height: 12),
          _buildContactTile(
            icon: Icons.message_outlined,
            title: 'QQ',
            value: '1763561812',
            color: AppColors.neonBlue,
            hint: '点击复制，添加好友',
          ),
          const SizedBox(height: 16),
          // 底部提示
          Row(
            children: [
              Icon(
                Icons.verified_user_outlined,
                color: AppColors.textMuted,
                size: 14,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  '问题反馈 · 功能建议 · 更多福利，欢迎随时联系',
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactTile({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    String? hint,
  }) {
    return InkWell(
      onTap: () {
        SoundService.instance.playClick();
        _copyToClipboard(value, title);
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withOpacity(0.4)),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 12,
                        ),
                      ),
                      if (hint != null) ...[
                        const SizedBox(width: 8),
                        Text(
                          hint,
                          style: TextStyle(
                            color: color.withOpacity(0.7),
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.copy, color: color, size: 14),
                  const SizedBox(width: 4),
                  Text(
                    '复制',
                    style: TextStyle(
                      color: color,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _copyToClipboard(String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    ToastUtils.showSuccess(context, '$label已复制');
  }

  Widget _buildAboutSection() {
    return NeonCard(
      borderColor: AppColors.neonPurple,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: AppColors.neonPurple,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                '关于',
                style: TextStyle(
                  color: AppColors.neonPurple,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInfoTile(
            title: '版本',
            value: '1.0.0',
          ),
          const SizedBox(height: 12),
          _buildInfoTile(
            title: '数据存储',
            value: '仅本地存储',
          ),
          const SizedBox(height: 12),
          Text(
            '所有数据仅保存在您的设备本地，不会上传到任何服务器，确保您的隐私安全。',
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildInfoTile({
    required String title,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
