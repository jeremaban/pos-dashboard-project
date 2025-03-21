import 'package:dio/src/response.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:pos_dashboard/core/api/api_client.dart';
import 'package:pos_dashboard/core/utils/app_constants.dart';

class ItemRepo extends GetxService {
  final ApiClient apiClient;

  ItemRepo({required this.apiClient});


  Map<String, dynamic> body = {
    "StoreId": 1, //NEED TO BE DYNAMIC DEPENDING ON STORE LOGGING IN
    "POSId": 2,
    "RecordsPerPage": 3,
    "OffSet": 4
  };

  Future<Response> getItemList() async {
    return await apiClient.postData(AppConstants.PRODUCT_URI, body);
  }
}