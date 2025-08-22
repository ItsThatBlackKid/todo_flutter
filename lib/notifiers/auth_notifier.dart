import 'dart:convert';

import 'package:crypt/crypt.dart';
import 'package:flutter/material.dart';
import 'package:todo_flutter/main.dart';
import 'package:todo_flutter/models/user_model.dart';
import 'package:todo_flutter/utils/storage_service.dart';
import 'package:uuid/uuid.dart';

class AuthNotifier extends ChangeNotifier {
  final StorageService _storageService;

  AuthNotifier({StorageService? storageService})
    : _storageService = storageService ?? getIt<StorageService>() {
    init();
  }

  bool _isAuthenticated = false;
  User? _currentUser;

  bool get isAuthenticated => _isAuthenticated;
  User? get currentUser => _currentUser;

  set isAuthenticated(bool value) {
    if (_isAuthenticated != value) {
      _isAuthenticated = value;
      notifyListeners();
    }
  }

  set currentUser(User? user) {
    if (_currentUser != user) {
      _currentUser = user;
      notifyListeners();
    }
  }

  Future<void> init() async {
    final userString = await _storageService.readSecureData('current_user');
    if (userString != null) {
      _currentUser = User.fromJson(jsonDecode(userString));
      _isAuthenticated = true;
    }
  }

  Future<void> _storeUserWithPassword(UserWithPassword user) async {
    var userListString = await _storageService.readSecureData('user') ?? '';
    var userList = userListString.isNotEmpty
        ? UserWithPassword.fromJsonList(userListString)
        : [];

    userList.add(user);

    await _storageService.saveSecure('user', jsonEncode(userList));
  }

  Future<void> _storeCurrentUser() async {
    if (_currentUser != null) {
      await _storageService.saveSecure(
        'current_user',
        jsonEncode(_currentUser!.toJson()),
      );
    }
  }

  Future<void> signup(String username, String password) async {
    // Simulate a signup process
    UserWithPassword user = UserWithPassword(
      id: Uuid().v4(),
      username: username,
      password: Crypt.sha256(password).hash,
    );

    await _storeUserWithPassword(user);

    _currentUser = User(id: user.id, username: user.username);

    _storeCurrentUser();

    _isAuthenticated = true;
    notifyListeners();
  }
}
