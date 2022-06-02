import 'package:flutter/material.dart';
import 'package:playground/models/todo_list_arguments.dart';
import 'package:playground/providers/todo_list.dart';
import 'package:playground/widgets/add_todo_form.dart';
import 'package:provider/provider.dart';

class AddTodoScreen extends StatefulWidget {
  static const routeName = '/add-todo';
  const AddTodoScreen({Key? key}) : super(key: key);

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo'),
      ),
      body: SingleChildScrollView(
        child: AddTodoForm(),
      ),
    );
  }
}
