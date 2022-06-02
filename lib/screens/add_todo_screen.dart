import 'package:flutter/material.dart';
import 'package:playground/models/todo_form_arguments.dart';
import 'package:playground/providers/todo.dart';
import 'package:playground/widgets/todo_form.dart';

class AddTodoScreen extends StatelessWidget {
  static const routeName = '/add-todo';
  const AddTodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TodoFormArguments args =
        ModalRoute.of(context)!.settings.arguments as TodoFormArguments;
    bool isCreate = args.isCreate;
    Todo? todo = args.todo;

    return Scaffold(
      appBar: AppBar(
        title: isCreate ? Text('Add Todo') : Text('Edit Todo'),
      ),
      body: SingleChildScrollView(
        child: TodoForm(isCreate: isCreate, todo: todo),
      ),
    );
  }
}
