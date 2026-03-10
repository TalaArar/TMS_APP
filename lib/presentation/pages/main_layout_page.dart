import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme.dart';
import '../controllers.dart';
import 'dashboard_page.dart';
import 'tickets_page.dart';
import 'organization_hierarchy_page.dart';
import 'user_management_page.dart';
import 'roles_permissions_page.dart';
import 'projects_management_page.dart';
import 'tasks_page.dart';
import 'profile_page.dart';

class MainLayoutPage extends GetView<MainController> {
  MainLayoutPage({Key? key}) : super(key: key);

  final List<String> _titles = [
    'dashboard',
    'tickets',
    'tasks',
    'projects',
    'organization',
    'user_management',
    'roles_permissions',
    'my_profile',
  ];

  final List<IconData> _icons = [
    Icons.dashboard_rounded,
    Icons.confirmation_number_rounded,
    Icons.task_alt,
    Icons.business_center_rounded,
    Icons.account_tree_rounded,
    Icons.people_alt_rounded,
    Icons.admin_panel_settings_rounded,
    Icons.person_outline,
  ];

  final List<Widget> _pages = [
    const DashboardPage(),
    const TicketsPage(),
    const TasksPage(),
    const ProjectsManagementPage(),
    const OrganizationHierarchyPage(),
    const UserManagementPage(),
    const RolesPermissionsPage(),
    const ProfilePage(),
  ];

  Widget _buildSidebarItem(int index, BuildContext context) {
    return Obx(() {
      final bool isSelected = controller.selectedIndex.value == index;
      final bool isExpanded = controller.isSidebarExpanded.value;

      return InkWell(
        onTap: () {
          controller.changePage(index);
          if (MediaQuery.of(context).size.width < 800) {
            Get.back(); // Close drawer on mobile
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? AppTheme.primary.withOpacity(0.15)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: isSelected
                ? Border.all(color: AppTheme.primary.withOpacity(0.3))
                : null,
          ),
          child: Row(
            children: [
              Icon(
                _icons[index],
                color: isSelected ? AppTheme.primary : AppTheme.textLight,
                size: 24,
              ),
              if (isExpanded)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      _titles[index].tr,
                      style: TextStyle(
                        color: isSelected
                            ? AppTheme.primary
                            : AppTheme.textLight,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.w500,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildSidebar(BuildContext context) {
    return Obx(() {
      final isExpanded = controller.isSidebarExpanded.value;
      return Container(
        width: isExpanded ? 260 : 80,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(2, 0),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              height: 80,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Image.asset('assets/images/logo.png', height: 40, width: 40),
                  if (isExpanded)
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text(
                        'intersoft'.tr,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primary,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemCount: _titles.length,
                itemBuilder: (context, index) {
                  if (index == 4)
                    return Column(
                      children: [
                        const Divider(),
                        const SizedBox(height: 8),
                        _buildSidebarItem(index, context),
                      ],
                    );
                  return _buildSidebarItem(index, context);
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: IconButton(
                icon: Icon(
                  isExpanded ? Icons.chevron_left : Icons.chevron_right,
                  color: AppTheme.textLight,
                ),
                onPressed: controller.toggleSidebar,
              ),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 800;

    return Obx(() {
      final currentIndex = controller.selectedIndex.value;

      return Scaffold(
        appBar: isMobile
            ? AppBar(
                title: Text(_titles[currentIndex].tr),
                backgroundColor: Theme.of(context).cardColor,
                foregroundColor: Theme.of(context).textTheme.titleLarge?.color,
                elevation: 0,
              )
            : null,
        drawer: isMobile ? Drawer(child: _buildSidebar(context)) : null,
        body: Row(
          children: [
            if (!isMobile) _buildSidebar(context),
            Expanded(
              child: Column(
                children: [
                  if (!isMobile)
                    Container(
                      height: 80,
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey.withOpacity(0.2),
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _titles[currentIndex].tr,
                            style: Theme.of(
                              context,
                            ).textTheme.headlineLarge?.copyWith(fontSize: 24),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.notifications_none),
                                onPressed: () {},
                              ),
                              const SizedBox(width: 16),
                              const CircleAvatar(
                                backgroundColor: AppTheme.primary,
                                child: Text(
                                  'AD',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'admin_user'.tr,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    'super_admin'.tr,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  Expanded(
                    child: Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: _pages[currentIndex],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
