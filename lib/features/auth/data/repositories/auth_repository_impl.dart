import 'package:dart_either/dart_either.dart';
import 'package:todo_flutter/core/errors/exceptions/exists_exception.dart';
import 'package:todo_flutter/core/errors/failures/failure.dart';
import 'package:todo_flutter/core/errors/failures/unexpected_failure.dart';
import 'package:todo_flutter/features/auth/controller/repositories/auth_repository.dart';
import 'package:todo_flutter/features/auth/controller/usecases/params/signup_params.dart';
import 'package:todo_flutter/features/auth/data/datasources/auth_local_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, void>> signUp(SignUpParams params) async {
    // Implementation of signUp logic goes here
    // This is a placeholder for the actual implementation

    try {
      await localDataSource.signUp(params.username, params.password);
      return Right(null);
    } on ExistsException catch (e) {
      return Left(UnexpectedFailure(message: e.message));
    } catch (e) {
      return Left(
        UnexpectedFailure(message: 'An unexpected error occurred: $e'),
      );
    }
  }
}
