import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme.dart';

class RolesPermissionsPage extends StatelessWidget {
  const RolesPermissionsPage({Key? key}) : super(key: key);

  void _showAddRole() {
    Get.dialog(
      Dialog(
        backgroundColor: AppTheme.backgroundLight,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: 500,
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('add_role'.tr, style: Get.theme.textTheme.titleLarge),
              const SizedBox(height: 24),
              TextField(decoration: InputDecoration(labelText: 'roles'.tr)),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(labelText: 'description'.tr),
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'permission_checklist'.tr,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 150,
                child: ListView(
                  children: [
                    CheckboxListTile(
                      title: Text('view_dashboard'.tr),
                      value: true,
                      onChanged: (_) {},
                    ),
                    CheckboxListTile(
                      title: Text('manage_users'.tr),
                      value: false,
                      onChanged: (_) {},
                    ),
                    CheckboxListTile(
                      title: Text('edit_projects'.tr),
                      value: true,
                      onChanged: (_) {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Text('save_role'.tr),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddPermission() {
    Get.dialog(
      Dialog(
        backgroundColor: AppTheme.backgroundLight,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: 500,
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('add_permission'.tr, style: Get.theme.textTheme.titleLarge),
              const SizedBox(height: 24),
              DropdownButtonFormField<String>(
                isExpanded: true,
                decoration: InputDecoration(labelText: 'permission_type'.tr),
                items: ['Navigation', 'Action']
                    .map(
                      (val) => DropdownMenuItem(value: val, child: Text(val)),
                    )
                    .toList(),
                onChanged: (_) {},
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(labelText: 'display_name'.tr),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(labelText: 'system_name'.tr),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(labelText: 'description'.tr),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(labelText: 'route_path'.tr),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Text('save_permission'.tr),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Container(
              decoration: AppTheme.cardDecoration(context),
              child: TabBar(
                labelColor: AppTheme.primary,
                unselectedLabelColor: Colors.grey,
                indicatorColor: AppTheme.primary,
                tabs: [
                  Tab(text: 'roles'.tr),
                  Tab(text: 'permissions'.tr),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: TabBarView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(Icons.add),
                        label: Text('add_role'.tr),
                        onPressed: _showAddRole,
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: Container(
                          decoration: AppTheme.cardDecoration(context),
                          child: ListView(
                            children: [
                              ListTile(
                                title: Text(
                                  'super_admin'.tr,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text('super_admin_desc'.tr),
                                trailing: const Icon(Icons.edit),
                              ),
                              const Divider(),
                              ListTile(
                                title: Text(
                                  'manager'.tr,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text('manager_desc'.tr),
                                trailing: const Icon(Icons.edit),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(Icons.add),
                        label: Text('add_permission'.tr),
                        onPressed: _showAddPermission,
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: Container(
                          decoration: AppTheme.cardDecoration(context),
                          child: ListView(
                            children: [
                              ListTile(
                                title: Text(
                                  'view_users'.tr,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text('nav_view_users_desc'.tr),
                                trailing: const Icon(Icons.edit),
                              ),
                              const Divider(),
                              ListTile(
                                title: Text(
                                  'create_ticket'.tr,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text('act_create_ticket_desc'.tr),
                                trailing: const Icon(Icons.edit),
                              ),
                            ],
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
      ),
    );
  }
}
