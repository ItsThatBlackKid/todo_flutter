import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  StorageService._internal();

  static final StorageService _instance = StorageService._internal();

  factory StorageService() {
    return _instance;
  }

  late SharedPreferences _sharedPreferences;
  late FlutterSecureStorage _secureStorage;
  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _secureStorage = FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    );
  }

  // Shared Preferences methods
  T? get<T>(String key) {
    return _sharedPreferences.get(key) as T?;
  }

  Future<bool> set<T>(String key, T value) {
    if (value is String) {
      return _sharedPreferences.setString(key, value);
    } else if (value is int) {
      return _sharedPreferences.setInt(key, value);
    } else if (value is double) {
      return _sharedPreferences.setDouble(key, value);
    } else if (value is bool) {
      return _sharedPreferences.setBool(key, value);
    } else if (value is List<String>) {
      return _sharedPreferences.setStringList(key, value);
    }
    throw ArgumentError('Unsupported type: ${value.runtimeType}');
  }

  Future<bool> remove(String key) {
    return _sharedPreferences.remove(key);
  }

  Future<bool> clear() {
    return _sharedPreferences.clear();
  }

  // Secure Storage methods
  Future<String?> readSecureData(String key) {
    return _secureStorage.read(key: key);
  }

  Future<void> saveSecure(String key, String value) {
    return _secureStorage.write(key: key, value: value);
  }

  Future<void> deleteSecure(String key) {
    return _secureStorage.delete(key: key);
  }

  Future<void> clearAllSecure() {
    return _secureStorage.deleteAll();
  }

  Future<void> deletAllData() async {
    await clear();
    await clearAllSecure();
  }
}
