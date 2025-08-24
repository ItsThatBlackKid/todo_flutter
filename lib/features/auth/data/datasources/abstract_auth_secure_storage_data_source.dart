import 'package:todo_flutter/features/auth/controller/entities/user.dart';

abstract class AbstractAuthSecureStorageDataSource {
  Future<String?> getToken();
  Future<void> saveToken(String token);
  Future<void> removeToken();
  Future<void> clear();
  Future<String> createToken(final User user);
}
