
import 'package:flutter/material.dart';
import 'package:post_project/constant/constant.dart';
class ViewAndUpdateTodo extends StatefulWidget {
  final String title;
  final String description;
  const ViewAndUpdateTodo({super.key, required this.title, required this.description});

  @override
  State<ViewAndUpdateTodo> createState() => _ViewAndUpdateTodoState();
}

class _ViewAndUpdateTodoState extends State<ViewAndUpdateTodo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            // TextField(
            //   autocorrect: true,
            //   cursorColor: Colors.green,
            //   controller: titleController,
            //   style: primaryFontStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
            //   decoration: const InputDecoration(
            //     hoverColor: Colors.red,
            //     border: InputBorder.none,
            //   ),
            // ),
            Text(widget.title, style: primaryFontStyle(fontWeight: FontWeight.w600, fontSize: 16.0),),
            const Divider(),
            // TextField(
            //   autocorrect: true,
            //   cursorColor: Colors.green,
            //   controller: descriptionController,
            //   style: primaryFontStyle(fontSize: 12.0, fontWeight: FontWeight.w400),
            //   decoration: const InputDecoration(
            //     hoverColor: Colors.red,
            //     border: InputBorder.none,
            //   ),
            //   maxLines: null,
            // ),
            Text(widget.description, style: primaryFontStyle(fontWeight: FontWeight.w400, fontSize: 12.0),),
          ],
        ),
      ),
    );
  }
}
