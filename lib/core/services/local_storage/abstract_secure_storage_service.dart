abstract class AbstractSecureStorageService {
  Future<String?> get(String key);
  Future<dynamic> save(String key, String value);
  Future<void> remove(String key);
  Future<void> clear();
}
