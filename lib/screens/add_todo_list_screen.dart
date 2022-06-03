import 'package:flutter/material.dart';
import 'package:playground/providers/todos_list.dart';
import 'package:provider/provider.dart';

class AddTodoListScreen extends StatefulWidget {
  static const routeName = '/add-todo-list';

  const AddTodoListScreen({Key? key}) : super(key: key);

  @override
  State<AddTodoListScreen> createState() => _AddTodoListScreenState();
}

class _AddTodoListScreenState extends State<AddTodoListScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _title = '';

  void trySubmit() async {
    _formKey.currentState?.save();
    var isValid = _formKey.currentState?.validate();

    if (isValid == null) {
      return;
    }

    if (isValid) {
      Provider.of<TodosList>(context, listen: false).addData(_title);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Render -> Add Todo List Screen');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo List'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(label: Text('title')),
                    validator: (value) {
                      if (value == null) {
                        return 'Input is null';
                      }
                      if (value.isEmpty) {
                        return 'Please enter title';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _title = value;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(onPressed: trySubmit, child: const Text('Add'))
                ]),
          ),
        ),
      ),
    );
  }
}
