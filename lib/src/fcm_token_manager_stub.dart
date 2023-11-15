import 'package:fcm_token_manager/api/fcm_app_backend_interface.dart';
import 'package:fcm_token_manager/api/notification_permission_status_enum.dart';
import 'package:fcm_token_manager/src/fcm_token_manager_base.dart';

/// Methods related to managing FCM token and notification permissions
///
/// [getAppNotificationPreference] returns enum of current notification settings
/// unless user has not yet given or denied permission - in that case it will
/// ask for permission.
///
/// [onLogin] and [onLogout] manage app lifecycle events e.g. checking if
/// current token is not stale, updating backend with token information and
/// deleting token from backend when user logs out
///
/// [setAppNotificationPreference] enables user to disable notifications without
/// prohibiting them in device settings by deleting FCM token from backend db
class FcmTokenManager implements FcmTokenManagerBase {
  FcmTokenManager._();

  /// Call this to initialize manager before calling other methods
  factory FcmTokenManager.initialize({
    required FcmAppBackendInterface apiInterface,
    required Duration tokenTtl,
  }) {
    _instance._api = apiInterface;
    _instance._tokenTtl = tokenTtl;
    return _instance;
  }

  /// Get instance of this object (singleton)
  factory FcmTokenManager.instance() {
    return _instance;
  }

  static final _instance = FcmTokenManager._();

  // ignore: unused_field
  late FcmAppBackendInterface _api;

  // ignore: unused_Field
  late Duration _tokenTtl;

  @override
  Future<NotificationPermissionStatus> getAppNotificationPreference(
    String userId,
  ) async {
    throw UnimplementedError();
  }

  @override
  Future<void> onLogin({required String userId}) async {
    throw UnimplementedError();
  }

  @override
  Future<void> onLogout({required String userId}) async {
    throw UnimplementedError();
  }

  @override
  Future<void> setAppNotificationPreference({
    required bool isEnabled,
    required String userId,
  }) async {
    throw UnimplementedError();
  }
}
