// ignore_for_file: public_member_api_docs

import 'package:fcm_token_manager/api/notification_permission_status_enum.dart';

/// See FcmTokenManager stub for docs
abstract class FcmTokenManagerBase {
  Future<void> onLogin({required String userId}) async {}
  Future<void> onLogout({required String userId}) async {}
  Future<void> setAppNotificationPreference({
    required bool isEnabled,
    required String userId,
  }) async {}
  Future<NotificationPermissionStatus> getAppNotificationPreference(
    String userId,
  ) async {
    throw UnimplementedError();
  }
}
