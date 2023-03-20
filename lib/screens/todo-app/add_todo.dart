import 'package:flutter/material.dart';
import 'package:post_project/constant/constant.dart';

class AddTodoDialog extends StatefulWidget {
  final Function(String, String) onAddTodo;

  const AddTodoDialog({super.key, required this.onAddTodo});

  @override
  _AddTodoDialogState createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      surfaceTintColor: Colors.white,
      title: Text('What is in your mind?', style: primaryFontStyle(fontSize: 16.0, fontWeight: FontWeight.w600),),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
           const SizedBox(height: 10,),
            TextField(
              controller: _titleController,
              cursorColor: Colors.green,
              decoration: InputDecoration(
                labelText: 'Title',
                hoverColor: Colors.green,
                labelStyle:  const TextStyle(color: Colors.grey),
                contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.5), width: 1.0),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: _descriptionController,
              cursorColor: Colors.green,
              decoration: InputDecoration(
                labelText: 'description',
                hoverColor: Colors.black,
                alignLabelWithHint: true,
                labelStyle:  const TextStyle(color: Colors.grey),
                contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.5), width: 1.0),
                ),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 10,),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          style: TextButton.styleFrom(
            foregroundColor: Colors.grey,
          ),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if(_titleController.text.isNotEmpty || _descriptionController.text.isNotEmpty){
              widget.onAddTodo(
                _titleController.text,
                _descriptionController.text,
              );
              Navigator.of(context).pop();
              _titleController.clear();
              _descriptionController.clear();
            }else{
              return;
            }
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.green,
          ),
          child: const Text('Add'),
        ),
      ],
    );
  }
}
