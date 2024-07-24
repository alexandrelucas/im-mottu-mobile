abstract interface class LocalStorageService {
  Future<String> get(String key);
  Future<bool> contains(String key);
  Future<void> put(String key, String value);
  Future<bool> delete(String key);
  Future<bool> deleteAll();
}
