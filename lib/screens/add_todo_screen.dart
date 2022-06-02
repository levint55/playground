import 'package:flutter/material.dart';
import 'package:playground/providers/todo_list.dart';
import 'package:provider/provider.dart';

class AddTodoScreen extends StatefulWidget {
  static const routeName = '/add-todo';
  const AddTodoScreen({Key? key}) : super(key: key);

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _text = '';

  Future trySubmit() async {
    _formKey.currentState?.save();
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();

    if (isValid == null || !isValid) {
      return;
    }

    await Provider.of<TodoList>(context, listen: false).addData(_text);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo'),
      ),
      body: SingleChildScrollView(
        child: Form(
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
        ),
      ),
    );
  }
}
