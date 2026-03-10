import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme.dart';
import '../../core/widgets/mesh_background.dart';
import '../controllers.dart';

class LoginPage extends GetView<AuthController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController(text: 'admin@tms.com');
    final passwordController = TextEditingController(text: '123456');
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Row(
        children: [
          // Left side branding
          if (MediaQuery.of(context).size.width > 800)
            Expanded(
              child: MeshBackground(
                baseColor: isDark
                    ? const Color(0xFF0F172A)
                    : AppTheme.backgroundLight,
                colors: isDark
                    ? const [
                        Color(0xFF0F172A),
                        Color(0xFF1E3A8A),
                        AppTheme.primary,
                        AppTheme.secondary,
                      ]
                    : [
                        const Color(0xFFF8FAFC),
                        const Color(0xFFF1F5F9),
                        const Color(0xFFE2E8F0),
                        AppTheme.primary.withOpacity(0.06),
                      ],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.white.withOpacity(0.95)
                            : Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isDark
                              ? Colors.white.withOpacity(0.15)
                              : AppTheme.primary.withOpacity(0.08),
                          width: 1.2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: isDark
                                ? AppTheme.secondary.withOpacity(0.2)
                                : AppTheme.primary.withOpacity(0.08),
                            blurRadius: 40,
                            spreadRadius: 2,
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(
                              isDark ? 0.25 : 0.06,
                            ),
                            blurRadius: 25,
                            offset: const Offset(0, 12),
                            spreadRadius: -4,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 200,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 48),
                    Text(
                      'intersoft_pro'.tr,
                      style: TextStyle(
                        color: isDark ? Colors.white : AppTheme.primary,
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        shadows: isDark
                            ? [
                                Shadow(
                                  color: AppTheme.secondary.withOpacity(0.4),
                                  blurRadius: 10,
                                ),
                              ]
                            : null,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'login_subtitle'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isDark ? Colors.white70 : AppTheme.textLight,
                        fontSize: 20,
                        height: 1.6,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Right side form
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(40),
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 450),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (MediaQuery.of(context).size.width <= 800)
                        Center(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? Colors.white.withOpacity(0.95)
                                  : Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isDark
                                    ? Colors.white.withOpacity(0.15)
                                    : AppTheme.primary.withOpacity(0.08),
                                width: 1.0,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: isDark
                                      ? AppTheme.secondary.withOpacity(0.2)
                                      : AppTheme.primary.withOpacity(0.1),
                                  blurRadius: 30,
                                  spreadRadius: 1,
                                ),
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Image.asset(
                              'assets/images/logo.png',
                              height: 100,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      if (MediaQuery.of(context).size.width <= 800)
                        const SizedBox(height: 24),
                      Text(
                        'sign_in'.tr,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'enter_details'.tr,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 40),

                      Text(
                        'email_address'.tr,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: 'email_hint'.tr,
                          prefixIcon: const Icon(Icons.email_outlined),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'password'.tr,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      Obx(
                        () => TextField(
                          controller: passwordController,
                          obscureText: controller.obscurePassword.value,
                          decoration: InputDecoration(
                            hintText: '••••••••',
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.obscurePassword.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: controller.togglePasswordVisibility,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => Get.toNamed('/forgot_password'),
                          child: Text(
                            'forgot_password_q'.tr,
                            style: const TextStyle(
                              color: AppTheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Obx(
                        () => SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: controller.isLoading.value
                                ? null
                                : () => controller.login(
                                    emailController.text,
                                    passwordController.text,
                                  ),
                            child: controller.isLoading.value
                                ? CircularProgressIndicator(
                                    color: isDark
                                        ? AppTheme.textDark
                                        : Colors.white,
                                  )
                                : Text(
                                    'sign_in'.tr,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
