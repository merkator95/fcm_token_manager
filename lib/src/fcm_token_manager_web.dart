// ignore_for_file: public_member_api_docs

import 'package:fcm_token_manager/api/fcm_app_backend_interface.dart';
import 'package:fcm_token_manager/api/notification_permission_status_enum.dart';
import 'package:fcm_token_manager/src/fcm_token_manager_base.dart';

/// See FcmTokenManager stub for docs
class FcmTokenManager implements FcmTokenManagerBase {
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
  FcmTokenManager._();

  static final _instance = FcmTokenManager._();

  // ignore: unused_field
  late FcmAppBackendInterface _api;

  // ignore: unused_Field
  late Duration _tokenTtl;

  @override
  Future<void> onLogin({required String userId}) async {
    return;
  }

  @override
  Future<void> onLogout({required String userId}) async {
    return;
  }

  @override
  Future<void> setAppNotificationPreference({
    required bool isEnabled,
    required String userId,
  }) async {
    return;
  }

  @override
  Future<NotificationPermissionStatus> getAppNotificationPreference(
    String userId,
  ) async {
    return NotificationPermissionStatus.DISABLED_IN_DEVICE_SETTINGS;
  }
}
