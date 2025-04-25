class AuthResponse {
  final String token;
  final DateTime sessionExpiry;

  AuthResponse({
    required this.token,
    required this.sessionExpiry,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'] ?? '',
      sessionExpiry: DateTime.parse(json['sessionExpiresAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'sessionExpiresAt': sessionExpiry.toIso8601String(),
    };
  }
}
