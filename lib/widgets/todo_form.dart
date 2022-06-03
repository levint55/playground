import 'package:flutter/material.dart';
import 'package:playground/providers/todo_list.dart';
import 'package:provider/provider.dart';

class TodoForm extends StatefulWidget {
  const TodoForm({Key? key}) : super(key: key);

  @override
  State<TodoForm> createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();

  void trySubmit() {
    _formKey.currentState?.save();
    final isValid = _formKey.currentState?.validate();

    if (isValid == null || !isValid) {
      return;
    }

    Provider.of<TodoList>(context, listen: false).addData(controller.text);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Render -> Todo Form');
    return Form(
      key: _formKey,
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextFormField(
              controller: controller,
              decoration: const InputDecoration(label: Text('Text')),
              validator: (input) {
                if (input == null) {
                  return 'Input is null';
                }
                if (input.isEmpty) {
                  return 'Input is empty';
                }
                return null;
              },
              onSaved: (input) {
                controller.text = input!.trim();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: trySubmit,
              child: Text('Add'),
            )
          ],
        ),
      ),
    );
  }
}
