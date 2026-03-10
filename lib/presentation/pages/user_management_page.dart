import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme.dart';

class UserManagementPage extends StatelessWidget {
  const UserManagementPage({Key? key}) : super(key: key);

  void _showAddUser() {
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
              Text('add_new_user'.tr, style: Get.theme.textTheme.titleLarge),
              const SizedBox(height: 24),
              TextField(decoration: InputDecoration(labelText: 'username'.tr)),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(labelText: 'email_address'.tr),
              ),
              const SizedBox(height: 16),
              TextField(
                obscureText: true,
                decoration: InputDecoration(labelText: 'password'.tr),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                isExpanded: true,
                decoration: InputDecoration(labelText: 'department'.tr),
                items: ['it', 'hr', 'finance']
                    .map(
                      (val) =>
                          DropdownMenuItem(value: val, child: Text(val.tr)),
                    )
                    .toList(),
                onChanged: (_) {},
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(labelText: 'mobile_phone'.tr),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Text('save_user'.tr),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'user_management'.tr,
                  style: Theme.of(
                    context,
                  ).textTheme.headlineLarge?.copyWith(fontSize: 28),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton.icon(
                icon: const Icon(Icons.person_add),
                label: Text('add_user'.tr),
                onPressed: _showAddUser,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Container(
              decoration: AppTheme.cardDecoration(context),
              child: ListView.separated(
                itemCount: 5,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppTheme.primary,
                      child: Text(
                        'U${index + 1}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      'User Name ${index + 1}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'user${index + 1}@example.com • ${'it'.tr} • +1 234 567 890',
                    ),
                    trailing: const Icon(Icons.more_vert),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
