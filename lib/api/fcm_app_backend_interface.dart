import 'dart:async';

/// Describes how this package will communicate with app's backend
///
/// [updateOnServer] is called when user's token is stale
///
/// [deleteOnServer] is called e.g. on user logout
abstract interface class FcmAppBackendInterface {
  /// Called when FCM token is stale
  FutureOr<void> updateOnServer({
    required String userId,
    required String fcmToken,
  });

  /// Called e.g. on user logout
  FutureOr<void> deleteOnServer({
    required String userId,
  });
}
