import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text('Logout'),
              leading: Icon(Icons.logout),
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
            )
          ],
        ),
      ),
      appBar: AppBar(title: Text('Home')),
      body: Container(),
    );
  }
}
