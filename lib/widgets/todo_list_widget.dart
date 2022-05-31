import 'package:flutter/material.dart';
import 'package:playground/providers/todoList.dart';
import 'package:playground/widgets/todo_list_item_widget.dart';
import 'package:provider/provider.dart';

class TodoListWidget extends StatelessWidget {
  const TodoListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoList>(
      builder: (context, value, child) {
        return ListView.builder(
          itemCount: value.items.length,
          itemBuilder: (context, index) {
            return TodoListItemWidget(
              title: value.items[index].text,
              isCompleted: value.items[index].isCompleted,
            );
          },
        );
      },
    );
  }
}
