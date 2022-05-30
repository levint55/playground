import 'package:flutter/material.dart';

class Auth with ChangeNotifier {
  String? userId = '';

  Auth(this.userId);

  String? get getUserId {
    return userId;
  }

  void setUserId(String? userId) {
    this.userId = userId;
  }

  void logout() {
    userId = null;
  }
}
