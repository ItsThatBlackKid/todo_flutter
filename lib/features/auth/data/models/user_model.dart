import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:todo_flutter/core/db/database_model.dart';

class User implements DatabaseModel {
  const User({required this.id, required this.username});

  final String id;
  final String username;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['id'] as String, username: json['username'] as String);
  }

  @override
  Map<String, Object?> toJson() {
    return {'id': id, 'username': username};
  }

  @override
  String toString() {
    return '$id:$username';
  }

  static User fromString(String userString) {
    final parts = userString.split(':');
    if (parts.length != 3) {
      throw FormatException('Invalid user format: $userString');
    }
    return User(id: parts[0], username: parts[1]);
  }

  static List<User> fromJsonList(String jsonString) {
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => User.fromJson(json)).toList();
  }

  @override
  DatabaseModel fromJson(Map<String, Object?> json) {
    // TODO: implement fromJson
    return User(id: json['id'] as String, username: json['username'] as String);
  }

  @override
  DatabaseModel fromMap(Map<String, Object?> map) {
    // TODO: implement fromMap
    return User(id: map['id'] as String, username: map['username'] as String);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, username];

  @override
  // TODO: implement stringify
  bool? get stringify => true;

  @override
  // TODO: implement tableName
  String get tableName => 'users';

  @override
  Map<String, Object?> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }
}