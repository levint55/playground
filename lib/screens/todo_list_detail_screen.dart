import 'package:flutter/material.dart';
import 'package:playground/models/todo_form_arguments.dart';
import 'package:playground/models/todo_list_arguments.dart';
import 'package:playground/providers/todo_list.dart';
import 'package:playground/screens/add_todo_screen.dart';
import 'package:playground/widgets/todo_list_widget.dart';
import 'package:provider/provider.dart';

class TodoListDetailScreen extends StatelessWidget {
  static const routeName = '/todos-detail';

  const TodoListDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as TodoListArguments;
    final String id = args.id;
    final String title = args.title;
    final bool isDone = args.isDone;

    return ChangeNotifierProvider<TodoList>(
      create: (context) => TodoList(id, title, [], isDone),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(AddTodoScreen.routeName,
                        arguments: TodoFormArguments(true, null))
                    .then((value) {
                  if (value != null) {
                    // TODO: check isCreate, dan tentukan actionnya

                    Provider.of<TodoList>(context, listen: false)
                        .addData(value as String);
                  }
                  return;
                });
              },
              icon: const Icon(Icons.add),
            )
          ],
        ),
        body: const TodoListWidget(),
      ),
    );
  }
}
