import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:pos_dashboard/core/api/api_client.dart';
import 'package:pos_dashboard/core/utils/app_constants.dart';

class PopularProductRepo extends GetxService {
  final ApiClient apiClient;

  PopularProductRepo({required this.apiClient});

  Future<dio.Response> getPopularProductList() async {
    return await apiClient.getData(AppConstants.PRODUCT_URI);
  }
}
