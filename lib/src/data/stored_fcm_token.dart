class StoredFcmToken {
  const StoredFcmToken._({
    required this.token,
    required this.postedAt,
  });

  factory StoredFcmToken.createWithTimestamp(String token) {
    return StoredFcmToken._(
      token: token,
      postedAt: DateTime.now(),
    );
  }

  factory StoredFcmToken.fromJson(Map<String, dynamic> json) {
    return StoredFcmToken._(
      token: json['token'] as String,
      postedAt: DateTime.parse(json['postedAt'] as String),
    );
  }

  final DateTime postedAt;
  final String token;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'postedAt': postedAt.toIso8601String(),
      'token': token,
    };
  }

  bool isStale(Duration tokenTtl) {
    final now = DateTime.now();
    final isStaleIfCreatedBefore = now.subtract(tokenTtl);
    return postedAt.isBefore(isStaleIfCreatedBefore);
  }
}
