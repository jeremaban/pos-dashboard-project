class LoginModel {
  final String accessToken;

  LoginModel({required this.accessToken});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    if (json == null || json['access_token'] == null) {
      throw FormatException('Failed to load access token from JSON: $json');
    }

    return LoginModel(accessToken: json['access_token']);
  }
}