import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Todo {
  final String name;
  bool completed;
  Todo({required this.name, this.completed = false});

  @override
  String toString() {
    return '$name:$completed';
  }

  static Todo fromString(String todoString) {
    final parts = todoString.split(':');
    if (parts.length != 2) {
      throw FormatException('Invalid todo format: $todoString');
    }
    return Todo(name: parts[0], completed: parts[1].toLowerCase() == 'true');
  }
}
