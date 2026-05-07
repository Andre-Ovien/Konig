import 'package:flutter/material.dart';
import 'package:konig/controllers/theme_controller.dart';
import 'screens/onboarding/splash_screen.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'utils/app_themes.dart';
import 'controllers/navigation_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(ThemeController());   
  Get.put(NavigationController());  
  runApp(const Konig());
}

class Konig extends StatefulWidget {
  const Konig({super.key});

  @override
  State<Konig> createState() => _KonigState();
}

class _KonigState extends State<Konig> {
  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Konig',
      theme: AppThemes.light,
      darkTheme: AppThemes.dark,
      themeMode: themeController.theme,
      defaultTransition: Transition.fade,
      home: const SplashScreen(),
      );
  }
}
