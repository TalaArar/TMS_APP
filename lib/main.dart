import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/theme.dart';
import 'core/routes.dart';
import 'presentation/bindings.dart';

import 'core/translations.dart';

void main() {
  runApp(const TMSApp());
}

class TMSApp extends StatelessWidget {
  const TMSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Intersoft',
      translations: AppTranslations(),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      initialRoute: AppRoutes.splash,
      getPages: AppRoutes.routes,
      initialBinding: InitialBinding(),
    );
  }
}
