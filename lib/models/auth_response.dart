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
      sessionExpiry: DateTime.parse(json['sessionDuration']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'sessionDuration': sessionExpiry.toIso8601String(),
    };
  }
}
