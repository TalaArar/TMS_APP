import 'package:get/get.dart';
import '../presentation/bindings.dart';
import '../presentation/pages/splash_page.dart';
import '../presentation/pages/login_page.dart';
import '../presentation/pages/forgot_password_page.dart';
import '../presentation/pages/main_layout_page.dart';

class AppRoutes {
  static const splash = '/splash';
  static const login = '/login';
  static const forgotPassword = '/forgot_password';
  static const main = '/main';

  static final routes = [
    GetPage(
      name: splash,
      page: () => const SplashPage(),
      binding: InitialBinding(),
    ),
    GetPage(
      name: login,
      page: () => const LoginPage(),
      binding: InitialBinding(),
    ),
    GetPage(name: forgotPassword, page: () => const ForgotPasswordPage()),
    GetPage(
      name: main,
      page: () => MainLayoutPage(),
      bindings: [InitialBinding(), MainBinding()],
    ),
  ];
}
