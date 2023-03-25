import 'package:flutter/material.dart';
import 'package:post_project/screens/post_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'controller/post_controller.dart';
import 'controller/theme_controller.dart';
import 'controller/todo_controller.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final themeController = Get.put(ThemeController());
    Get.put(PostController());
    Get.put(TodoController()); 
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter',
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: themeController.isDark ? ThemeMode.dark : ThemeMode.light,
      home: const HomePage(),
    );
  }
}
