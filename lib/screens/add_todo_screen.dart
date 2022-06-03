import 'package:flutter/material.dart';
import 'package:playground/widgets/todo_form.dart';

class AddTodoScreen extends StatelessWidget {
  static const routeName = '/add-todo';
  const AddTodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('Render -> Add Todo Screen');
    bool? isCreate =
        ModalRoute.of(context)!.settings.arguments as bool? ?? true;

    return Scaffold(
      appBar: AppBar(
        title: isCreate ? const Text('Add Todo') : const Text('Edit Todo'),
      ),
      body: SingleChildScrollView(
        child: TodoForm(isCreate: isCreate),
      ),
    );
  }
}
