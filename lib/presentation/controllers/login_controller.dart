import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:pos_dashboard/data/repositories/login_repo.dart';

class LoginController extends GetxController {
  final LoginRepository loginRepository;

  LoginController({required this.loginRepository});

  var isLoading = false.obs;

  Future<void> loginUser(String email, String password) async {
    isLoading.value = true;

    dio.Response response = await loginRepository.login(email, password);

    if (response.statusCode == 200) {
      Get.snackbar("Success", "Login successful!");
    } else {
      Get.snackbar("Error", response.statusMessage ?? "Login failed!");
    }

    isLoading.value = false;
  }
}
