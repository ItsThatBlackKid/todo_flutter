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

class TodoModel extends ChangeNotifier {
  final List<Todo> _todos = [];

  int get length => _todos.length;
  List<Todo> get todos => _todos;

  void addTodo(String name) {
    _todos.add(Todo(name: name));
    notifyListeners();
  }

  void toggleCompleted(int index) {
    if (index >= 0 && index < _todos.length) {
      _todos[index].completed = !_todos[index].completed;
      notifyListeners();
    }
  }

  void removeTodo(int index) {
    if (index >= 0 && index < _todos.length) {
      _todos.removeAt(index);
      notifyListeners();
    }
  }

  void clearTodos() {
    _todos.clear();
    notifyListeners();
  }

  Todo getTodoAt(int index) {
    if (index >= 0 && index < _todos.length) {
      return _todos[index];
    }
    throw RangeError.index(index, _todos, 'index', null, _todos.length);
  }

  List<String> toStringList() {
    return _todos.map((todo) => todo.toString()).toList();
  }

  void fromStringList(List<String> todoStrings) {
    _todos.clear();
    for (var todoString in todoStrings) {
      try {
        _todos.add(Todo.fromString(todoString));
      } catch (e) {
        print('Error parsing todo: $todoString');
      }
    }
    notifyListeners();
  }
}
