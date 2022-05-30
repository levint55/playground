import 'package:flutter/material.dart';
import 'package:playground/widgets/auth_form.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Card(
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: AuthForm(),
            ),
          ),
        ),
      ),
    );
  }
}
