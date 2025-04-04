import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:pos_dashboard/core/api/api_client.dart';
import 'package:pos_dashboard/core/utils/app_constants.dart';

class PopularProductRepo extends GetxService {
  final ApiClient apiClient;

  PopularProductRepo({required this.apiClient});


  Map<String, dynamic> body = {
    "StoreId": 1, //NEED TO BE DYNAMIC DEPENDING ON STORE LOGGING IN
    "POSId": 2,
    "RecordsPerPage": 3,
    "OffSet": 4
  };

  Future<dio.Response> getItemList() async {
    return await apiClient.postData(AppConstants.PRODUCT_URI, body);
  }
}
