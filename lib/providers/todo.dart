import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:playground/providers/todo_list.dart';
import 'package:provider/provider.dart';

class Todo with ChangeNotifier {
  String? id;
  final String? _createdAt;
  final String? _authorId;
  String? text;
  bool _isCompleted = false;

  Todo(this.id, this._createdAt, this._authorId, this.text, this._isCompleted);

  String? get createdAt {
    return _createdAt;
  }

  String? get authorId {
    return _authorId;
  }

  bool get isCompleted {
    return _isCompleted;
  }

  Future fetchData(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    final todoListId = Provider.of<TodoList>(context, listen: false).id;
    final snapshot = await FirebaseFirestore.instance
        .collection('users/${user!.uid}/todos/$todoListId/todo')
        .doc(id)
        .get();

    var data = snapshot.data();
    text = data!['text'];

    notifyListeners();
  }

  void updateText(BuildContext context, String newText) async {
    final user = FirebaseAuth.instance.currentUser;
    final data = {'text': newText};
    final todoListId = Provider.of<TodoList>(context, listen: false).id;
    await FirebaseFirestore.instance
        .collection('users/${user!.uid}/todos/$todoListId/todo')
        .doc(id)
        .update(data);

    text = newText;

    notifyListeners();
  }

  void switchCompleted(BuildContext context) async {
    _isCompleted = !_isCompleted;
    final data = {'isCompleted': _isCompleted};
    final user = FirebaseAuth.instance.currentUser;
    final todoListId = Provider.of<TodoList>(context, listen: false).id;
    await FirebaseFirestore.instance
        .collection('users/${user!.uid}/todos/$todoListId/todo')
        .doc(id)
        .update(data);

    notifyListeners();
  }
}
