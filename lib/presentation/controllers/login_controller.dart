import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pos_dashboard/data/repositories/login_repo.dart';

class LoginController extends GetxController {
  final LoginRepository loginRepository;
  final _prefs = SharedPreferences.getInstance();

  //RX for reactive state management
  final RxString _accessToken = RxString('');
  final RxBool isPinSetup = false.obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool isOTPRequired = false.obs;
  final Rx<Map<String, String>> tempCredentials = Rx<Map<String, String>>({});

  String get accessToken => _accessToken.value;

  LoginController({required this.loginRepository});

  @override
  void onInit() {
    super.onInit();
    clearStoredData();
  }

  Future<void> clearStoredData() async {
    final prefs = await _prefs;
    await prefs.clear();
    isPinSetup.value = false;
    _accessToken.value = '';
    tempCredentials.value = {};
  }

  Future<String> getInitialRoute() async {
    try {
      final prefs = await _prefs;
      isPinSetup.value = prefs.getBool('isPinSetup') ?? false;
      String? storedToken = prefs.getString('access_token');

      if (isPinSetup.value && storedToken != null && storedToken.isNotEmpty) {
        _accessToken.value = storedToken;
        return '/pin-verification';
      }

      await clearStoredData();
      return '/';
    } catch (e) {
      print('Error checking initial route: $e');
      await clearStoredData();
      return '/';
    }
  }

  Future<void> login(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      errorMessage.value = "Please enter username and password";
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final response = await loginRepository.login(username, password);

      if (response.statusCode == 200) {
        tempCredentials.value = {'username': username, 'password': password};
        isOTPRequired.value = true;
        Get.toNamed('/otp-verification');
      } else {
        errorMessage.value = "Login failed. Please check your credentials.";
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
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyOTP(String otp) async {
    if (otp.isEmpty) {
      errorMessage.value = "Please enter OTP";
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    try {
      // TODO: Replace with actual OTP verification API call
      if (otp == "123456") {
        // Make the actual login API call
        dio.Response response = await loginRepository.login(
          tempCredentials.value['username']!,
          tempCredentials.value['password']!,
        );

        if (response.statusCode == 200 && response.data != null) {
          _accessToken.value = response.data['access_token'];
          final prefs = await _prefs;
          await prefs.setString('access_token', _accessToken.value);
          Get.toNamed('/pin-verification');
        } else {
          errorMessage.value = "Login failed. Please try again.";
        }
      } else {
        errorMessage.value = "Invalid OTP";
      }
    } catch (e) {
      errorMessage.value = "OTP verification failed. Please try again";
      print("Login error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyPin(String pin) async {
    if (pin.isEmpty) {
      errorMessage.value = "Please enter PIN";
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    try {
      await Future.delayed(const Duration(seconds: 1));

      if (pin == "000000") {
        final prefs = await _prefs;
        await prefs.setBool('isPinSetup', true);
        isPinSetup.value = true;
        Get.offAllNamed('/dashboard');
      } else {
        errorMessage.value = "Invalid PIN";
      }
    } catch (e) {
      errorMessage.value = "PIN verification failed. Please try again";
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await clearStoredData();
    Get.offAllNamed('/');
  }

  Future<void> resendOTP() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      await Future.delayed(const Duration(seconds: 2));
      Get.snackbar(
        'Success',
        'OTP has been resent to your mobile phone',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      errorMessage.value = "Failed to resend OTP. Please try again";
    } finally {
      isLoading.value = false;
    }
  }
}
