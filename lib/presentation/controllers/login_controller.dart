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

  String get accessToken => _accessToken.value;

  LoginController({required this.loginRepository});

  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var isOTPRequired = false.obs;
  var tempCredentials = <String, String>{};

  @override
  void onInit() {
    super.onInit();
    // Clear any existing data on controller initialization
    clearStoredData();
  }

  Future<void> clearStoredData() async {
    final prefs = await _prefs;
    await prefs.clear();
    isPinSetup.value = false;
    _accessToken.value = '';
  }

  Future<String> getInitialRoute() async {
    try {
      final prefs = await _prefs;
      isPinSetup.value = prefs.getBool('isPinSetup') ?? false;
      String? storedToken = prefs.getString('access_token');

      // Only return pin verification if both PIN and token exist
      if (isPinSetup.value && storedToken != null && storedToken.isNotEmpty) {
        _accessToken.value = storedToken;
        return '/pin-verification';
      }

      // If either is missing, clear everything and go to login
      await clearStoredData();
      return '/';
    } catch (e) {
      print('Error checking initial route: $e');
      await clearStoredData();
      return '/';
    }
  }

  Future<void> checkPinSetup() async {
    final prefs = await _prefs;
    isPinSetup.value = prefs.getBool('isPinSetup') ?? false;
    String? storedToken = prefs.getString('access_token');

    if (!(isPinSetup.value && storedToken != null && storedToken.isNotEmpty)) {
      // Clear everything if either PIN or token is missing
      await prefs.clear();
      isPinSetup.value = false;
      _accessToken.value = '';
    } else {
      _accessToken.value = storedToken;
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
      tempCredentials = {'username': username, 'password': password};

      isOTPRequired.value = true;
      Get.toNamed('/otp-verification');
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

  Future<void> verifyOTP(String otp) async {
    if (otp.isEmpty) {
      errorMessage.value = "Please enter OTP";
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';
    try {
      if (otp == "123456") {
        dio.Response response = await loginRepository.login(
          tempCredentials['username']!,
          tempCredentials['password']!,
        );
        if (response.statusCode == 200) {
          _accessToken.value = response.data['access_token'];
          // Store access token
          final prefs = await _prefs;
          await prefs.setString('access_token', _accessToken.value);
          print("Login Successful: $accessToken");
          Get.toNamed('/pin-verification');
        } else {
          errorMessage.value = "Invalid OTP";
        }
      } else {
        errorMessage.value = "Invalid OTP";
      }
    } catch (e) {
      errorMessage.value = "OTP verification failed. Please try again";
    }
    isLoading.value = false;
  }

  Future<void> verifyPin(String pin) async {
    if (pin.isEmpty) {
      errorMessage.value = "Please enter PIN";
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';
    try {
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
    }
    isLoading.value = false;
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
    }
    isLoading.value = false;
  }
}
