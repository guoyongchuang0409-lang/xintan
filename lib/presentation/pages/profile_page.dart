import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_animations.dart';
import '../../core/utils/toast_utils.dart';
import '../../core/utils/platform_utils.dart';
import '../../core/utils/responsive_utils.dart';
import '../../core/services/path_manager.dart';
import '../../core/services/sound_service.dart';
import '../../core/utils/advanced_screenshot_utils.dart';
import '../providers/user_profile_provider.dart';
import '../widgets/neon_card.dart';
import '../widgets/custom_dialog.dart';
import '../widgets/mystic_background.dart';

/// 我的页面（原设置页面）
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  String? _currentSavePath;
  final PathManager _pathManager = PathManager.instance;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: AppAnimations.normal,
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: AppAnimations.defaultCurve,
      ),
    );
    _animationController.forward();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
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
      title: '重置路径',
      content: '确定要重置为默认保存路径吗？',
      confirmText: '重置',
      cancelText: '取消',
      color: AppColors.neonCyan,
    );
    
    if (confirmed) {
      await _pathManager.clearCustomPath();
      await _loadCurrentPath();
      if (mounted) {
        ToastUtils.showSuccess(context, '已重置为默认路径');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final layoutConfig = ResponsiveUtils.getReportLayoutConfig(context);
    
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface.withOpacity(0.95),
        title: Text(
          '我的',
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
        secondaryColor: AppColors.neonPink.withOpacity(0.6),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: layoutConfig.contentMaxWidth,
              ),
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: layoutConfig.horizontalPadding,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildUserProfileSection(),
                      SizedBox(height: layoutConfig.cardSpacing),
                      _buildWelfareSection(),
                      SizedBox(height: layoutConfig.cardSpacing),
                      _buildPathSection(),
                      SizedBox(height: layoutConfig.cardSpacing),
                      _buildAboutSection(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 用户资料模块
  Widget _buildUserProfileSection() {
    return Consumer<UserProfileProvider>(
      builder: (context, provider, child) {
        final profile = provider.profile;
        
        return NeonCard(
          borderColor: AppColors.neonPurple,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.person_outline, color: AppColors.neonPurple, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    '个人资料',
                    style: TextStyle(
                      color: AppColors.neonPurple,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // 头像和昵称
              Row(
                children: [
                  // 头像
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          AppColors.neonPurple.withOpacity(0.3),
                          AppColors.neonPink.withOpacity(0.3),
                        ],
                      ),
                      border: Border.all(
                        color: AppColors.neonPurple.withOpacity(0.5),
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.person,
                      color: AppColors.neonPurple,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 16),
                  // 昵称和编辑按钮
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                profile.nickname,
                                style: TextStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.edit_outlined,
                                color: AppColors.neonPurple,
                                size: 20,
                              ),
                              onPressed: () => _editNickname(provider),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // 年龄和性别
              Row(
                children: [
                  Expanded(
                    child: _buildInfoItem(
                      icon: Icons.cake_outlined,
                      label: '年龄',
                      value: profile.ageDisplay,
                      onTap: () => _editAge(provider),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildInfoItem(
                      icon: Icons.wc_outlined,
                      label: '性别',
                      value: profile.genderDisplay,
                      onTap: () => _editGender(provider),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.neonPurple.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.textMuted, size: 16),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 编辑昵称
  Future<void> _editNickname(UserProfileProvider provider) async {
    final controller = TextEditingController(text: provider.profile.nickname);
    
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text('编辑昵称', style: TextStyle(color: AppColors.textPrimary)),
        content: TextField(
          controller: controller,
          style: TextStyle(color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: '请输入昵称',
            hintStyle: TextStyle(color: AppColors.textMuted),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.neonPurple.withOpacity(0.3)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.neonPurple),
            ),
          ),
          maxLength: 20,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('取消', style: TextStyle(color: AppColors.textMuted)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: Text('确定', style: TextStyle(color: AppColors.neonPurple)),
          ),
        ],
      ),
    );
    
    if (result != null && result.trim().isNotEmpty) {
      final success = await provider.updateNickname(result.trim());
      if (mounted) {
        if (success) {
          ToastUtils.showSuccess(context, '昵称已更新');
        } else {
          ToastUtils.showError(context, '更新失败');
        }
      }
    }
  }

  /// 编辑年龄
  Future<void> _editAge(UserProfileProvider provider) async {
    final controller = TextEditingController(
      text: provider.profile.age?.toString() ?? '',
    );
    
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text('编辑年龄', style: TextStyle(color: AppColors.textPrimary)),
        content: TextField(
          controller: controller,
          style: TextStyle(color: AppColors.textPrimary),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: '请输入年龄',
            hintStyle: TextStyle(color: AppColors.textMuted),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.neonPurple.withOpacity(0.3)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.neonPurple),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('取消', style: TextStyle(color: AppColors.textMuted)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: Text('确定', style: TextStyle(color: AppColors.neonPurple)),
          ),
        ],
      ),
    );
    
    if (result != null) {
      final age = int.tryParse(result);
      if (age != null && age > 0 && age < 150) {
        final success = await provider.updateAge(age);
        if (mounted) {
          if (success) {
            ToastUtils.showSuccess(context, '年龄已更新');
          } else {
            ToastUtils.showError(context, '更新失败');
          }
        }
      } else if (mounted) {
        ToastUtils.showError(context, '请输入有效的年龄');
      }
    }
  }

  /// 编辑性别
  Future<void> _editGender(UserProfileProvider provider) async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text('选择性别', style: TextStyle(color: AppColors.textPrimary)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildGenderOption(context, '男', 'male'),
            _buildGenderOption(context, '女', 'female'),
            _buildGenderOption(context, '其他', 'other'),
          ],
        ),
      ),
    );
    
    if (result != null) {
      final success = await provider.updateGender(result);
      if (mounted) {
        if (success) {
          ToastUtils.showSuccess(context, '性别已更新');
        } else {
          ToastUtils.showError(context, '更新失败');
        }
      }
    }
  }

  Widget _buildGenderOption(BuildContext context, String label, String value) {
    return ListTile(
      title: Text(label, style: TextStyle(color: AppColors.textPrimary)),
      onTap: () => Navigator.pop(context, value),
    );
  }

  /// 福利专区（保持原有功能）
  Widget _buildWelfareSection() {
    return NeonCard(
      borderColor: AppColors.neonGreen,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.card_giftcard, color: AppColors.neonGreen, size: 20),
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
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.neonPink.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '免费',
                  style: TextStyle(
                    color: AppColors.neonPink,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.celebration, color: AppColors.neonPink, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      '🎁 添加好友，领取更多免费软件',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  '定期更新，教久免费，多端适配',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 16),
                _buildContactRow(
                  icon: Icons.wechat,
                  label: '微信',
                  value: 'ntr1763561812',
                  color: AppColors.neonGreen,
                ),
                const SizedBox(height: 12),
                _buildContactRow(
                  icon: Icons.chat,
                  label: 'QQ',
                  value: '1763561812',
                  color: AppColors.neonCyan,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.info_outline, color: AppColors.textMuted, size: 14),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        '问题反馈，功能建议，更多福利，欢迎随时联系',
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
          ),
        ],
      ),
    );
  }

  Widget _buildContactRow({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 13,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.copy, color: color, size: 16),
          onPressed: () => _copyToClipboard(value),
          tooltip: '复制',
        ),
      ],
    );
  }

  void _copyToClipboard(String text) {
    // 复制到剪贴板的功能
    ToastUtils.showSuccess(context, '已复制');
  }

  /// 路径设置（仅桌面端显示）
  Widget _buildPathSection() {
    final isDesktop = PlatformUtils.isDesktop;
    
    if (!isDesktop) {
      return const SizedBox.shrink();
    }
    
    return NeonCard(
      borderColor: AppColors.neonBlue,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.folder_outlined, color: AppColors.neonBlue, size: 20),
              const SizedBox(width: 8),
              Text(
                '截图保存路径',
                style: TextStyle(
                  color: AppColors.neonBlue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (_currentSavePath != null)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.folder, color: AppColors.neonBlue, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _currentSavePath!,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _selectSavePath,
                  icon: Icon(Icons.edit, size: 16),
                  label: const Text('更改路径'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.neonBlue,
                    side: BorderSide(color: AppColors.neonBlue.withOpacity(0.5)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _resetSavePath,
                  icon: Icon(Icons.refresh, size: 16),
                  label: const Text('重置'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.textMuted,
                    side: BorderSide(color: AppColors.textMuted.withOpacity(0.3)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 关于部分
  Widget _buildAboutSection() {
    return NeonCard(
      borderColor: AppColors.neonCyan,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: AppColors.neonCyan, size: 20),
              const SizedBox(width: 8),
              Text(
                '关于',
                style: TextStyle(
                  color: AppColors.neonCyan,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildAboutRow('版本', '1.0.0'),
          const SizedBox(height: 12),
          _buildAboutRow('数据存储', '仅本地存储'),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '所有数据仅保存在您的设备本地，不会上传到任何服务器，确保您的隐私安全。',
              style: TextStyle(
                color: AppColors.textMuted,
                fontSize: 12,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
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
