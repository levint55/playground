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
  String? _userConfirmPassword = '';
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  bool _isLogin = true;

  void trySubmit() async {
    // UserCredential authResult;
    _formKey.currentState?.save();
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();

    if (isValid == null) {
      return;
    }

    if (isValid) {
      try {
        if (_isLogin) {
          await _auth.signInWithEmailAndPassword(
            email: _userEmail ?? '',
            password: _userPassword ?? '',
          );
        } else {
          await _auth.createUserWithEmailAndPassword(
            email: _userEmail ?? '',
            password: _userConfirmPassword ?? '',
          );
        }
      } catch (e) {
        // TODO: Add error handler
        rethrow;
      }
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
            key: const ValueKey('email'),
            decoration: const InputDecoration(label: Text('Email')),
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
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          TextFormField(
            key: const ValueKey('password'),
            decoration: const InputDecoration(label: Text('Password')),
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
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          if (!_isLogin)
            TextFormField(
              key: const ValueKey('confirmPassword'),
              decoration:
                  const InputDecoration(label: Text('Confirm Password')),
              obscureText: true,
              validator: (input) {
                if (input == null) {
                  return 'Input is null';
                }
                if (input != _userPassword) {
                  return 'Password didnt match';
                }
                return null;
              },
              onSaved: (value) {
                _userConfirmPassword = value!.trim();
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: trySubmit,
            child: _isLogin ? const Text('Login') : const Text('Register'),
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
              onPressed: () {
                setState(() {
                  _isLogin = !_isLogin;
                });
              },
              child: _isLogin
                  ? const Text('Dont have an account?')
                  : const Text('Already have an account?'))
        ],
      ),
    );
  }
}
