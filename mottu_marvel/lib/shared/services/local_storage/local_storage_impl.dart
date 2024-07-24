import 'package:mottu_marvel/shared/services/local_storage/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage implements LocalStorageService {
  @override
  Future<bool> contains(String key) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.containsKey(key);
  }

  @override
  Future<bool> delete(String key) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.remove(key);
  }

  @override
  Future<bool> deleteAll() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.clear();
  }

  @override
  Future<String> get(String key) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key) ?? '';
  }

  @override
  Future<void> put(String key, String value) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(key, value);
  }
}
