import 'package:flutter/material.dart';
import 'package:playground/providers/todo.dart';
import 'package:playground/providers/todo_list.dart';
import 'package:playground/screens/add_todo_screen.dart';
import 'package:provider/provider.dart';

class TodoListItemWidget extends StatefulWidget {
  final Todo todo;
  const TodoListItemWidget({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  State<TodoListItemWidget> createState() => _TodoListItemWidgetState();
}

class _TodoListItemWidgetState extends State<TodoListItemWidget> {
  @override
  Widget build(BuildContext context) {
    debugPrint('Render -> Todo List Item Widget');
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
            widget.todo.switchCompleted(context);
          });
        },
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Provider.of<Todo>(context, listen: false).id = widget.todo.id;
                Navigator.of(context)
                    .pushNamed(AddTodoScreen.routeName, arguments: false);
              },
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                Provider.of<TodoList>(context, listen: false)
                    .deleteData(widget.todo.id!);
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
