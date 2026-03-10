import 'package:get/get.dart';
import 'controllers.dart';
import '../data/datasources.dart';
import '../data/repositories_impl.dart';
import '../domain/repositories.dart';
import '../domain/usecases.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Data Sources
    Get.lazyPut<AppDataSource>(() => RemoteDataSourceImpl(), fenix: true);

    // Repositories
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: Get.find()),
      fenix: true,
    );
    Get.lazyPut<TicketRepository>(
      () => TicketRepositoryImpl(remoteDataSource: Get.find()),
      fenix: true,
    );

    // UseCases
    Get.lazyPut(() => LoginUseCase(Get.find<AuthRepository>()), fenix: true);
    Get.lazyPut(
      () => GetTicketsUseCase(Get.find<TicketRepository>()),
      fenix: true,
    );

    // Controllers
    Get.put(AuthController(loginUseCase: Get.find()), permanent: true);
  }
}

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainController(), permanent: false);
    Get.put(TicketController(getTicketsUseCase: Get.find()), permanent: false);
    Get.put(TaskController(), permanent: false);
    Get.put(NotificationController(), permanent: false);
  }
}
