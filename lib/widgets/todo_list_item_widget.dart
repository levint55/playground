import 'package:flutter/material.dart';
import 'package:playground/models/todo_form_arguments.dart';
import 'package:playground/models/todo_form_parameter.dart';
import 'package:playground/providers/todo.dart';
import 'package:playground/providers/todo_list.dart';
import 'package:playground/screens/add_todo_screen.dart';
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
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(AddTodoScreen.routeName,
                        arguments: TodoFormArguments(false, widget.todo))
                    .then((value) {
                  TodoFormParameter data = value as TodoFormParameter;
                  if (!data.isCreate && data.todo != null) {
                    //TODO: Provider update todo
                  }
                  return;
                });
              },
              icon: Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                Provider.of<TodoList>(context, listen: false)
                    .deleteData(widget.todo.id!);
              },
              icon: Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
