import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_animations.dart';
import '../../core/utils/toast_utils.dart';
import '../../core/services/path_manager.dart';
import '../../core/services/sound_service.dart';
import '../../core/utils/advanced_screenshot_utils.dart';
import '../providers/settings_provider.dart';
import '../providers/report_provider.dart';
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

  void _confirmClearAllData() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: AppColors.error.withOpacity(0.3),
          ),
        ),
        title: Row(
          children: [
            Icon(Icons.warning_amber, color: AppColors.error),
            const SizedBox(width: 8),
            const Text(
              '确认清除',
              style: TextStyle(color: AppColors.textPrimary),
            ),
          ],
        ),
        content: const Text(
          '此操作将删除所有测试记录，且无法恢复确定要继续吗？',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () {
              SoundService.instance.playClick();
              Navigator.pop(context);
            },
            child: Text(
              '取消',
              style: TextStyle(color: AppColors.textMuted),
            ),
          ),
          TextButton(
            onPressed: () {
              SoundService.instance.playClick();
              Navigator.pop(context);
              _clearAllData();
            },
            child: Text(
              '清除所有数据',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }


  Future<void> _clearAllData() async {
    final reportProvider = context.read<ReportProvider>();
    final success = await reportProvider.deleteAllReports();
    
    if (mounted) {
      if (success) {
        ToastUtils.showSuccess(context, '所有数据已清除');
      } else {
        ToastUtils.showError(context, '清除数据失败，请重试试');
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
                    _buildAnimatedItem(0, _buildScreenshotSection(provider)),
                    const SizedBox(height: 20),
                    _buildAnimatedItem(1, _buildPathSection()),
                    const SizedBox(height: 20),
                    _buildAnimatedItem(2, _buildDataSection()),
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
  Widget _buildDataSection() {
    return NeonCard(
      borderColor: AppColors.error,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.storage_outlined,
                color: AppColors.error,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                '数据管理',
                style: TextStyle(
                  color: AppColors.error,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildActionTile(
            title: '清除所有数据',
            subtitle: '删除所有测试记录，此操作不可恢复',
            icon: Icons.delete_forever_outlined,
            color: AppColors.error,
            onTap: _confirmClearAllData,
          ),
        ],
      ),
    );
  }
  Widget _buildActionTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: () {
        SoundService.instance.playClick();
        onTap();
      },
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: color,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
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
                  const SizedBox(height: 2),
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
            Icon(
              Icons.chevron_right,
              color: AppColors.textMuted,
            ),
          ],
        ),
      ),
    );
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
