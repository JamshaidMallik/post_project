import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final box = GetStorage();
  final _isDark = false.obs;

  @override
  void onInit() {
    super.onInit();
    _isDark.value = box.read('isDark') ?? false;
  }

  bool get isDark => _isDark.value;

  void toggleTheme() {
    _isDark.toggle();
    box.write('isDark', _isDark.value);
    Get.changeThemeMode(_isDark.value ? ThemeMode.dark : ThemeMode.light);
  }

}
