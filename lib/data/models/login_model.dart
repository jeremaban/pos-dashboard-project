class LoginModel {
  final bool success;
  final String token;
  final String message;

  LoginModel({required this.success, required this.token, required this.message});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      success: json["success"],
      token: json["token"] ?? "",
      message: json["message"] ?? "",
    );
  }
}
