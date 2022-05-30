import 'package:flutter/material.dart';
import 'package:playground/providers/todo.dart';

class TodoList with ChangeNotifier {
  final String? _id;
  final String? _title;
  final List<Todo> _items;

  TodoList(this._id, this._title, this._items);

  List<Todo> get items {
    return _items;
  }

  String? get title {
    return _title;
  }

  double getProgressValue() {
    //TODO: Add logic
    return 0.5;
  }
}
