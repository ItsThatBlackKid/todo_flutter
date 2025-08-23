import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_flutter/core/services/local_storage/abstract_local_storage_service.dart';

class SharedPreferencesService implements LocalStorageService {
  final SharedPreferences _prefs;

  SharedPreferencesService(this._prefs);

  @override
  Future<bool> save<T>(String key, T value) {
    if (value is String) {
      return _prefs.setString(key, value);
    } else if (value is int) {
      return _prefs.setInt(key, value);
    } else if (value is double) {
      return _prefs.setDouble(key, value);
    } else if (value is bool) {
      return _prefs.setBool(key, value);
    } else if (value is List<String>) {
      return _prefs.setStringList(key, value);
    }

    throw ArgumentError('Unsupported type: ${value.runtimeType}');
  }

  @override
  Future<T> get<T>(String key) {
    return _prefs.get(key) as Future<T>;
  }

  @override
  Future<void> clear() {
    return _prefs.clear();
  }

  @override
  Future<void> remove(String key) {
    return _prefs.remove(key);
  }
}
