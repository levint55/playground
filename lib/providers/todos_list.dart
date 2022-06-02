import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:playground/providers/todo_list.dart';

class TodosList with ChangeNotifier {
  List<TodoList> _items;

  TodosList(this._items);

  List<TodoList> get items {
    return _items;
  }

  Future fetchData() async {
    //TODO: error handling
    final user = FirebaseAuth.instance.currentUser;
    final snapshot = await FirebaseFirestore.instance
        .collection('users/${user!.uid}/todos')
        .orderBy("createdAt", descending: false)
        .get();

    List<TodoList> newItems = snapshot.docs.map((element) {
      var data = element.data();
      return TodoList(element.id, data['title'], []);
    }).toList();

    _items = newItems;

    notifyListeners();
  }

  Future addData(String? title) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final data = {'title': title, 'createdAt': Timestamp.now()};
      final newData = await FirebaseFirestore.instance
          .collection('users/${user!.uid}/todos')
          .add(data);

      _items.add(TodoList(newData.id, title, []));

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
