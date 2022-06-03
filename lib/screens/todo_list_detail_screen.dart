import 'package:flutter/material.dart';
import 'package:playground/providers/todo_list.dart';
import 'package:playground/screens/add_todo_screen.dart';
import 'package:playground/widgets/todo_list_widget.dart';
import 'package:provider/provider.dart';

class TodoListDetailScreen extends StatefulWidget {
  static const routeName = '/todos-detail';

  const TodoListDetailScreen({Key? key}) : super(key: key);

  @override
  State<TodoListDetailScreen> createState() => _TodoListDetailScreenState();
}

class _TodoListDetailScreenState extends State<TodoListDetailScreen> {
  String? title;

  @override
  void initState() {
    super.initState();
    title = Provider.of<TodoList>(context, listen: false).title;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Render -> todo list detail screen");

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(AddTodoScreen.routeName, arguments: true);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: const TodoListWidget(),
    );
  }
}
