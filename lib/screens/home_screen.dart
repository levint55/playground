import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:playground/screens/add_todo_list_screen.dart';
import 'package:playground/widgets/todo_slider.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: Theme.of(context).primaryColor),
        child: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AddTodoListScreen.routeName);
          },
          icon: const Icon(Icons.add),
          color: Colors.white,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Logout'),
              leading: const Icon(Icons.logout),
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
            )
          ],
        ),
      ),
      appBar: AppBar(title: const Text('Home')),
      body: const Center(
        child: TodoSlider(),
      ),
    );
  }
}
