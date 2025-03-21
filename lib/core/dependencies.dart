import 'package:pos_dashboard/data/repositories/item_repo.dart';
import 'package:pos_dashboard/presentation/controllers/item_controller.dart';
import 'package:pos_dashboard/presentation/controllers/product_controller.dart';
import 'package:pos_dashboard/core/api/api_client.dart';
import 'package:pos_dashboard/data/repositories/product_repo.dart';
import 'package:get/get.dart';
import 'package:pos_dashboard/core/utils/app_constants.dart';
import 'package:pos_dashboard/data/repositories/login_repo.dart';
import 'package:pos_dashboard/presentation/controllers/login_controller.dart';

Future<void> init() async {
  Get.lazyPut(() => ApiClient(baseUrl: AppConstants.BASE_URL)); // Fix applied

  Get.lazyPut(() => ItemRepo(apiClient: Get.find())); 
  Get.lazyPut(() => ItemController(itemRepo: Get.find()));

  Get.lazyPut(() => LoginRepository(apiClient: Get.find()));
  Get.lazyPut(() => LoginController(loginRepository: Get.find()));
}
