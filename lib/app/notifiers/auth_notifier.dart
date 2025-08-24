import 'package:flutter/material.dart';
import 'package:todo_flutter/di/service_locator.dart';
import 'package:todo_flutter/features/auth/controller/entities/user.dart';
import 'package:todo_flutter/features/auth/controller/repositories/auth_repository.dart';

class AuthNotifier extends ChangeNotifier {
  final AuthRepository _authRepository = serviceLocator<AuthRepository>();

  AuthNotifier() {
    init();
  }

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

  Future<void> init() async {
    if (await _authRepository.isAuthenticated()) {
      var result = await _authRepository.getUserFromToken();

      result.fold(
        ifLeft: (_) {
          _isAuthenticated = false;
        },
        ifRight: (user) {
          _currentUser = user;
        },
      );
    }
    notifyListeners();
  }

  Future<void> _checkAuthStatus() async {
    _isAuthenticated = await _authRepository.isAuthenticated();
    notifyListeners();
  }
}
