import 'package:dio/dio.dart';
import '../../core/api/api_client.dart';
import '../../core/utils/app_constants.dart';

class LoginRepository {
  final ApiClient apiClient;

  LoginRepository({required this.apiClient});

  Future<Response> login(String email, String password) async {
    return await apiClient.postData(AppConstants.LOGIN_URL, {
      "email": email,
      "password": password,
    });
  }
}
