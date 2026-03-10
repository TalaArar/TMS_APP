import 'package:get/get.dart';
import '../../core/usecase.dart';
import '../../domain/usecases.dart';
import '../../domain/entities.dart';

class AuthController extends GetxController {
  final LoginUseCase loginUseCase;

  AuthController({required this.loginUseCase});

  final RxBool isLoading = false.obs;
  final RxBool obscurePassword = true.obs;
  final Rx<User?> currentUser = Rx<User?>(null);

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      final user = await loginUseCase.call(
        LoginParams(email: email, password: password),
      );
      currentUser.value = user;
      Get.offAllNamed('/main');
    } catch (e) {
      Get.snackbar('error'.tr, '${'login_failed'.tr}: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    currentUser.value = null;
    Get.offAllNamed('/login');
  }
}

class MainController extends GetxController {
  final RxInt selectedIndex = 0.obs;
  final RxBool isSidebarExpanded = true.obs;

  void changePage(int index) {
    selectedIndex.value = index;
  }

  void toggleSidebar() {
    isSidebarExpanded.value = !isSidebarExpanded.value;
  }
}

class TicketController extends GetxController {
  final GetTicketsUseCase getTicketsUseCase;

  TicketController({required this.getTicketsUseCase});

  final RxList<Ticket> tickets = <Ticket>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTickets();
  }

  Future<void> fetchTickets() async {
    try {
      isLoading.value = true;
      final result = await getTicketsUseCase.call(NoParams());
      tickets.assignAll(result);
    } catch (e) {
      Get.snackbar('error'.tr, 'load_tickets_failed'.tr);
    } finally {
      isLoading.value = false;
    }
  }
}

class TaskController extends GetxController {
  final RxList<Task> tasks = <Task>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize with mock data
    tasks.addAll([
      Task(
        id: 'T-1',
        title: 'Update user documentation',
        dueDate: 'Oct 25, 2026',
        priority: 'High',
      ),
      Task(
        id: 'T-2',
        title: 'Review system security logs',
        dueDate: 'Oct 27, 2026',
        priority: 'Medium',
      ),
      Task(
        id: 'T-3',
        title: 'Prepare monthly report',
        dueDate: 'Oct 30, 2026',
        priority: 'Low',
      ),
    ]);
  }

  void toggleTaskStatus(int index) {
    tasks[index].isCompleted = !tasks[index].isCompleted;
    tasks.refresh();
  }
}

class NotificationController extends GetxController {
  final RxList<AppNotification> notifications = <AppNotification>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize with mock data
    notifications.addAll([
      AppNotification(
        id: 'N-1',
        message: 'Ticket #TKT-102 has been pending approval for 2 days.',
        time: '2 hours ago',
      ),
      AppNotification(
        id: 'N-2',
        message: 'New project "HR Portal" assigned to your department.',
        time: '5 hours ago',
      ),
      AppNotification(
        id: 'N-3',
        message: 'System maintenance scheduled for tonight at 23:00.',
        time: 'Yesterday',
      ),
      AppNotification(
        id: 'N-4',
        message: 'Daily backup sequence completed successfully.',
        time: 'Yesterday',
      ),
    ]);
  }

  void clearAll() {
    notifications.clear();
  }
}
