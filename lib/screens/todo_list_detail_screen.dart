import 'package:flutter/material.dart';

class TodoListDetailScreen extends StatelessWidget {
  static const routeName = '/todos-detail';
  const TodoListDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
      ),
      body: const Center(child: Text('example')),
    );
  }
}
