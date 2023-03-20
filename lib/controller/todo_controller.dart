import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
class TodoController extends GetxController {
  final box = GetStorage();
  final RxList _todoList = [].obs;
  List get todoList => _todoList;

  @override
  void onInit() {
    super.onInit();
    _todoList.value = GetStorage().read('todoList') ?? [];
  }
  void addTodo(String title, String description) {
    _todoList.add({'title': title, 'description': description,'created_at': DateTime.now()});
     box.write('todoList', _todoList);
     update();
  }
  void deleteTodo(int index) {
    _todoList.removeAt(index);
    box.write('todoList', _todoList);
    update();
  }
  void clearTodo() {
    _todoList.clear();
    box.write('todoList', _todoList);
    update();
  }

}