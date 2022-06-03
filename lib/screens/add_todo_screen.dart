import 'package:flutter/material.dart';
import 'package:playground/widgets/todo_form.dart';

class AddTodoScreen extends StatelessWidget {
  static const routeName = '/add-todo';
  const AddTodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('Render -> Add Todo Screen');
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Todo'),
      ),
      body: SingleChildScrollView(
        child: TodoForm(),
      ),
    );
  }
}
