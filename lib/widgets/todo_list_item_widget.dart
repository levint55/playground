import 'package:flutter/material.dart';
import 'package:playground/providers/todo.dart';

class TodoListItemWidget extends StatefulWidget {
  final Todo todo;

  const TodoListItemWidget({Key? key, required this.todo}) : super(key: key);

  @override
  State<TodoListItemWidget> createState() => _TodoListItemWidgetState();
}

class _TodoListItemWidgetState extends State<TodoListItemWidget> {
  bool? _isCompleted;

  @override
  void initState() {
    super.initState();
    _isCompleted = widget.todo.isCompleted;
  }

  void switchCompleted(bool? newValue) {
    setState(() {
      _isCompleted = newValue;
      widget.todo.switchCompleted();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.todo.text!,
        style: TextStyle(
            decoration: _isCompleted!
                ? TextDecoration.lineThrough
                : TextDecoration.none),
      ),
      leading: Checkbox(
        value: _isCompleted,
        onChanged: (newValue) {
          switchCompleted(newValue);
        },
      ),
    );
  }
}
