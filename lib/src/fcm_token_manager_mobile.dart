// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:fcm_token_manager/api/fcm_app_backend_interface.dart';
import 'package:fcm_token_manager/api/notification_permission_status_enum.dart';
import 'package:fcm_token_manager/src/data/stored_fcm_token.dart';
import 'package:fcm_token_manager/src/data/stored_fcm_token_manager.dart';
import 'package:fcm_token_manager/src/data/stored_notification_preference.dart';
import 'package:fcm_token_manager/src/data/stored_notification_preference_manager.dart';
import 'package:fcm_token_manager/src/fcm_token_manager_base.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

/// See FcmTokenManagerStub for docs
class FcmTokenManager implements FcmTokenManagerBase {
  FcmTokenManager._() : assert(kIsWeb == false, 'Not supported on web.');

  factory FcmTokenManager.initialize({
    required FcmAppBackendInterface apiInterface,
    required Duration tokenTtl,
  }) {
    _instance._api = apiInterface;
    _instance._tokenTtl = tokenTtl;
    return _instance;
  }

  factory FcmTokenManager.instance() {
    return _instance;
  }

  static final FirebaseMessaging _firebase = FirebaseMessaging.instance;
  static final _instance = FcmTokenManager._();
  static const _storedFcmManager = StoredFcmTokenManager();
  static const _storedPreferenceManager = StoredNotificationPreferenceManager();

  late FcmAppBackendInterface _api;
  late Duration _tokenTtl;

  @override
  Future<NotificationPermissionStatus> getAppNotificationPreference(
    String userId,
  ) async {
    final appPref = (await _storedPreferenceManager.readFromStorage())?.value;

    if (appPref == null) {
      final userDecision = await _askPermission();
      if (userDecision.authorizationStatus == AuthorizationStatus.authorized) {
        await _enableInApp(
          userId: userId,
        );
        return NotificationPermissionStatus.ENABLED;
      } else {
        await _disableInApp(userId: userId);
        return NotificationPermissionStatus.DISABLED_IN_APP;
      }
    } else {
      if (appPref == true) {
        return NotificationPermissionStatus.ENABLED;
      } else {
        return NotificationPermissionStatus.DISABLED_IN_APP;
      }
    }
  }

  @override
  Future<void> onLogin({required String userId}) async {
    final isInAppEnabled =
        (await _storedPreferenceManager.readFromStorage())?.value;

    if (isInAppEnabled != null && isInAppEnabled == true) {
      final fcmToken = await FirebaseMessaging.instance.getToken();
      if (fcmToken == null) {
        return;
      }
      await _updateApiValueIfPastTtl(
        fcmToken: fcmToken,
        userId: userId,
      );
    }
  }

  @override
  Future<void> onLogout({required String userId}) async {
    final isSet = await _storedFcmManager.isSetInStorage();
    if (isSet) {
      try {
        await _api.deleteOnServer(userId: userId);
        await _storedFcmManager.deleteFromStorage();
      } catch (e) {
        return;
      }
    }
  }

  @override
  Future<void> setAppNotificationPreference({
    required bool isEnabled,
    required String userId,
  }) async {
    final devicePreference =
        (await _firebase.getNotificationSettings()).authorizationStatus;
    if (devicePreference == AuthorizationStatus.authorized) {
      if (isEnabled) {
        await _enableInApp(userId: userId);
      } else {
        await _disableInApp(userId: userId);
      }
    } else {
      if (!isEnabled) {
        await _disableInApp(userId: userId);
      } else {
        throw Exception('Device not authorized');
      }
    }
  }

  Future<void> _updateApiValueIfPastTtl({
    required String fcmToken,
    required String userId,
  }) async {
    final stored = await _storedFcmManager.readFromStorage();
    if (stored == null || stored.isStale(_tokenTtl)) {
      await _api.updateOnServer(userId: userId, fcmToken: fcmToken);

      await _storedFcmManager
          .setInStorage(StoredFcmToken.createWithTimestamp(fcmToken));
    } else {
      return;
    }
  }

  Future<void> _enableInApp({
    required String userId,
  }) async {
    final fcmToken = await _firebase.getToken();
    if (fcmToken == null) {
      return;
    } else {
      try {
        await _api.updateOnServer(userId: userId, fcmToken: fcmToken);
      } catch (e) {
        rethrow;
      }
      await _storedFcmManager
          .setInStorage(StoredFcmToken.createWithTimestamp(fcmToken));
      await _storedPreferenceManager
          .setInStorage(StoredNotificationPreference.enabled());
    }
  }

  Future<void> _disableInApp({
    required String userId,
  }) async {
    try {
      await _api.deleteOnServer(userId: userId);
    } catch (e) {
      rethrow;
    }
    await _storedFcmManager.deleteFromStorage();
    await _storedPreferenceManager
        .setInStorage(StoredNotificationPreference.disabledInApp());
  }

  Future<NotificationSettings> _askPermission() async {
    final settings = await _firebase.requestPermission();

    return settings;
  }
}
