import 'package:flutter/material.dart';
import 'package:playground/providers/todo.dart';
import 'package:provider/provider.dart';

class TodoListItemWidget extends StatefulWidget {
  final String? title;
  final bool? isCompleted;

  const TodoListItemWidget({Key? key, this.title, this.isCompleted})
      : super(key: key);

  @override
  State<TodoListItemWidget> createState() => _TodoListItemWidgetState();
}

class _TodoListItemWidgetState extends State<TodoListItemWidget> {
  bool? _isCompleted;

  @override
  void initState() {
    super.initState();
    _isCompleted = widget.isCompleted;
  }

  void switchCompleted(bool? newValue) {
    setState(() {
      _isCompleted = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<Todo>(context, listen: false).fetchData(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Consumer<Todo>(
            builder: (context, value, child) {
              return ListTile(
                title: Text(
                  value.text!,
                  style: TextStyle(
                      decoration: _isCompleted!
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),
                leading: Checkbox(
                  value: _isCompleted,
                  onChanged: (newValue) {
                    value.switchCompleted();
                    switchCompleted(newValue);
                  },
                ),
              );
            },
          );
        });
  }
}
