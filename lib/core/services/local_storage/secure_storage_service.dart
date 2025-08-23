import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:todo_flutter/core/services/local_storage/abstract_secure_storage_service.dart';

class SecureStorageService implements AbstractSecureStorageService {
  final FlutterSecureStorage _secureStorage;


  SecureStorageService({required FlutterSecureStorage secureStorage}) 
      : _secureStorage = secureStorage;

  @override
  Future<void> clear() {
    // TODO: implement clear
    return _secureStorage.deleteAll();
  }

  @override
  Future<String?> get(String key) {
    return _secureStorage.read(key: key);
  }

  @override
  Future<void> remove(String key) {
    return _secureStorage.delete(key: key);
  }

  @override
  Future<void> save(String key, String value) {
    return _secureStorage.write(key: key, value: value);
  }
}
