import 'package:flutter/material.dart';
import 'package:todo_flutter/core/utils/view_state.dart';
import 'package:todo_flutter/di/service_locator.dart';
import 'package:todo_flutter/features/auth/controller/entities/user.dart';
import 'package:todo_flutter/features/auth/controller/repositories/auth_repository.dart';
import 'package:todo_flutter/features/auth/controller/usecases/params/signup_params.dart';

class AuthNotifier extends ChangeNotifier {
  ViewState _state = ViewState.idle;
  ViewState get state => _state;

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
          _isAuthenticated = true;
          _currentUser = user;
        },
      );
    }
    notifyListeners();
  }

  String _errorMsg = '';
  String get errorMsg => _errorMsg;

  Future<bool> signUp(String username, String password) async {
    final params = SignUpParams(username: username, password: password);
    final result = await _authRepository.signUp(params);

    bool val = false;

    result.fold(
      ifLeft: (failure) {
        _setError(failure.message);
      },
      ifRight: (_) {
        _isAuthenticated = true;
        _setState(ViewState.success);
        val = true;
      },
    );

    notifyListeners();
    return val;
  }

  Future<void> signIn(String username, String password) async {
    final params = SignUpParams(username: username, password: password);
    final result = await _authRepository.signIn(params);

    result.fold(
      ifLeft: (failure) {
        _setError("Unexpected error, please try again.");
      },
      ifRight: (result) {
        if (result == true) {
          _setState(ViewState.success);
        } else {
          _setError("Username or password is invalid");
        }
      },
    );
  }

  void _setState(ViewState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> _checkAuthStatus() async {
    _isAuthenticated = await _authRepository.isAuthenticated();
    notifyListeners();
  }

  void _setError(String message) {
    _errorMsg = message;
    _setState(ViewState.erorr);
  }
}
