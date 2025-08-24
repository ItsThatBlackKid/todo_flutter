import 'dart:convert';

import 'package:todo_flutter/core/db/database_model.dart';

class UserModel implements DatabaseModel {
  UserModel({
    required this.id,
    required this.username,
    required this.password
  });

  final String id;
  final String username;
  final String password;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(id: json['id'] as String, username: json['username'] as String, password: json['password']);
  }

  @override
  String toString() {
    return '$id:$username';
  }

  static UserModel fromString(String userString) {
    final parts = userString.split(':');
    if (parts.length != 3) {
      throw FormatException('Invalid user format: $userString');
    }
    return UserModel(id: parts[0], username: parts[1], password: parts[2]);
  }

  static List<UserModel> fromJsonList(String jsonString) {
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => UserModel.fromJson(json)).toList();
  }

  List<UserModel> fromMapList(List<Map<String, Object?>> map) {
    const List<UserModel> users = [];

    for (var user in map) {
      users.add(UserModel.fromMap(user));
    }

    return users;
  }

  @override
  List<Object?> get props => [id, username];

  @override
  bool? get stringify => true;

  @override
  String get tableName => 'users';

  @override
  Map<String, Object?> toMap() {
    return {id: id, username: username};
  }

  UserModel.fromMap(Map<String, Object?> map)
    : id = map['id'] as String,
      username = map['username'] as String,
      password = map['password'] as String;
}
