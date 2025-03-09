import 'package:pos_dashboard/data/api/api_client.dart';
import 'package:get/get.dart';
import 'package:pos_dashboard/utilities/app_constants.dart';
//when u load data from internet, always extend GetxService
class PopularProductRepo extends GetxService {
  final ApiClient apiClient;
  
  PopularProductRepo({required this.apiClient});
  //with future, we can use async and await
  Future<Response> getPopularProductList() async {
    return await apiClient.getData(AppConstants.PRODUCT_URI);
  } 
}