import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:playground/providers/todos_list.dart';
import 'package:playground/screens/add_todo_list_screen.dart';
import 'package:playground/widgets/todo_slider.dart';
import 'package:provider/provider.dart';

enum FilterOptions {
  isDone,
  all,
}

class HomeScreen extends StatefulWidget {
  static const routeName = '/';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _filterCompleted = false;

  @override
  Widget build(BuildContext context) {
    debugPrint('Render -> Home Screen');
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
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions value) {
              setState(() {
                if (value == FilterOptions.all) {
                  _filterCompleted = false;
                  Provider.of<TodosList>(context, listen: false)
                      .fetchData(_filterCompleted);
                } else if (value == FilterOptions.isDone) {
                  _filterCompleted = true;
                  Provider.of<TodosList>(context, listen: false)
                      .fetchData(_filterCompleted);
                }
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.all,
              ),
              const PopupMenuItem(
                child: Text('Completed'),
                value: FilterOptions.isDone,
              )
            ],
          )
        ],
      ),
      body: Center(
        child: TodoSlider(isCompleted: _filterCompleted),
      ),
    );
  }
}
