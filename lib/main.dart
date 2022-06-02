import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:playground/providers/todos_list.dart';
import 'package:playground/screens/add_todo_list_screen.dart';
import 'package:playground/screens/add_todo_screen.dart';
import 'package:playground/screens/todo_list_detail_screen.dart';
import 'package:playground/screens/auth_screen.dart';
import 'package:playground/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TodosList>(
      create: (context) => TodosList([]),
      child: MaterialApp(
        title: 'Playground',
        home: StreamBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // insert SplashScreen
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              return const HomeScreen();
            }
            return const AuthScreen();
          },
          stream: FirebaseAuth.instance.authStateChanges(),
        ),
        routes: {
          AddTodoListScreen.routeName: (context) => const AddTodoListScreen(),
          AuthScreen.routeName: (context) => const AuthScreen(),
          TodoListDetailScreen.routeName: (context) =>
              const TodoListDetailScreen(),
          AddTodoScreen.routeName: (context) => const AddTodoScreen(),
        },
      ),
    );
  }
}
