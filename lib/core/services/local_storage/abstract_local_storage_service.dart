abstract class LocalStorageService {
  Future<T> get<T>(String key);
  Future<bool> save<I>(String key, I value);
  Future<void> remove(String key);
  Future<void> clear();
}