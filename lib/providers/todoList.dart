import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:playground/providers/todo.dart';

class TodoList with ChangeNotifier {
  final String? _id;
  final String? _title;
  List<Todo> _items;

  TodoList(this._id, this._title, this._items);

  List<Todo> get items {
    return _items;
  }

  String? get title {
    return _title;
  }

  double getProgressValue() {
    //TODO: Add logic
    return 0.5;
  }

  void addData() async {}

  Future fetchData() async {
    final user = FirebaseAuth.instance.currentUser;
    final snapshot = await FirebaseFirestore.instance
        .collection('users/${user!.uid}/todos/$_id/todo')
        .get();

    List<Todo> newItems = snapshot.docs.map((element) {
      var data = element.data();
      return Todo(
          element.id, DateTime.now().toIso8601String(), user.uid, data['text']);
    }).toList();

    _items = newItems;

    notifyListeners();
  }
}
