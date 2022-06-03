import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:playground/providers/todo.dart';

class TodoList with ChangeNotifier {
  String? id;
  String? title;
  List<Todo> _items;
  bool? isDone;

  TodoList(this.id, this.title, this._items, this.isDone);

  List<Todo> get items {
    return _items;
  }

  void setTodoList(String? id, String? title, bool? isDone) {
    this.id = id;
    this.title = title;
    this.isDone = isDone;
  }

  void toogleIsDone() {
    isDone = !isDone!;
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
          .collection('users/${user.uid}/todos/$id/todo')
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
        .collection('users/${user!.uid}/todos/$id/todo')
        .doc(id)
        .delete();

    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  Future fetchData() async {
    final user = FirebaseAuth.instance.currentUser;
    final snapshot = await FirebaseFirestore.instance
        .collection('users/${user!.uid}/todos/$id/todo')
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
