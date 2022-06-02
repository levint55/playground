import 'package:playground/providers/todo.dart';

class TodoFormParameter {
  final String text;
  final Todo? todo;
  final bool isCreate;

  TodoFormParameter(this.text, this.todo, this.isCreate);
}
