import 'package:flutter/material.dart';
import 'package:playground/providers/todo.dart';
import 'package:playground/providers/todo_list.dart';
import 'package:provider/provider.dart';

class TodoListItemWidget extends StatefulWidget {
  final Todo todo;
  final String todoListId;

  const TodoListItemWidget({
    Key? key,
    required this.todo,
    required this.todoListId,
  }) : super(key: key);

  @override
  State<TodoListItemWidget> createState() => _TodoListItemWidgetState();
}

class _TodoListItemWidgetState extends State<TodoListItemWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: ValueKey(widget.todo.id),
      title: Text(
        widget.todo.text!,
        style: TextStyle(
            decoration: widget.todo.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none),
      ),
      leading: Checkbox(
        value: widget.todo.isCompleted,
        onChanged: (newValue) {
          setState(() {
            widget.todo.switchCompleted(widget.todoListId);
          });
        },
      ),
      trailing: IconButton(
          onPressed: () {
            Provider.of<TodoList>(context, listen: false)
                .deleteData(widget.todo.id!);
          },
          icon: Icon(Icons.delete)),
    );
  }
}
