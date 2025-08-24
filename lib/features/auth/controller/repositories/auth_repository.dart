import 'package:dart_either/dart_either.dart';
import 'package:todo_flutter/core/errors/errors.dart';
import 'package:todo_flutter/features/auth/controller/entities/user.dart';
import 'package:todo_flutter/features/auth/controller/usecases/params/signup_params.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> signUp(SignUpParams params);
  Future<Either<Failure, bool>> signIn(SignUpParams params);
  Future<Either<Failure,User>> getUserFromToken();
  Future<void> signOut();
  Future<bool> isAuthenticated();
}
