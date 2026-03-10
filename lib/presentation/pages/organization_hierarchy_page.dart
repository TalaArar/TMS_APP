import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme.dart';

class HierarchyNode {
  String id;
  String title;
  String subtitle;
  List<HierarchyNode> children;
  bool isRoot;

  HierarchyNode({
    required this.id,
    required this.title,
    required this.subtitle,
    this.children = const [],
    this.isRoot = false,
  });
}

class OrganizationHierarchyPage extends StatefulWidget {
  const OrganizationHierarchyPage({Key? key}) : super(key: key);

  @override
  State<OrganizationHierarchyPage> createState() =>
      _OrganizationHierarchyPageState();
}

class _OrganizationHierarchyPageState extends State<OrganizationHierarchyPage> {
  final TransformationController _transformationController =
      TransformationController();

  late HierarchyNode _rootNode;

  @override
  void initState() {
    super.initState();
    // Initialize with a default structure
    _rootNode = HierarchyNode(
      id: '1',
      title: 'CEO',
      subtitle: 'Board',
      isRoot: true,
      children: [
        HierarchyNode(
          id: '2',
          title: 'CTO',
          subtitle: 'Technology',
          children: [
            HierarchyNode(id: '3', title: 'Dev Lead', subtitle: 'Engineering'),
            HierarchyNode(id: '4', title: 'QA Lead', subtitle: 'Testing'),
          ],
        ),
        HierarchyNode(
          id: '5',
          title: 'HR Manager',
          subtitle: 'Human Resources',
          children: [
            HierarchyNode(id: '6', title: 'Recruiter', subtitle: 'Acquisition'),
          ],
        ),
      ],
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _resetZoom();
    });
  }

  void _zoom(double factor) {
    final Matrix4 current = _transformationController.value;
    final double currentScale = current.getMaxScaleOnAxis();

    // Calculate center of screen relative to canvas
    final Size viewportSize = MediaQuery.of(context).size;
    final double centerX = viewportSize.width / 2;
    final double centerY = viewportSize.height / 2;

    // Adjust scale around the center of the screen
    final double newScale = (currentScale * factor).clamp(0.2, 3.0);
    final double scaleFactor = newScale / currentScale;

    final Matrix4 newMatrix = current.copyInto(Matrix4.identity())
      ..translate(centerX, centerY)
      ..scale(scaleFactor)
      ..translate(-centerX, -centerY);

    _transformationController.value = newMatrix;
  }

  void _resetZoom() {
    final Size viewportSize = MediaQuery.of(context).size;
    // Sidebar is approx 280px, AppBar/Header 100px. These are estimates.
    // Center of viewport in canvas coordinates:
    final double transX = (viewportSize.width / 2) - 2000;
    final double transY = (viewportSize.height / 2) - 2050;

    _transformationController.value = Matrix4.identity()
      ..translate(transX, transY);
  }

  void _addNode(HierarchyNode parent) {
    final titleController = TextEditingController();
    final subController = TextEditingController();

    Get.dialog(
      Dialog(
        backgroundColor: AppTheme.backgroundLight,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(24),
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('add_node'.tr, style: Get.textTheme.titleLarge),
              const SizedBox(height: 16),
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'name'.tr),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: subController,
                decoration: InputDecoration(labelText: 'role'.tr),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    parent.children = List.from(parent.children)
                      ..add(
                        HierarchyNode(
                          id: DateTime.now().toString(),
                          title: titleController.text,
                          subtitle: subController.text,
                        ),
                      );
                  });
                  Get.back();
                },
                child: Text('add'.tr),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _editNode(HierarchyNode node) {
    final titleController = TextEditingController(text: node.title);
    final subController = TextEditingController(text: node.subtitle);

    Get.dialog(
      Dialog(
        backgroundColor: AppTheme.backgroundLight,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(24),
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('edit_node'.tr, style: Get.textTheme.titleLarge),
              const SizedBox(height: 16),
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'name'.tr),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: subController,
                decoration: InputDecoration(labelText: 'role'.tr),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    node.title = titleController.text;
                    node.subtitle = subController.text;
                  });
                  Get.back();
                },
                child: Text('save'.tr),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _deleteNode(HierarchyNode node) {
    if (node.isRoot) {
      Get.snackbar('error'.tr, 'cannot_delete_root'.tr);
      return;
    }

    bool findAndDelete(HierarchyNode current) {
      for (int i = 0; i < current.children.length; i++) {
        if (current.children[i].id == node.id) {
          current.children.removeAt(i);
          return true;
        }
        if (findAndDelete(current.children[i])) return true;
      }
      return false;
    }

    setState(() {
      findAndDelete(_rootNode);
    });
  }

  Widget _buildNode(BuildContext context, HierarchyNode node) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // The Node Card
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: node.isRoot ? AppTheme.primary : Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            border: node.isRoot
                ? null
                : Border.all(color: Colors.grey.withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: IntrinsicWidth(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: node.isRoot
                          ? Colors.white24
                          : AppTheme.primary.withOpacity(0.1),
                      child: Icon(
                        Icons.person,
                        color: node.isRoot ? Colors.white : AppTheme.primary,
                      ),
                      radius: 24,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      node.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: node.isRoot
                            ? Colors.white
                            : Theme.of(context).textTheme.headlineLarge?.color,
                      ),
                    ),
                    Text(
                      node.subtitle,
                      style: TextStyle(
                        color: node.isRoot ? Colors.white70 : Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: -8,
                  right: -16,
                  child: PopupMenuButton<String>(
                    icon: Icon(
                      Icons.more_vert,
                      size: 18,
                      color: node.isRoot ? Colors.white70 : Colors.grey,
                    ),
                    onSelected: (val) {
                      if (val == 'add') _addNode(node);
                      if (val == 'edit') _editNode(node);
                      if (val == 'delete') _deleteNode(node);
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'add',
                        child: Row(
                          children: [
                            const Icon(Icons.add_circle_outline, size: 18),
                            const SizedBox(width: 8),
                            Text('add_child'.tr),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            const Icon(Icons.edit_outlined, size: 18),
                            const SizedBox(width: 8),
                            Text('edit'.tr),
                          ],
                        ),
                      ),
                      if (!node.isRoot)
                        PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              const Icon(
                                Icons.delete_outline,
                                size: 18,
                                color: Colors.red,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'delete'.tr,
                                style: const TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Children and Connectors
        if (node.children.isNotEmpty) ...[
          // vertical line from parent to horizontal bar
          Container(width: 2, height: 40, color: Colors.grey.shade400),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: node.children.asMap().entries.map((entry) {
              int index = entry.key;
              var child = entry.value;

              return IntrinsicWidth(
                child: Column(
                  children: [
                    // Horizontal bar connectors and vertical stub
                    SizedBox(
                      height: 22, // 2px for bar + 20px for stub
                      child: Stack(
                        children: [
                          // Left half of the bar
                          if (index > 0)
                            Align(
                              alignment: Alignment.topCenter,
                              child: FractionallySizedBox(
                                alignment: Alignment.topLeft,
                                widthFactor: 0.5,
                                child: Container(
                                  height: 2,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                            ),
                          // Right half of the bar
                          if (index < node.children.length - 1)
                            Align(
                              alignment: Alignment.topCenter,
                              child: FractionallySizedBox(
                                alignment: Alignment.topRight,
                                widthFactor: 0.5,
                                child: Container(
                                  height: 2,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                            ),
                          // Vertical stub down to branch
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: 2,
                              height: 20,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildNode(context, child),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'org_hierarchy'.tr,
                  style: Theme.of(
                    context,
                  ).textTheme.headlineLarge?.copyWith(fontSize: 28),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 16),
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.zoom_out, color: AppTheme.primary),
                      onPressed: () => _zoom(0.8),
                    ),
                    IconButton(
                      icon: const Icon(Icons.refresh, color: AppTheme.primary),
                      onPressed: _resetZoom,
                    ),
                    IconButton(
                      icon: const Icon(Icons.zoom_in, color: AppTheme.primary),
                      onPressed: () => _zoom(1.2),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Expanded(
          child: Container(
            margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.withOpacity(0.1)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return InteractiveViewer(
                    transformationController: _transformationController,
                    boundaryMargin: const EdgeInsets.all(1000),
                    minScale: 0.1,
                    maxScale: 2.0,
                    constrained: false,
                    child: SizedBox(
                      width: 4000,
                      height: 4000,
                      child: Align(
                        alignment: Alignment.center,
                        child: _buildNode(context, _rootNode),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
