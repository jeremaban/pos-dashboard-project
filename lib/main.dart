import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_dashboard/core/dependencies.dart' as dep;
import 'package:pos_dashboard/presentation/controllers/product_controller.dart';
import 'package:pos_dashboard/presentation/controllers/login_controller.dart';
import 'package:pos_dashboard/data/repositories/product_repo.dart'; 
import 'package:pos_dashboard/data/repositories/login_repo.dart';
import 'package:pos_dashboard/core/api/api_client.dart';
import 'package:pos_dashboard/presentation/screens/login/login_screen.dart';
import 'package:pos_dashboard/core/utils/app_constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();

  Get.put<ApiClient>(ApiClient(baseUrl: AppConstants.BASE_URL));

  Get.put<PopularProductRepo>(PopularProductRepo(apiClient: Get.find()));
  Get.put<PopularProductController>(
      PopularProductController(popularProductRepo: Get.find()));

  Get.put<LoginRepository>(LoginRepository(apiClient: Get.find()));
  Get.put<LoginController>(LoginController(loginRepository: Get.find()));

  runApp(const PosDashboardApp());
}


class PosDashboardApp extends StatelessWidget {
  const PosDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
      initialBinding: BindingsBuilder(() {
        Get.find<PopularProductController>().getPopularProductList();
      }),
    );
  }
}
