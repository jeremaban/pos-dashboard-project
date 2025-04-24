import 'package:dio/src/response.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:pos_dashboard/core/api/api_client.dart';
import 'package:pos_dashboard/core/utils/app_constants.dart';
import 'package:pos_dashboard/presentation/controllers/login_controller.dart';

class SendOtpRepo extends GetxService {
  final ApiClient apiClient;
  final LoginController loginController;
  late Map<String, dynamic> body;

  SendOtpRepo({
    required this.apiClient,
    required this.loginController,
  }) {
    body = {
      //TODO: MAKE DYNAMIC, USING FOR TESTING FOR NOW
      "MobileNo": "09627551578",
      "UserId": loginController.userId,
      "AppHash": "XMsemExH"
    };
  }

  Future<Response> getSendOTP() async {

    String accessToken = loginController.accessToken;

    return await apiClient.postData(
      AppConstants.SENDOTP,
      body,
      authToken: accessToken
    );
  }
}