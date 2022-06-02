import 'package:playground/providers/todo.dart';

class TodoFormArguments {
  final bool isCreate;
  final Todo? todo;

  TodoFormArguments(this.isCreate, this.todo);
}
