import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:pos_dashboard/data/repositories/login_repo.dart';

class LoginController extends GetxController {
  final LoginRepository loginRepository;

  LoginController({required this.loginRepository});

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> login(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      errorMessage.value = "Please enter username and password";
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';
    try {
      dio.Response response = await loginRepository.login(username, password);
      if (response.statusCode == 200) {
        String accessToken = response.data['access_token'];
        print("Login Successful: $accessToken");
        Get.offAllNamed('/dashboard');
      } else {
        errorMessage.value = "Invalid login credentials";
      }
    } catch (e) {
      String error = "Login failed. Please try again";

      if (e is dio.DioException) {
        if (e.response?.statusCode == 400) {
          error = "Invalid username or password";
        } else if (e.response?.statusCode == 500) {
          error = "Server error. Please try again later";
        }
      }

      errorMessage.value = error;
    }
    isLoading.value = false;
  }
}