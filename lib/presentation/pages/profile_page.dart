import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme.dart';
import '../controllers.dart';

class ProfilePage extends GetView<AuthController> {
  const ProfilePage({Key? key}) : super(key: key);

  void _showChangePassword() {
    Get.dialog(
      Dialog(
        backgroundColor: AppTheme.backgroundLight,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'change_password'.tr,
                style: Get.theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'ensure_strong_password'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(height: 24),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'current_password'.tr,
                  prefixIcon: const Icon(Icons.lock_outline, size: 20),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'new_password'.tr,
                  prefixIcon: const Icon(Icons.vpn_key_outlined, size: 20),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'confirm_password'.tr,
                  prefixIcon: const Icon(Icons.check_circle_outline, size: 20),
                ),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      child: Text('cancel'.tr),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                        Get.snackbar(
                          'success'.tr,
                          'password_updated'.tr,
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppTheme.statusApproved,
                          colorText: Colors.white,
                        );
                      },
                      child: Text('update'.tr),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          color: AppTheme.primary,
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 18, color: Colors.grey),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final notifyController = Get.find<NotificationController>();
    final taskController = Get.find<TaskController>();
    final isDesktop = MediaQuery.of(context).size.width > 1000;

    return SingleChildScrollView(
      child: Column(
        children: [
          // Header Banner Section
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppTheme.primary, Color(0xFF0F172A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Opacity(
                  opacity: 0.1,
                  child: CustomPaint(painter: GridPainter()),
                ),
              ),
              Positioned(
                bottom: -60,
                left: 32,
                right: 32,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Obx(() {
                        final name =
                            controller.currentUser.value?.name ?? 'Admin User';
                        final initials = name
                            .split(' ')
                            .map((e) => e.isNotEmpty ? e[0] : '')
                            .take(2)
                            .join()
                            .toUpperCase();
                        return CircleAvatar(
                          radius: 60,
                          backgroundColor: AppTheme.secondary,
                          child: Text(
                            initials.isEmpty ? 'AU' : initials,
                            style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(width: 30),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            height: 48,
                          ), // Spacing for avatar overlap
                          Obx(
                            () => Text(
                              controller.currentUser.value?.name ??
                                  'Admin User',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                            ),
                          ),
                          Obx(
                            () => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '${controller.currentUser.value?.department ?? "Management"} • ${'super_admin'.tr}',
                                style: const TextStyle(
                                  color: AppTheme.primary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 80),

          // Content Area
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Column: Main info and Settings
                Expanded(
                  flex: isDesktop ? 3 : 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Overview Card
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: AppTheme.cardDecoration(context),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionHeader('overview'.tr),
                            const Divider(),
                            const SizedBox(height: 16),
                            _buildInfoItem(
                              Icons.email_outlined,
                              'email_address'.tr,
                              controller.currentUser.value?.email ??
                                  'admin@intersoft.com',
                            ),
                            _buildInfoItem(
                              Icons.phone_android_outlined,
                              'mobile_phone'.tr,
                              '+1 (555) 000-1234',
                            ),
                            _buildInfoItem(
                              Icons.location_on_outlined,
                              'office_location'.tr,
                              'Main Headquarters - Doha, Qatar',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Settings & Preferences
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: AppTheme.cardDecoration(context),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionHeader('settings_preferences'.tr),
                            const Divider(),
                            const SizedBox(height: 8),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(Icons.language_outlined),
                              title: Text('language'.tr),
                              subtitle: Text('choose_preferred_language'.tr),
                              trailing: DropdownButton<String>(
                                value: Get.locale?.languageCode == 'ar'
                                    ? 'Arabic'
                                    : 'English',
                                underline: const SizedBox(),
                                items: ['English', 'Arabic']
                                    .map(
                                      (s) => DropdownMenuItem(
                                        value: s,
                                        child: Text(s),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (val) {
                                  if (val == 'Arabic') {
                                    Get.updateLocale(const Locale('ar', 'QA'));
                                  } else {
                                    Get.updateLocale(const Locale('en', 'US'));
                                  }
                                },
                              ),
                            ),
                            StatefulBuilder(
                              builder: (ctx, setState) {
                                bool isDark =
                                    Theme.of(context).brightness ==
                                    Brightness.dark;
                                return ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: const Icon(Icons.dark_mode_outlined),
                                  title: Text('dark_mode'.tr),
                                  subtitle: Text('adjust_appearance'.tr),
                                  trailing: Switch(
                                    value: isDark,
                                    activeColor: AppTheme.secondary,
                                    onChanged: (val) {
                                      Get.changeThemeMode(
                                        val ? ThemeMode.dark : ThemeMode.light,
                                      );
                                      setState(() {});
                                    },
                                  ),
                                );
                              },
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(Icons.security_outlined),
                              title: Text('change_password'.tr),
                              subtitle: Text('keep_account_secure'.tr),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: _showChangePassword,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Logout Area
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () => controller.logout(),
                          icon: const Icon(Icons.logout),
                          label: Text('sign_out_of_account'.tr),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppTheme.statusRejected,
                            side: const BorderSide(
                              color: AppTheme.statusRejected,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      if (!isDesktop) ...[
                        const SizedBox(height: 24),
                        _buildPermissionsCard(),
                        const SizedBox(height: 24),
                        _buildStatsGrid(
                          context,
                          taskController,
                          notifyController,
                        ),
                        const SizedBox(height: 24),
                        _buildRecentActivityCard(notifyController),
                      ],
                      const SizedBox(height: 40),
                    ],
                  ),
                ),

                if (isDesktop) const SizedBox(width: 32),

                // Right Column
                if (isDesktop)
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildPermissionsCard(),
                        const SizedBox(height: 24),
                        _buildStatsGrid(
                          context,
                          taskController,
                          notifyController,
                        ),
                        const SizedBox(height: 24),
                        _buildRecentActivityCard(notifyController),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.primary.withOpacity(0.1)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: AppTheme.primary,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildStatBox(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: AppTheme.cardDecoration(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppTheme.primary, size: 28),
            const SizedBox(height: 12),
            Text(
              value,
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              label,
              style: const TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityTile(dynamic notification) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: AppTheme.primary,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                notification.message,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                notification.time,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPermissionsCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: AppTheme.cardDecoration(Get.context!),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('system_permissions'.tr),
          const Divider(),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              'View Dashboard',
              'Manage Users',
              'Create Tickets',
              'Approve Requests',
              'System Logs',
              'Financial Views',
            ].map((p) => _buildPermissionTag(p)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(
    BuildContext context,
    TaskController tasks,
    NotificationController notify,
  ) {
    return Row(
      children: [
        Obx(
          () => _buildStatBox(
            context,
            'total_tasks'.tr,
            tasks.tasks.length.toString(),
            Icons.assignment_turned_in_outlined,
          ),
        ),
        const SizedBox(width: 16),
        Obx(
          () => _buildStatBox(
            context,
            'notifications'.tr,
            notify.notifications.length.toString(),
            Icons.notifications_none_outlined,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentActivityCard(NotificationController notify) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: AppTheme.cardDecoration(Get.context!),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSectionHeader('recent_activity'.tr),
              TextButton(onPressed: () {}, child: Text('view_all'.tr)),
            ],
          ),
          const Divider(),
          Obx(
            () => notify.notifications.isEmpty
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 32.0),
                    child: Center(
                      child: Text(
                        'No recent activity',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: notify.notifications.length.clamp(0, 5),
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final n = notify.notifications[index];
                      return _buildActivityTile(n);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..strokeWidth = 1.0;

    const spacing = 30.0;
    for (double i = 0; i < size.width; i += spacing) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += spacing) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
