import 'package:crypt/crypt.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_flutter/core/db/database_helper.dart';
import 'package:todo_flutter/core/errors/exceptions/exists_exception.dart';
import 'package:todo_flutter/core/errors/exceptions/not_found_exception.dart';
import 'package:todo_flutter/core/errors/failures/unexpected_failure.dart';
import 'package:todo_flutter/features/auth/controller/entities/user.dart';
import 'package:todo_flutter/features/auth/data/models/user_model.dart';
import 'package:uuid/uuid.dart';

abstract class AbstractAuthLocalDataSource {
  Future<void> signUp(String username, String password);
  Future<User> signIn(String username, String password);
}

class AuthLocalDataSource implements AbstractAuthLocalDataSource {
  final DatabaseHelper databaseHelper;

  AuthLocalDataSource({required this.databaseHelper});

  @override
  Future<void> signUp(String username, String password) async {
    final db = await databaseHelper.database;
    try {
      await db.insert('users', {
        'id': Uuid().v4(),
        'username': username,
        'password': Crypt.sha256(password).hash,
      }, conflictAlgorithm: ConflictAlgorithm.fail);
    } on DatabaseException catch (e) {
      print(e);

      if (e.isUniqueConstraintError()) {
        throw ExistsException('Username', username);
      } else {
        throw Exception('Failed to save...');
      }
    }
  }

  @override
  Future<User> signIn(String username, String password) async {
    if (username.isEmpty) {
      throw ArgumentError("Username is required.");
    }

    if (password.isEmpty) {
      throw ArgumentError("Password is required");
    }

    final db = await databaseHelper.database;

    try {
      List<Map<String, Object?>> users = await db.query(
        'users',
        where: '"username" = ?',
        whereArgs: [username],
      );

      if (users.isEmpty) {
        throw NotFoundException("User with username $username");
      }

      var user = UserModel.fromMap(users.first);

      if (!Crypt(user.password).match(password)) {
        throw ArgumentError("Email or password is invalid");
      }

      return _userFromModel(user);
    } on DatabaseException catch (e) {
      throw UnexpectedFailure(message: "Unexpected error occurred. Try again.");
    }
  }

  User _userFromModel(UserModel model) {
    return User(id: model.id, username: model.username);
  }
}
