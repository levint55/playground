import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  String? _userEmail = '';
  String? _userPassword = '';
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  void trySubmit() async {
    UserCredential authResult;
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();

    if (isValid == null) {
      return;
    }

    if (isValid) {
      _formKey.currentState?.save();
      authResult = await _auth.signInWithEmailAndPassword(
        email: _userEmail ?? '',
        password: _userPassword ?? '',
      );

      print(authResult);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            decoration: InputDecoration(label: Text('Email')),
            keyboardType: TextInputType.emailAddress,
            validator: (input) {
              if (input == null) {
                return 'Input is null';
              }
              if (input.isEmpty || !input.contains('@')) {
                return 'Invalid email';
              }
              return null;
            },
            onSaved: (value) {
              _userEmail = value!.trim();
            },
          ),
          TextFormField(
            decoration: InputDecoration(label: Text('Password')),
            obscureText: true,
            validator: (input) {
              if (input == null) {
                return 'Input is null';
              }
              if (input.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
            onSaved: (value) {
              _userPassword = value!.trim();
            },
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: trySubmit,
            child: Text('Login'),
          )
        ],
      ),
    );
  }
}
