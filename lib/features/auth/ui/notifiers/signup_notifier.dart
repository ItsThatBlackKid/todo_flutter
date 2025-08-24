import 'package:flutter/material.dart';
import 'package:todo_flutter/core/utils/view_state.dart';
import 'package:todo_flutter/features/auth/controller/usecases/params/signup_params.dart';
import 'package:todo_flutter/features/auth/controller/usecases/signup.dart';

class SignupNotifier extends ChangeNotifier {
  final SignUpUseCase _signUpUseCase;

  SignupNotifier({required SignUpUseCase signupUseCase})
    : _signUpUseCase = signupUseCase;

  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  String _errorMsg = '';
  String get errorMsg => _errorMsg;

  Future<void> signUp({
    required String username,
    required String password,
  }) async {
    final params = SignUpParams(username: username, password: password);
    final result = await _signUpUseCase(params);

    result.fold(
      ifLeft: (failure) {
        _errorMsg = failure.message;
      },
      ifRight: (_) {
        _setState(ViewState.success);
      },
    );
  }

  void _setState(ViewState newState) {
    _state = newState;
    notifyListeners();
  }
}
