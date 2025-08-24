import 'package:dart_either/dart_either.dart';
import 'package:todo_flutter/core/errors/errors.dart';
import 'package:todo_flutter/features/auth/controller/usecases/params/signup_params.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> signUp(SignUpParams params);
}
