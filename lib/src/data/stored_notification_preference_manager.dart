import 'dart:convert';

import 'package:fcm_token_manager/src/data/stored_notification_preference.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _key = 'fcm_preference';

class StoredNotificationPreferenceManager {
  const StoredNotificationPreferenceManager({
    this.key = _key,
  });

  final String key;
  static const _storage = FlutterSecureStorage();

  Future<void> setInStorage(StoredNotificationPreference data) async {
    await _storage.write(key: key, value: jsonEncode(data.toJson()));
  }

  Future<StoredNotificationPreference?> readFromStorage() async {
    try {
      final stored = await _storage.read(key: key);
      if (stored == null) {
        return null;
      } else {
        final json = jsonDecode(stored) as Map<String, dynamic>;
        final value = StoredNotificationPreference.fromJson(json);
        return value;
      }
    } catch (e) {
      await deleteFromStorage();
      return null;
    }
  }

  Future<void> deleteFromStorage() async {
    await _storage.delete(key: key);
  }

  Future<bool> isSetInStorage() async {
    final stored = await _storage.read(key: key);
    return stored != null;
  }
}
