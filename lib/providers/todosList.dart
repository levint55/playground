import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:playground/providers/todoList.dart';

class TodosList with ChangeNotifier {
  final List<TodoList> _items;

  TodosList(this._items);

  void fetchData() async {
    // final user = FirebaseAuth.instance.currentUser;
    // final response = await FirebaseFirestore.instance
    //     .collection('users/${user!.uid}/todos')
    //     .get();

    // var temp = [];
  }
}
