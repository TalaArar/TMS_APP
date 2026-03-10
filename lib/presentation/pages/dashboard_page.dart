import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme.dart';
import '../controllers.dart';

class DashboardPage extends GetView<MainController> {
  const DashboardPage({Key? key}) : super(key: key);

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    bool isSmall = MediaQuery.of(context).size.width < 600;
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(isSmall ? 16 : 24),
        margin: const EdgeInsets.all(6),
        decoration: AppTheme.cardDecoration(context),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(isSmall ? 10 : 16),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: isSmall ? 24 : 32, color: color),
            ),
            SizedBox(width: isSmall ? 12 : 16),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontSize: isSmall ? 11 : 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontSize: isSmall ? 20 : 28,
                      fontWeight: FontWeight.bold,
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

  Widget _buildFakeChart(BuildContext context, String title, Color color) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: AppTheme.cardDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              const Icon(Icons.more_horiz, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(7, (index) {
              double height =
                  50.0 + (index * 15 % 40) + ((index % 2 == 0) ? 30 : 0);
              return Column(
                children: [
                  Container(
                    width: 24,
                    height: height,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.8),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(6),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'D${index + 1}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildFakePie(BuildContext context, String title) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: AppTheme.cardDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 24),
          Center(
            child: Container(
              width: 160,
              height: 160,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: SweepGradient(
                  colors: [
                    AppTheme.primary,
                    AppTheme.statusApproved,
                    AppTheme.statusPending,
                    AppTheme.primary,
                  ],
                  stops: [0.0, 0.4, 0.8, 1.0],
                ),
              ),
              child: Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '100%',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildLegendItem('admins'.tr, AppTheme.primary),
              _buildLegendItem('managers'.tr, AppTheme.statusApproved),
              _buildLegendItem('users'.tr, AppTheme.statusPending),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String title, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 800;

    Widget statCards = isMobile
        ? Column(
            children: [
              Row(
                children: [
                  _buildStatCard(
                    context,
                    'total_users'.tr,
                    '1,250',
                    Icons.people_alt_outlined,
                    AppTheme.primary,
                  ),
                  _buildStatCard(
                    context,
                    'active_projects'.tr,
                    '34',
                    Icons.business_center_outlined,
                    AppTheme.statusApproved,
                  ),
                ],
              ),
              Row(
                children: [
                  _buildStatCard(
                    context,
                    'roles_active'.tr,
                    '12',
                    Icons.admin_panel_settings_outlined,
                    AppTheme.statusPending,
                  ),
                  const Spacer(), // Keeps the grid look balanced
                ],
              ),
            ],
          )
        : Row(
            children: [
              _buildStatCard(
                context,
                'total_users'.tr,
                '1,250',
                Icons.people_alt_outlined,
                AppTheme.primary,
              ),
              _buildStatCard(
                context,
                'active_projects'.tr,
                '34',
                Icons.business_center_outlined,
                AppTheme.statusApproved,
              ),
              _buildStatCard(
                context,
                'roles_active'.tr,
                '12',
                Icons.admin_panel_settings_outlined,
                AppTheme.statusPending,
              ),
            ],
          );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          statCards,
          const SizedBox(height: 16),
          if (isMobile)
            Column(
              children: [
                _buildFakeChart(context, 'monthly_growth'.tr, AppTheme.primary),
                const SizedBox(height: 16),
                _buildFakePie(context, 'users_distribution'.tr),
                const SizedBox(height: 16),
                _buildFakeChart(
                  context,
                  'system_overview'.tr,
                  AppTheme.statusApproved,
                ),
              ],
            )
          else
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: _buildFakeChart(
                    context,
                    'monthly_growth'.tr,
                    AppTheme.primary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 1,
                  child: _buildFakePie(context, 'users_distribution'.tr),
                ),
              ],
            ),
          const SizedBox(height: 16),
          if (!isMobile)
            Row(
              children: [
                Expanded(
                  child: _buildFakeChart(
                    context,
                    'system_overview'.tr,
                    AppTheme.statusApproved,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
