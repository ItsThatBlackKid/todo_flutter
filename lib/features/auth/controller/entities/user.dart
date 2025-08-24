import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class User extends Equatable {
  final String id;
  final String username;

  const User({required this.id, required this.username});

  Map<String, String> toMap() {
    return {'id': id, 'username': username};
  }

  User.fromMap(Map<String, String> map)
    : id = map['id']!,
      username = map['username']!;

  @override
  List<Object?> get props => [id, username];
}
