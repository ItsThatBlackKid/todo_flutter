import 'dart:convert';

class User {
  User({required this.id, required this.username});

  final String id;
  final String username;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      username: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': username};
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
}

class UserWithPassword extends User {
  UserWithPassword({
    required super.id,
    required super.username,
    required this.password,
  });

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

  factory UserWithPassword.fromJson(Map<String, dynamic> json) {
    return UserWithPassword(
      id: json['id'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
    );
  }
  

  static UserWithPassword fromString(String userString) {
    final parts = userString.split(':');
    if (parts.length != 4) {
      throw FormatException('Invalid user with password format: $userString');
    }
    return UserWithPassword(
      id: parts[0],
      username: parts[1],
      password: parts[3],
    );
  }


  static List<UserWithPassword> fromJsonList(String jsonString) {
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => UserWithPassword.fromJson(json)).toList();
  }
  
}
