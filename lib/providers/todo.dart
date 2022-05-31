import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:playground/providers/todoList.dart';
import 'package:provider/provider.dart';

class Todo with ChangeNotifier {
  String? _id;
  final String? _createdAt;
  final String? _authorId;
  final String? _text;
  bool _isCompleted = false;

  Todo(
      this._id, this._createdAt, this._authorId, this._text, this._isCompleted);

  String? get text {
    return _text;
  }

  String? get id {
    return _id;
  }

  void setId(String? id) {
    _id = id;
  }

  bool get isCompleted {
    return _isCompleted;
  }

  Future fetchData(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    final todosList = Provider.of<TodoList>(context, listen: false);
    final snapshot = await FirebaseFirestore.instance
        .collection('users/${user!.uid}/todos/${todosList.id}/todo/$_id')
        .get();
  }

  void switchCompleted() async {
    _isCompleted = !_isCompleted;
    final data = {'isCompleted': _isCompleted};
    final user = FirebaseAuth.instance.currentUser;
    final newData = await FirebaseFirestore.instance
        .collection('users/${user!.uid}/todos/$_id/todo')
        .doc(_id)
        .set(data);

    notifyListeners();
  }
}
