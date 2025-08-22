import 'package:flutter/foundation.dart';

class User {
  User({required this.id, required this.name, required this.email});

  final String id;
  final String name;
  final String email;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email};
  }

  @override
  String toString() {
    return '$id:$name:$email';
  }

  static User fromString(String userString) {
    final parts = userString.split(':');
    if (parts.length != 3) {
      throw FormatException('Invalid user format: $userString');
    }
    return User(id: parts[0], name: parts[1], email: parts[2]);
  }
}

class UserWithPassword extends User {
  UserWithPassword({
    required String id,
    required String name,
    required String email,
    required this.password,
  }) : super(id: id, name: name, email: email);

  final String password;

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['password'] = password;
    return json;
  }

  @override
  String toString() {
    return '${super.toString()}:$password';
  }

  static UserWithPassword fromString(String userString) {
    final parts = userString.split(':');
    if (parts.length != 4) {
      throw FormatException('Invalid user with password format: $userString');
    }
    return UserWithPassword(
      id: parts[0],
      name: parts[1],
      email: parts[2],
      password: parts[3],
    );
  }
}
