import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme.dart';
import '../controllers.dart';

class TicketsPage extends GetView<TicketController> {
  const TicketsPage({Key? key}) : super(key: key);

  Color _getStatusColor(String status) {
    if (status == 'Rejected') return AppTheme.statusRejected;
    if (status == 'Approval') return AppTheme.statusApproved;
    return AppTheme.statusPending;
  }

  void _showCreateTicket() {
    Get.dialog(const CreateTicketDialog());
  }

  void _showTicketDetail(dynamic ticket) {
    Get.dialog(TicketDetailDialog(ticket: ticket));
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
              Text(
                'tickets'.tr,
                style: Theme.of(
                  context,
                ).textTheme.headlineLarge?.copyWith(fontSize: 28),
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: Text('create_ticket'.tr),
                onPressed: _showCreateTicket,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Container(
              decoration: AppTheme.cardDecoration(context),
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.tickets.isEmpty) {
                  return Center(child: Text('no_tickets'.tr));
                }

                return ListView.separated(
                  itemCount: controller.tickets.length,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final t = controller.tickets[index];
                    final statusColor = _getStatusColor(t.status);
                    return ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: CircleAvatar(
                        backgroundColor: statusColor.withOpacity(0.2),
                        child: Icon(
                          Icons.confirmation_number,
                          color: statusColor,
                        ),
                      ),
                      title: Text(
                        t.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '${t.id} • ${t.department.tr} • ${t.priority.tr} ${'priority'.tr}',
                      ),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          t.status,
                          style: TextStyle(
                            color: statusColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      onTap: () => _showTicketDetail(t),
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class CreateTicketDialog extends StatelessWidget {
  const CreateTicketDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppTheme.backgroundLight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 600,
        padding: const EdgeInsets.all(32),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'create_new_ticket'.tr,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              TextField(decoration: InputDecoration(labelText: 'title'.tr)),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                isExpanded: true,
                decoration: InputDecoration(labelText: 'department'.tr),
                items: ['it', 'hr', 'finance', 'devops'].map((String val) {
                  return DropdownMenuItem(value: val, child: Text(val.tr));
                }).toList(),
                onChanged: (_) {},
              ),
              const SizedBox(height: 16),
              TextField(
                maxLines: 4,
                decoration: InputDecoration(labelText: 'description'.tr),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      decoration: InputDecoration(labelText: 'category'.tr),
                      items: ['hardware', 'software', 'access', 'other']
                          .map(
                            (String val) => DropdownMenuItem(
                              value: val,
                              child: Text(val.tr),
                            ),
                          )
                          .toList(),
                      onChanged: (_) {},
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      decoration: InputDecoration(labelText: 'priority'.tr),
                      items: ['low', 'medium', 'high', 'critical']
                          .map(
                            (String val) => DropdownMenuItem(
                              value: val,
                              child: Text(val.tr),
                            ),
                          )
                          .toList(),
                      onChanged: (_) {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(labelText: 'reference_link'.tr),
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                icon: const Icon(Icons.upload_file),
                label: Text('upload_files'.tr),
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 24,
                  ),
                  side: const BorderSide(color: Colors.grey),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  child: Text(
                    'submit_ticket'.tr,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TicketDetailDialog extends StatefulWidget {
  final dynamic ticket;
  const TicketDetailDialog({Key? key, required this.ticket}) : super(key: key);

  @override
  _TicketDetailDialogState createState() => _TicketDetailDialogState();
}

class _TicketDetailDialogState extends State<TicketDetailDialog> {
  bool _isApproved = false;

  @override
  void initState() {
    super.initState();
    _isApproved = widget.ticket.status == 'Approval';
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 600,
        padding: const EdgeInsets.all(32),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.ticket.id,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color:
                          (_isApproved
                                  ? AppTheme.statusApproved
                                  : AppTheme.statusPending)
                              .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _isApproved
                          ? 'approved_task_ready'.tr
                          : widget.ticket.status,
                      style: TextStyle(
                        color: _isApproved
                            ? AppTheme.statusApproved
                            : AppTheme.statusPending,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                widget.ticket.title,
                style: Theme.of(
                  context,
                ).textTheme.headlineLarge?.copyWith(fontSize: 24),
              ),
              const SizedBox(height: 24),
              Text(
                'description'.tr,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Assigned priority handling. Check related logs.',
                style: TextStyle(color: Colors.grey, height: 1.5),
              ),
              const SizedBox(height: 32),

              if (_isApproved) ...[
                const Divider(),
                const SizedBox(height: 16),
                Text(
                  'convert_to_task'.tr,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  isExpanded: true,
                  decoration: InputDecoration(labelText: 'assign_to'.tr),
                  items: ['John Doe', 'Jane Smith', 'DevTeam A']
                      .map(
                        (val) => DropdownMenuItem(value: val, child: Text(val)),
                      )
                      .toList(),
                  onChanged: (_) {},
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  isExpanded: true,
                  decoration: InputDecoration(
                    labelText: 'return_to_reviewer'.tr,
                  ),
                  items: ['Manager A', 'Manager B']
                      .map(
                        (val) => DropdownMenuItem(value: val, child: Text(val)),
                      )
                      .toList(),
                  onChanged: (_) {},
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Get.back(),
                    child: Text(
                      'create_task'.tr,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ] else ...[
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Get.back(),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: AppTheme.statusRejected,
                          ),
                          foregroundColor: AppTheme.statusRejected,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text('reject_ticket'.tr),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => setState(() => _isApproved = true),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.statusApproved,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text('approve_ticket'.tr),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
