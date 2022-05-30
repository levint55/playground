import 'package:playground/providers/todo.dart';
import 'package:playground/providers/todoList.dart';

var data = [
  Todo('1', DateTime.now().toIso8601String(), '1', 'Text1'),
  Todo('2', DateTime.now().toIso8601String(), '2', 'Text2'),
  Todo('3', DateTime.now().toIso8601String(), '3', 'Text3'),
  Todo('4', DateTime.now().toIso8601String(), '4', 'Text4'),
  Todo('5', DateTime.now().toIso8601String(), '5', 'Text5'),
];

var dummy_data = [
  TodoList('1', 'title1', data),
  TodoList('2', 'title2', data),
  TodoList('3', 'title3', data)
];
