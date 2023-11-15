import 'dart:async';
import 'dart:core';

import 'package:fcm_token_manager/fcm_token_manager.dart';
import 'package:fcm_token_manager/src/data/stored_notification_preference_manager.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

/// Checks for notification permissions and maybe asks for permission
///
/// If user never accepted or rejected notification permission,
/// it asks for notification permissions.
/// It stores user preference and doesn't ask again if user rejected
/// notifications.
class FcmNotificationAskPermission extends StatelessWidget {
  /// Checks for notification permissions and maybe asks for permission
  const FcmNotificationAskPermission({
    required this.child,
    required this.userId,
    super.key,
  });

  /// A widget to display as a child of this.
  final Widget child;

  /// Logged-in user user ID to enable app backend token storage
  final String userId;

  Future<void> _checkAndRequestPermissions(String userId) async {
    final messaging = FirebaseMessaging.instance;
    final fcmManager = FcmTokenManager.instance();
    const prefManager = StoredNotificationPreferenceManager();
    final isInAppPreferenceSet = await prefManager.isSetInStorage();

    final settings = await messaging.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (!isInAppPreferenceSet) {
        await fcmManager.setAppNotificationPreference(
          isEnabled: true,
          userId: userId,
        );
      }
    } else {
      await fcmManager.setAppNotificationPreference(
        isEnabled: false,
        userId: userId,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    unawaited(_checkAndRequestPermissions(userId));
    return child;
  }
}
