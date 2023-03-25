import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_project/screens/profile/profile.dart';
import 'package:post_project/testing_page.dart';
import '../constant/constant.dart';
import '../controller/theme_controller.dart';
import 'todo-app/todo_main_screen.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({Key? key}) : super(key: key);
  final themeController = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('asset/header_image.jpg'),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 50.0, horizontal: 60.0),
                child: Text(
                  'Jamshaid Malik',
                  style: whiteFontStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0)
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
            Obx(() => SwitchListTile(
                  title: Text(
                      '${themeController.isDark ? 'Dark Theme' : 'Light Theme'} '),
                  value: themeController.isDark,
                  onChanged: (value) => themeController.toggleTheme(),
                )),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.note_add),
              title: const Text('Todo App'),
              onTap: () {
                Navigator.pop(context);
                Get.to(() => const TodoMainScreen());
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                Get.to(() => const MyProfile());
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Testing'),
              onTap: () {
                Navigator.pop(context);
                Get.to(() => const TestingPage());
              },
            ),
          ],
        ),
      ),
    );
  }
}
