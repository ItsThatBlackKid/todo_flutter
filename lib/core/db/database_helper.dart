import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:todo_flutter/core/db/database_model.dart';

class DatabaseHelper {
  
  static Database? db;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  static final DatabaseHelper _instance = Database._internal();

  Future<Database> get database async {
    if (db != null) return db!;
    db = await _initDatabase();
    return db!;
  }

  // setup db
  Future<Database> _initDatabase() async {
    return await openDatabase('todo.db', version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    // Create tables

    // create todo
    await db.execute(''' 
          CREATE TABLE tasks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT,
            completed INTEGER
          )
        ''');

    // create user table

    await db.execute('''
        create table users (
          id TEXT PRIMARY KEY,
          username TEXT UNIQUE NOT NULL,
          password TEXT NOT NULL
        )
      ''');
  }

  Future<void> insert<T extends DatabaseModel>(T data) async {
    final dbClient = await database;
    await dbClient.insert(
      data.tableName,
      data.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
