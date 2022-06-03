import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  String? get createdAt {
    return _createdAt;
  }

  String? get authorId {
    return _authorId;
  }

  bool get isCompleted {
    return _isCompleted;
  }

  set id(String? id) {
    _id = id;
  }

  void switchCompleted(String todoListId) async {
    _isCompleted = !_isCompleted;
    final data = {'isCompleted': _isCompleted};
    final user = FirebaseAuth.instance.currentUser;
    final newData = await FirebaseFirestore.instance
        .collection('users/${user!.uid}/todos/$todoListId/todo')
        .doc(_id)
        .update(data);

    notifyListeners();
  }
}
