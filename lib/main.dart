import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Controller/ThemeController.dart';
import 'Screens/pages/HomeScreen.dart';
import 'Screens/pages/SecPage.dart';
import 'Screens/splash/Splash_screen..dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());

    return Obx(() => GetMaterialApp(
          title: 'Perfection',
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: themeController.theme,
          debugShowCheckedModeBanner: false,
          initialRoute: '/splash',
          getPages: [
            GetPage(name: '/splash', page: () => SplashScreen()),
            GetPage(name: '/home', page: () => HomeScreen()),
            GetPage(
              name: '/detail',
              page: () => DetailScreen(),
              transition: Transition.fadeIn,
            ),
          ],
        ));
  }
}
