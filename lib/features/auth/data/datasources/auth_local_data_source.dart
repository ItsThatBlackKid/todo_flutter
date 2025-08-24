import 'package:crypt/crypt.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_flutter/core/db/database_helper.dart';
import 'package:todo_flutter/core/errors/exceptions/exists_exception.dart';

abstract class AbstractAuthLocalDataSource {
  Future<void> signUp(String username, String password);
  Future<void> signIn(String username, String password);
}

class AuthLocalDataSource implements AbstractAuthLocalDataSource {
  final DatabaseHelper databaseHelper;

  AuthLocalDataSource({required this.databaseHelper});

  @override
  Future<void> signUp(String username, String password) async {
    final db = await databaseHelper.database;
    try {
      await db.insert('users', {
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
  Future<void> signIn(String username, String password) {
    // TODO: implement signIn
    throw UnimplementedError();
  }
}
