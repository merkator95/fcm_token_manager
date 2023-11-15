class StoredNotificationPreference {
  StoredNotificationPreference._({
    required this.value,
  });

  factory StoredNotificationPreference.disabledInApp() =>
      StoredNotificationPreference._(value: false);

  factory StoredNotificationPreference.enabled() =>
      StoredNotificationPreference._(value: true);

  factory StoredNotificationPreference.fromJson(Map<String, dynamic> json) {
    return StoredNotificationPreference._(
      value: json['value'] as bool,
    );
  }

  final bool value;

  Map<String, dynamic> toJson() => <String, dynamic>{'value': value};
}
