import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:post_project/controller/todo_controller.dart';
import '../../constant/constant.dart';
import 'package:get/get.dart';
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
      builder: (controller){
        return Scaffold(
          appBar: AppBar(
            title:  Text('My Todo', style: primaryFontStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
            centerTitle: true,
          ),
          body: (controller.todoList.isNotEmpty)
              ? Padding(
            padding: const EdgeInsets.all(8.0),
            child:  GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              childAspectRatio: 1,
            ),
              physics: const BouncingScrollPhysics(),
              itemCount: controller.todoList.length,
             itemBuilder: (context, index) {
              var todo = controller.todoList[index];
              String title = todo['title'];
              String description = todo['description'];
              final formattedDate = DateTime.parse(todo['created_at'].toString());
              final date = DateFormat('yyyy-MM-dd').format(formattedDate);
              return InkWell(
                 splashColor: Colors.red.withOpacity(0.2),
                 onLongPress: (){
                   AwesomeDialog(
                     context: context,
                     animType: AnimType.scale,
                     dialogType: DialogType.question,
                     body: const Center(child: Text(
                       'Are You Sure you?\nwant to delete this task!',
                       style: TextStyle(fontStyle: FontStyle.italic),
                     ),),
                     btnOkText: 'Yes',
                     btnOkOnPress: () {
                       controller.deleteTodo(index);
                     },
                   ).show();
                 },
                 onTap: (){
                 },
                 child: Container(
                   decoration: BoxDecoration(
                     color: Colors.grey.withOpacity(0.1),
                     borderRadius: BorderRadius.circular(5),
                   ),
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: SingleChildScrollView(
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children:  [
                            Align(
                                alignment: Alignment.center,
                                child: Text(date, style: greyFontStyle(fontSize: 12.0, fontWeight: FontWeight.w400),)),
                            SizedBox(height: 10.0,),
                            Text(title, style: primaryFontStyle(fontSize: 14.0, fontWeight: FontWeight.bold),),
                            Text(description,style: secondaryFontStyle(fontSize: 12.0, fontWeight: FontWeight.w500),),
                            ],
                       ),
                     ),
                   ),
                 ),
               );
             },),
          )
              : Center(child:
          Text('Add Your Task accourding to your need', style: primaryFontStyle(fontWeight: FontWeight.w400,fontSize: 12.0),),),
          floatingActionButton: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              (controller.todoList.isNotEmpty)
                  ? FloatingActionButton(
                  heroTag: 'fab1',
                shape: const CircleBorder(),
                tooltip: 'Total Note',
                backgroundColor: Colors.blue,
                onPressed: () {},
                child: Text('${controller.todoList.length}', style: primaryFontStyle(fontSize: 12.0, fontWeight: FontWeight.w500).copyWith(color: Colors.white),)
              )
                  : Container(),
              const SizedBox(height: 10.0,),
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
              const SizedBox(height: 10.0,),
              FloatingActionButton(
                heroTag: 'fab3',
                shape: const CircleBorder(),
                tooltip: 'Clear All Note',
                backgroundColor: Colors.red,
                onPressed: () {
                  AwesomeDialog(
                    context: context,
                    animType: AnimType.scale,
                    dialogType: DialogType.question,
                    body: const Center(child: Text(
                      'Are You Sure you? want to \ndelete All Tasks Permanently!',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),),
                    btnOkText: 'Yes',
                    btnOkOnPress: () {
                      controller.clearTodo();
                    },
                  ).show();
                },
                child: const Icon(Icons.clear, color: Colors.white),
              ),
            ],
          ),
        );
      }
    );
  }
}
