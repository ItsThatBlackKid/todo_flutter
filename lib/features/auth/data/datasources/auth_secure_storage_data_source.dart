

import 'package:todo_flutter/core/services/local_storage/abstract_secure_storage_service.dart';
import 'package:todo_flutter/features/auth/data/datasources/abstract_auth_secure_storage_data_source.dart';
import 'package:todo_flutter/features/auth/data/models/user_model.dart';

class AuthSecureStorageDataSource implements AbstractAuthSecureStorageDataSource {
  final AbstractSecureStorageService _secureStorageService;

  AuthSecureStorageDataSource(this._secureStorageService);

  @override
  Future<String?> getToken() {
    return _secureStorageService.get('auth_token');
  }

  @override
  Future<void> saveToken(String token) {
    return _secureStorageService.save('auth_token', token);
  }

  @override
  Future<void> removeToken() {
    return _secureStorageService.remove('auth_token');
  }
  
  @override
  Future<void> clear() {
    return _secureStorageService.clear();
  }


  @override
  Future<void> saveUser(User user) {
    // TODO: implement saveUser
    throw UnimplementedError();
  }
  
  @override
  Future<User?> getUser(String username) {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  
}