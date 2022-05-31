import 'package:flutter/material.dart';
import 'package:playground/providers/todoList.dart';
import 'package:playground/screens/add_todo_screen.dart';
import 'package:playground/widgets/todo_list_widget.dart';
import 'package:provider/provider.dart';

class TodoListDetailScreen extends StatelessWidget {
  static const routeName = '/todos-detail';

  TodoListDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? id = ModalRoute.of(context)!.settings.arguments as String?;
    Provider.of<TodoList>(context, listen: false).setId(id);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddTodoScreen.routeName);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              Center(
                child: CircularProgressIndicator(),
              );
            }
            return TodoListWidget();
          },
          future: Provider.of<TodoList>(context, listen: false).fetchData()),
    );
  }
}
