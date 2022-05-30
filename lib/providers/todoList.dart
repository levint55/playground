import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:playground/providers/todo.dart';

class TodoList with ChangeNotifier {
  final String? _id;
  final String? _title;
  final List<Todo> _items;

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

  void addData() async {
    // try {
    //     final user = FirebaseAuth.instance.currentUser;
    //     final data = {'title': _title, 'createdAt': Timestamp.now()};
    //     await FirebaseFirestore.instance
    //         .collection('users/${user!.uid}/todos')
    //         .add(data);
    //   } catch (e) {
    //     print(e);
    //   }
  }
}
