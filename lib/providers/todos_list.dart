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

  Future fetchData([bool isCompleted = false]) async {
    //TODO: error handling
    final user = FirebaseAuth.instance.currentUser;
    var query = FirebaseFirestore.instance
        .collection('users/${user!.uid}/todos')
        .orderBy("createdAt", descending: false);

    if (isCompleted) {
      query = query.where('markAsDone', isEqualTo: true);
    }

    final snapshot = await query.get();

    List<TodoList> newItems = snapshot.docs.map((element) {
      var data = element.data();
      return TodoList(element.id, data['title'], [], data['markAsDone']);
    }).toList();

    _items = newItems;

    notifyListeners();
  }

  Future markAsDone(String id) async {
    int existingElementIndex = _items.indexWhere((element) => element.id == id);
    _items[existingElementIndex].toogleIsDone();
    final user = FirebaseAuth.instance.currentUser;
    final data = {'markAsDone': _items[existingElementIndex].isDone};
    await FirebaseFirestore.instance
        .collection('users/${user!.uid}/todos')
        .doc(id)
        .update(data);

    notifyListeners();
  }

  Future addData(String? title) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final data = {
        'title': title,
        'createdAt': Timestamp.now(),
        'markAsDone': false,
        'length': 0,
        'progress': 0,
      };
      final newData = await FirebaseFirestore.instance
          .collection('users/${user!.uid}/todos')
          .add(data);

      _items.add(TodoList(newData.id, title, [], false));

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
