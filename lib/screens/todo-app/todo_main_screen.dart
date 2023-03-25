import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:post_project/controller/todo_controller.dart';
import 'package:post_project/screens/todo-app/view_todo_and_update_screen.dart';
import '../../constant/constant.dart';
import 'package:get/get.dart';
import '../my_drawer.dart';
import 'add_todo.dart';
import 'package:intl/intl.dart';

class TodoMainScreen extends StatefulWidget {
  const TodoMainScreen({Key? key}) : super(key: key);

  @override
  State<TodoMainScreen> createState() => _TodoMainScreenState();
}

class _TodoMainScreenState extends State<TodoMainScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TodoController>(
        init: TodoController(),
        builder: (controller) {
          return GestureDetector(
            onHorizontalDragEnd: (DragEndDetails details) {
              if (details.velocity.pixelsPerSecond.dx > 0) {
                controller.scaffoldKey.currentState?.openDrawer();
              } else if (details.velocity.pixelsPerSecond.dx < 0) {
                controller.scaffoldKey.currentState?.openEndDrawer();
              }
            },
            child: Scaffold(
              key: controller.scaffoldKey,
              drawer: MyDrawer(),
              appBar: AppBar(
                title: Text(
                  'My Todo',
                  style: primaryFontStyle(
                      fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                actions: [
                  controller.todoList.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: IconButton(
                              onPressed: controller.toggleList,
                              icon: Icon(controller.isGrid.value
                                  ? Icons.view_list_rounded
                                  : Icons.grid_view_outlined)),
                        )
                      : Container(),
                ],
              ),
              body: (controller.todoList.isNotEmpty)
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: controller.isGrid.value
                          ? ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: controller.todoList.length,
                              itemBuilder: (context, index) {
                                var todo = controller.todoList[index];
                                String title = todo['title'];
                                String description = todo['description'];
                                final formattedDate = DateTime.parse(
                                    todo['created_at'].toString());
                                final date = DateFormat('dd-MM-yyyy')
                                    .format(formattedDate);
                                return TodoListCard(
                                    title: title,
                                    description: description,
                                    date: date,
                                    controller: controller,
                                    index: index);
                              },
                            )
                          : GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              physics: const BouncingScrollPhysics(),
                              itemCount: controller.todoList.length,
                              itemBuilder: (context, index) {
                                var todo = controller.todoList[index];
                                String title = todo['title'];
                                String description = todo['description'];
                                final formattedDate = DateTime.parse(
                                    todo['created_at'].toString());
                                final date = DateFormat('dd-MM-yyyy')
                                    .format(formattedDate);
                                return TodoListCard(
                                    title: title,
                                    description: description,
                                    date: date,
                                    controller: controller,
                                    index: index);
                              },
                            ),
                    )
                  : Center(
                      child: Text(
                        'Add Your Task according to your need',
                        style: primaryFontStyle(
                            fontWeight: FontWeight.w400, fontSize: 12.0),
                      ),
                    ),
              floatingActionButton:
                  FloatingActionButtons(controller: controller),
            ),
          );
        });
  }
}

class FloatingActionButtons extends StatelessWidget {
  const FloatingActionButtons({
    super.key,
    required this.controller,
  });
  final TodoController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        (controller.todoList.isNotEmpty)
            ? FloatingActionButton(
                heroTag: 'fab1',
                shape: const CircleBorder(),
                tooltip: 'Total Note',
                backgroundColor: Colors.blue,
                onPressed: null,
                child: Text(
                  '${controller.todoList.length}',
                  style: primaryFontStyle(fontSize: 12.0, fontWeight: FontWeight.w500)
                      .copyWith(color: Colors.white),
                ))
            : Container(),
        const SizedBox(
          height: 10.0,
        ),
        FloatingActionButton(
          heroTag: 'fab2',
          shape: const CircleBorder(),
          tooltip: 'Add Note',
          backgroundColor: Colors.green,
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AddTodoDialog(
                  onAddTodo: (title, description) {
                    controller.addTodo(
                      title,
                      description,
                    );
                  },
                );
              },
            );
          },
          child: const Icon(Icons.add, color: Colors.white),
        ),
        const SizedBox(
          height: 10.0,
        ),
        (controller.todoList.isNotEmpty)
            ? FloatingActionButton(
                heroTag: 'fab3',
                shape: const CircleBorder(),
                tooltip: 'Clear All Note',
                backgroundColor: Colors.red,
                onPressed: () {
                  AwesomeDialog(
                    context: context,
                    animType: AnimType.scale,
                    dialogType: DialogType.question,
                    body: const Center(
                      child: Text(
                        'Are You Sure you? want to \ndelete All Tasks Permanently!',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    btnOkText: 'Yes',
                    btnOkOnPress: () {
                      controller.clearAllTodo();
                    },
                  ).show();
                },
                child: const Icon(Icons.clear, color: Colors.white),
              )
            : Container(),
      ],
    );
  }
}

class TodoListCard extends StatelessWidget {
  const TodoListCard({
    super.key,
    required this.title,
    required this.description,
    required this.date,
    required this.controller,
    required this.index,
  });

  final String title;
  final String description;
  final String date;
  final TodoController controller;
  final int index;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Dismissible(
      key: UniqueKey(),
      direction: controller.isGrid.value
          ? DismissDirection.horizontal
          : DismissDirection.vertical,
      secondaryBackground: Container(
        color: Colors.red,
        child: const Center(
          child: Text(
            'Delete',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      background: Container(
        color: Colors.red,
        child: const Center(
          child: Text(
            'Delete',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      onDismissed: (direction) {
        controller.deleteTodo(index);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(milliseconds: 500),
            backgroundColor: Colors.red,
            content: Text('Todo Deleted Permanently'),
          ),
        );
      },
      child: InkWell(
        splashColor: Colors.red.withOpacity(0.2),
        onTap: () {
          Get.to(
            () => ViewAndUpdateTodo(
                title: title, description: description, index: index),
          );
        },
        child: Container(
          margin: EdgeInsets.only(bottom: controller.isGrid.value ? 10.0 : 0.0),
          width: double.infinity,
          height:
              controller.isGrid.value ? size.height * 0.2 : size.height * 0.4,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        date,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: greyFontStyle(
                            fontSize: 12.0, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        '${index + 1} / ${controller.todoList.length}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: greyFontStyle(
                            fontSize: 12.0, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: primaryFontStyle(
                        fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    description,
                    style: secondaryFontStyle(
                        fontSize: 12.0, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
