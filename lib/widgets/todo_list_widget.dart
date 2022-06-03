import 'package:flutter/material.dart';
import 'package:playground/providers/todo_list.dart';
import 'package:playground/widgets/todo_list_item_widget.dart';
import 'package:provider/provider.dart';

class TodoListWidget extends StatelessWidget {
  const TodoListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('Render -> Todo List Widget');
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Consumer<TodoList>(
          builder: (context, value, child) => value.items.isEmpty
              ? const Center(
                  child: Text('No Todos!'),
                )
              : ListView.builder(
                  itemCount: value.items.length,
                  itemBuilder: (context, index) {
                    return TodoListItemWidget(todo: value.items[index]);
                  },
                ),
        );
      },
      future: Provider.of<TodoList>(context, listen: false).fetchData(),
    );
  }
}
