import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TodoController extends GetxController {
  final box = GetStorage();
  final RxList _todoList = [].obs;
  List get todoList => _todoList;
  RxBool isGrid = false.obs;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
  
  @override
  void onInit() {
    super.onInit();
    _todoList.value = box.read('todoList') ?? [];
  }

  void toggleList() {
    isGrid.toggle();
    update();
  }

  void addTodo(String title, String description) {
    _todoList.add({
      'title': title,
      'description': description,
      'created_at': DateTime.now().toString()
    });
    box.write('todoList', _todoList);
    update();
  }

  void updateTodo(int index, String title, String description) {
    _todoList[index] = {
      'title': title,
      'description': description,
      'created_at': DateTime.now().toString()
    };
    box.write('todoList', _todoList);
    update();
  }

  void deleteTodo(int index) {
    _todoList.removeAt(index);
    box.write('todoList', _todoList);
    update();
  }

  void clearAllTodo() {
    _todoList.clear();
    box.write('todoList', _todoList);
    update();
  }

  void searchTodo() async {
    List tempList = [];
    var fullList = await box.read('todoList');
    tempList = fullList;
    // Handle the case when either searchController or fullList is null
    if (searchController == null || fullList == null) {
      return;
    }

    if (searchController.text.isNotEmpty) {
      for (var element in _todoList) {
        if (element['title'].toString().toLowerCase().contains(searchController.text.toLowerCase()) ||
            element['description'].toString().toLowerCase().contains(searchController.text.toLowerCase())) {
          tempList.add(element);
        }
      }
      _todoList.assignAll(tempList);
    }
    else if (searchController.text.isEmpty || tempList.isEmpty) {
      _todoList.assignAll(fullList);
      update();
    }
    update();
  }


}
