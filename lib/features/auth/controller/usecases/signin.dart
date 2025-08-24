import 'package:dart_either/dart_either.dart';
import 'package:todo_flutter/core/errors/failures/failure.dart';
import 'package:todo_flutter/features/auth/controller/repositories/auth_repository.dart';
import 'package:todo_flutter/features/auth/controller/usecases/params/signup_params.dart';

class SignInUseCase {
  final AuthRepository _repository;

  SignInUseCase(this._repository);

  Future<Either<Failure, bool>> call(SignUpParams params) async {
    return await _repository.signIn(params);
  }
}

