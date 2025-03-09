import 'package:pos_dashboard/controllers/product_controller.dart';
import 'package:pos_dashboard/data/api/api_client.dart';
import 'package:pos_dashboard/data/repository/product_repo.dart';
import 'package:get/get.dart';
import 'package:pos_dashboard/utilities/app_constants.dart';

Future<void> init()async {
  //api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  //repo
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find())); 

  //controllers
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
}