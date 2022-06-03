import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:playground/providers/todo.dart';

class TodoList with ChangeNotifier {
  String? _id;
  String? _title;
  List<Todo> _items;
  bool? _isDone;

  TodoList(this._id, this._title, this._items, this._isDone);

  List<Todo> get items {
    return _items;
  }

  String? get title {
    return _title;
  }

  String? get id {
    return _id;
  }

  bool? get isDone {
    return _isDone;
  }

  set id(String? id) {
    _id = id;
  }

  set title(String? title) {
    _title = title;
  }

  set isDone(bool? isDone) {
    _isDone = isDone;
  }

  void setTodoList(String? id, String? title, bool? isDone) {
    this.id = id;
    this.title = title;
    this.isDone = isDone;
  }

  void toogleIsDone() {
    _isDone = !_isDone!;
  }

  double getProgressValue() {
    if (_items.isEmpty) {
      return 0;
    }

    int isCompletedCount =
        _items.where((element) => element.isCompleted).toList().length;

    double result = isCompletedCount / _items.length;
    return result;
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
