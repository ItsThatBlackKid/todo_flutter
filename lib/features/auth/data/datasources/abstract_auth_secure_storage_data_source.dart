import 'package:todo_flutter/features/auth/data/models/user_model.dart';

abstract class AbstractAuthSecureStorageDataSource {
  Future<String?> getToken();
  Future<void> saveToken(String token);
  Future<void> removeToken();
  Future<void> clear();

  Future<User?> getUser(String username);

  Future<void> saveUser(User user);
}
