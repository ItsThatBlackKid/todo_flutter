import 'package:dart_either/dart_either.dart';
import 'package:todo_flutter/core/errors/failures/failure.dart';
import 'package:todo_flutter/features/auth/controller/repositories/auth_repository.dart';
import 'package:todo_flutter/features/auth/controller/usecases/params/signup_params.dart';

class SignUpUseCase {
  final AuthRepository _repository;

  SignUpUseCase(this._repository);

  Future<Either<Failure, void>> call(SignUpParams params) async {
    return await _repository.signUp(params);
  }
}

