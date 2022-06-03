import 'package:flutter/material.dart';
import 'package:playground/providers/todo.dart';
import 'package:playground/providers/todo_list.dart';
import 'package:provider/provider.dart';

class TodoForm extends StatefulWidget {
  final bool isCreate;
  const TodoForm({Key? key, required this.isCreate}) : super(key: key);

  @override
  State<TodoForm> createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (!widget.isCreate) {
      Provider.of<Todo>(context, listen: false).fetchData(context);
      controller.text = Provider.of<Todo>(context, listen: false).text ?? '';
    }
  }

  Future loadData() async {
    if (!widget.isCreate) {
      await Provider.of<Todo>(context, listen: false).fetchData(context);
      controller.text = Provider.of<Todo>(context, listen: false).text ?? '';
    }
  }

  void trySubmit() {
    _formKey.currentState?.save();
    final isValid = _formKey.currentState?.validate();

    if (isValid == null || !isValid) {
      return;
    }

    if (widget.isCreate) {
      Provider.of<TodoList>(context, listen: false).addData(controller.text);
    } else {
      Provider.of<Todo>(context, listen: false)
          .updateText(context, controller.text);
      Provider.of<TodoList>(context, listen: false).fetchData();
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Render -> Todo Form');
    return FutureBuilder(
      future: loadData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

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
                  child:
                      widget.isCreate ? const Text('Add') : const Text('Edit'),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
