import 'package:flutter/material.dart';
import 'package:todo_flutter/main.dart';
import 'package:todo_flutter/models/todo_model.dart';
import 'package:todo_flutter/utils/storage_service.dart';

class TodoModel extends ChangeNotifier {
  final StorageService _storageService;
  TodoModel({StorageService? storageService})
    : _storageService = storageService ?? getIt<StorageService>() {
    loadTodos();
  }

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

  void saveTodos() async {
    await _storageService.set<List<String>>('todos', toStringList());
  }

  void loadTodos() {
    final todoStrings = _storageService.get<List<String>>('todos') ?? [];
    fromStringList(todoStrings);
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
