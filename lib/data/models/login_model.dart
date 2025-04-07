class LoginModel {
  final String accessToken;
  final int? expiresIn;

  LoginModel({
    required this.accessToken,
    this.expiresIn,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    if (json == null || json['access_token'] == null) {
      throw FormatException('Failed to load access token from JSON: $json');
    }

    return LoginModel(
      accessToken: json['access_token'],
      expiresIn: json['expires_in'],
    );
  }
}
