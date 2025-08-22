
import 'package:flutter/material.dart';
import 'package:todo_flutter/models/user_model.dart';

class AuthNotifier extends ChangeNotifier {
  bool _isAuthenticated = false;
  User? _currentUser;

  bool get isAuthenticated => _isAuthenticated;
  User? get currentUser => _currentUser;

  set isAuthenticated(bool value) {
    if (_isAuthenticated != value) {
      _isAuthenticated = value;
      notifyListeners();
    }
  }

  set currentUser(User? user) {
    if (_currentUser != user) {
      _currentUser = user;
      notifyListeners();
    }
  }
}