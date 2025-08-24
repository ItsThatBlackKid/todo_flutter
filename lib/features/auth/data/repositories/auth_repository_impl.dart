import 'package:dart_either/dart_either.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:todo_flutter/core/errors/errors.dart';
import 'package:todo_flutter/core/errors/exceptions/exists_exception.dart';
import 'package:todo_flutter/core/errors/failures/token_not_found_failure.dart';
import 'package:todo_flutter/core/errors/failures/unexpected_failure.dart';
import 'package:todo_flutter/features/auth/controller/entities/user.dart';
import 'package:todo_flutter/features/auth/controller/repositories/auth_repository.dart';
import 'package:todo_flutter/features/auth/controller/usecases/params/signup_params.dart';
import 'package:todo_flutter/features/auth/data/datasources/abstract_auth_secure_storage_data_source.dart';
import 'package:todo_flutter/features/auth/data/datasources/auth_local_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AbstractAuthLocalDataSource localDataSource;
  final AbstractAuthSecureStorageDataSource secureStorageDataSource;

  AuthRepositoryImpl(this.localDataSource, this.secureStorageDataSource);

  @override
  Future<Either<Failure, void>> signUp(SignUpParams params) async {
    // Implementation of signUp logic goes here
    // This is a placeholder for the actual implementation

    try {
      var user = await localDataSource.signUp(params.username, params.password);
      await secureStorageDataSource.createToken(user);
      return Right(null);
    } on ExistsException catch (e) {
      return Left(UnexpectedFailure(message: e.message));
    } catch (e) {
      return Left(
        UnexpectedFailure(message: 'An unexpected error occurred: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> signIn(SignUpParams params) async {
    try {
      final user = await localDataSource.signIn(
        params.username,
        params.password,
      );
      await secureStorageDataSource.createToken(user);
      return Right(true);
    } on ArgumentError catch (e) {
      return Right(false);
    } on NotFoundException catch (e) {
      return Right(false);
    } catch (e) {
      return Left(UnexpectedFailure(message: 'Unexpected error occurred: $e'));
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    final token = await secureStorageDataSource.getToken();
    return token != null;
  }

  @override
  Future<void> signOut() async {
    await secureStorageDataSource.removeToken();
  }

  @override
  Future<Either<Failure, User>> getUserFromToken() async {
    var token = await secureStorageDataSource.getToken();

    if (token == null) {
      return Left(TokenNotFoundFailure(message: "no token found"));
    }

    final jwt = JWT.decode(token);
    return Right(User.fromMap(jwt.payload['user']));
  }
}
