import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:playground/providers/todo.dart';

class TodoList with ChangeNotifier {
  String? _id;
  final String? _title;
  List<Todo> _items;

  TodoList(this._id, this._title, this._items);

  List<Todo> get items {
    return _items;
  }

  String? get title {
    return _title;
  }

  String? get id {
    return _id;
  }

  void setId(String? id) {
    _id = id;
  }

  double getProgressValue() {
    //TODO: Add logic
    return 0.5;
  }

  Future addData(String? text) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final createdAt = DateTime.now().toIso8601String();
      final data = {
        'text': text,
        'createdAt': Timestamp.now(),
        'authodId': user!.uid,
        'isCompleted': false
      };
      final newData = await FirebaseFirestore.instance
          .collection('users/${user.uid}/todos/$_id/todo')
          .add(data);

      _items.add(Todo(newData.id, createdAt, user.uid, text, false));

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future deleteData(String id) async {
    final user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('users/${user!.uid}/todos/$_id/todo')
        .doc(id)
        .delete();

    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  Future fetchData() async {
    final user = FirebaseAuth.instance.currentUser;
    final snapshot = await FirebaseFirestore.instance
        .collection('users/${user!.uid}/todos/$_id/todo')
        .orderBy("createdAt", descending: false)
        .get();

    List<Todo> newItems = snapshot.docs.map((element) {
      var data = element.data();
      return Todo(element.id, DateTime.now().toIso8601String(), user.uid,
          data['text'], data['isCompleted'] ?? false);
    }).toList();

    _items = newItems;

    notifyListeners();
  }
}
