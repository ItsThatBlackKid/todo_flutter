import 'package:flutter/material.dart';
import 'package:todo_flutter/core/utils/view_state.dart';
import 'package:todo_flutter/features/auth/controller/usecases/params/signup_params.dart';
import 'package:todo_flutter/features/auth/controller/usecases/signin.dart';

class SigninNotifier extends ChangeNotifier {
  final SignInUseCase _signInUseCase;

  SigninNotifier({required SignInUseCase signInUseCase})
    : _signInUseCase = signInUseCase;

  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  String _errorMsg = '';
  String get errorMsg => _errorMsg;

  void _setError(String message) {
    _errorMsg = message;
    _setState(ViewState.erorr);
  }

  Future<void> signUp({
    required String username,
    required String password,
  }) async {
    final params = SignUpParams(username: username, password: password);
    final result = await _signInUseCase(params);

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
}
