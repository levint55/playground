import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:playground/dummy_data.dart';
import 'package:playground/providers/auth.dart';
import 'package:playground/widgets/todo_slider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Logout'),
              leading: const Icon(Icons.logout),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Provider.of<Auth>(context, listen: false).logout();
              },
            )
          ],
        ),
      ),
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: TodoSlider(),
      ),
    );
  }
}
