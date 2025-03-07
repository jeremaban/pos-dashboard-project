import 'package:get/get.dart';
import 'package:pos_dashboard/utilities/app_constants.dart';

class ApiClient extends GetConnect implements GetxService{
  String token = '';
  final String appBaseUrl;
  late Map<String, String> _mainHeaders; //local storing of data

  ApiClient({
    required this.appBaseUrl
  }) {
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30);
    token = AppConstants.TOKEN;
    updateHeader();
  }

  void updateHeader([String? newToken]) {
    if (newToken != null) {
      token = newToken;
    }

    _mainHeaders = {
      'Content-Type': 'application/json; charset = UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

  //get method in php
  Future<Response> getData(String uri,) async {
    try{
      Response response = await get(uri, headers: _mainHeaders); //waits for data, if data returns it saves in response
      return response;
    } catch(e) { //if it fails, it returns an error
      return Response(
        statusCode: 1,
        statusText: e.toString(),
      );
    }
  }
}