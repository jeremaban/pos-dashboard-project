import 'package:dio/src/response.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pos_dashboard/core/api/api_client.dart';
import 'package:pos_dashboard/core/utils/app_constants.dart';
import 'package:pos_dashboard/presentation/controllers/login_controller.dart';

class VerifyOtpRepo extends GetxService {
  final ApiClient apiClient;
  final LoginController loginController;

  VerifyOtpRepo({
    required this.apiClient,
    required this.loginController,
  });

  Future<Response> getVerifyOTP(String otp) async {

    String accessToken = loginController.accessToken;

    Map<String, dynamic> body = {
      "OTP": otp,
      "MobileNo": loginController.phoneNumber,
      "UserId": loginController.userId,
    };

    return await apiClient.postData(
      AppConstants.VERIFYOTP, 
      body,
      authToken: accessToken,
    );
  }
}