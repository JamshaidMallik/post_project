import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_project/screens/profile/profile.dart';
import 'package:post_project/testing_page.dart';
import '../constant/constant.dart';
import '../controller/theme_controller.dart';
import '../screens/post_app/post_page.dart';

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
                  'My To Do App',
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
              title: const Text('All Post'),
              onTap: () {
                Navigator.pop(context);
                Get.to(() =>  PostPage());
              },
            ),
          ],
        ),
      ),
    );
  }
}
