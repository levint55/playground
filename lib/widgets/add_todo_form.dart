import 'package:flutter/material.dart';

class AddTodoForm extends StatefulWidget {
  const AddTodoForm({Key? key}) : super(key: key);

  @override
  State<AddTodoForm> createState() => _AddTodoFormState();
}

class _AddTodoFormState extends State<AddTodoForm> {
  final _formKey = GlobalKey<FormState>();
  String? _text = '';

  void trySubmit() {
    _formKey.currentState?.save();
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();

    if (isValid == null || !isValid) {
      return;
    }

    Navigator.of(context).pop(_text);
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
                _text = input!.trim();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: trySubmit, child: const Text('Add'))
          ],
        ),
      ),
    );
  }
}
