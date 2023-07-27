import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_project/constant/constant.dart';
import 'package:post_project/controller/todo_controller.dart';

class ViewAndUpdateTodo extends StatefulWidget {
  final String title;
  final String description;
  final int index;
  const ViewAndUpdateTodo({super.key, required this.title, required this.description, required this.index});

  @override
  State<ViewAndUpdateTodo> createState() => _ViewAndUpdateTodoState();
}

class _ViewAndUpdateTodoState extends State<ViewAndUpdateTodo> {
  TodoController controller = Get.find<TodoController>();
  TextEditingController? titleController;
  TextEditingController? descriptionController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.title);
    descriptionController = TextEditingController(text: widget.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Note', style: primaryFontStyle()),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              controller.deleteTodo(
                widget.index,
              );
              Get.back();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            TextField(
              autocorrect: true,
              cursorColor: Colors.green,
              controller: titleController,
              style:
                  primaryFontStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
              decoration: const InputDecoration(
                hoverColor: Colors.red,
                border: InputBorder.none,
              ),
            ),
            const Divider(),
            TextField(
              autocorrect: true,
              cursorColor: Colors.green,
              controller: descriptionController,
              style: primaryFontStyle(fontSize: 12.0, fontWeight: FontWeight.w400),
              decoration: const InputDecoration(
                hoverColor: Colors.red,
                border: InputBorder.none,
              ),
              maxLines: null,
            ),
          ],
        ),
      ),
      floatingActionButton: GetBuilder<TodoController>(
        init: TodoController(),
        builder: (ctx) {
          return FloatingActionButton(
            shape: const CircleBorder(),
            tooltip: 'Update Note',
            backgroundColor: Colors.green,
            heroTag: 'fab4',
            onPressed: () {
              if(widget.title == titleController?.text && widget.description == descriptionController?.text){
               ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                 backgroundColor: Colors.red,
                 duration: Duration(milliseconds: 1500),
                 padding: EdgeInsets.all(5.0),
                 content: Text('You not change anything'),
               ),
             );
              }
              else{
                controller.updateTodo(widget.index,titleController!.text, descriptionController!.text);
                Get.back();
              }
            },
            child: Center(child: Text('Update', style: primaryFontStyle(fontSize: 10.0))),
          );
        }
      ),
    );
  }
}
