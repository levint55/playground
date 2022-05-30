import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String? _userEmail = '';
  String? _userPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            validator: (input) {
              if (input == null) {
                return 'Input is null';
              }
              if (EmailValidator.validate(input)) {
                return 'Invalid email';
              }
              return null;
            },
            onSaved: (value) {
              _userEmail = value;
            },
          ),
          TextFormField(
            obscureText: true,
            validator: (input) {
              if (input == null) {
                return 'Input is null';
              }
              if (input.length <= 4) {
                return 'Password must be at least 5 characters';
              }
              return null;
            },
            onSaved: (value) {
              _userPassword = value;
            },
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('Login'),
          )
        ],
      ),
    ));
  }
}
