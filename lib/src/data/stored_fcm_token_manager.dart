import 'dart:convert';

import 'package:fcm_token_manager/src/data/stored_fcm_token.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _key = 'fcm_token';

class StoredFcmTokenManager {
  const StoredFcmTokenManager({
    this.key = _key,
  });

  final String key;
  static const _storage = FlutterSecureStorage();

  Future<void> setInStorage(StoredFcmToken data) async {
    await _storage.write(key: key, value: jsonEncode(data.toJson()));
  }

  Future<StoredFcmToken?> readFromStorage() async {
    try {
      final stored = await _storage.read(key: key);
      if (stored == null) {
        return null;
      } else {
        final json = jsonDecode(stored) as Map<String, dynamic>;
        final token = StoredFcmToken.fromJson(json);
        return token;
      }
    } catch (e) {
      await deleteFromStorage();
      return null;
    }
  }

  Future<bool> isSetInStorage() async {
    final stored = await _storage.read(key: key);
    return stored != null;
  }

  Future<void> deleteFromStorage() async {
    await _storage.delete(key: key);
  }
}
