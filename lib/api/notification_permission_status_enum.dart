// ignore_for_file: constant_identifier_names

/// Describes the possible outcomes of checking notification permissions status.
///
/// [ENABLED] - notifications enabled in app settings and device settings
/// [DISABLED_IN_APP] - notifications disabled in app settings but not
/// disabled in device settings
/// [DISABLED_IN_DEVICE_SETTINGS] - notifications disabled in device settings
/// [NOT_SET] - we've never asked or checked
enum NotificationPermissionStatus {
  /// Notifications enabled in app settings and device settings
  ENABLED('ENABLED'),

  /// Notifications disabled in app settings but not disabled in device settings
  DISABLED_IN_APP('DISABLED_IN_APP'),

  /// Notifications disabled in device settings
  DISABLED_IN_DEVICE_SETTINGS('DISABLED_IN_DEVICE_SETTINGS'),

  /// We've never checked
  NOT_SET('NOT_SET');

  const NotificationPermissionStatus(this.displayValue);

  /// Display value
  final String displayValue;

  /// Get enum as display value string
  String toDisplayValue() => displayValue;
}
