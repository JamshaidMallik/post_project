import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:post_project/screens/todo-app/todo_main_screen.dart';
import 'constant/constant.dart';
import 'controller/theme_controller.dart';
import 'controller/todo_controller.dart';
import 'google_map/google_map.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final themeController = Get.put(ThemeController());
    Get.put(TodoController());
    return GetMaterialApp(
      defaultTransition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 500),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Testing',
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      themeMode: themeController.isDark ? ThemeMode.dark : ThemeMode.light,
      home: const TodoMainScreen(),
      // home: const GoogleMapScreen(),
    );
  }
}
