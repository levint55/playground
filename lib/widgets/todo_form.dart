import 'package:flutter/material.dart';
import 'package:playground/models/todo_form_parameter.dart';
import 'package:playground/providers/todo.dart';

class TodoForm extends StatefulWidget {
  final bool isCreate;
  final Todo? todo;
  const TodoForm({Key? key, required this.isCreate, this.todo})
      : super(key: key);

  @override
  State<TodoForm> createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      if (!widget.isCreate && widget.todo != null) {
        controller.text = widget.todo!.text!;
      } else {
        controller.text = '';
      }
    });
  }

  void trySubmit() {
    _formKey.currentState?.save();
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();

    if (isValid == null || !isValid) {
      return;
    }

    Navigator.of(context)
        .pop(TodoFormParameter(controller.text, widget.todo, widget.isCreate));
  }

  @override
  Widget build(BuildContext context) {
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
                child: widget.isCreate ? Text('Add') : Text('Edit'))
          ],
        ),
      ),
    );
  }
}
