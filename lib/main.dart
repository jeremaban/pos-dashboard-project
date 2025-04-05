import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:pos_dashboard/core/dependencies.dart' as dep;
import 'package:pos_dashboard/data/repositories/item_repo.dart';
import 'package:pos_dashboard/data/repositories/top_dashboard_repo.dart';
import 'package:pos_dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:pos_dashboard/presentation/controllers/item_controller.dart';
import 'package:pos_dashboard/presentation/controllers/login_controller.dart';
import 'package:pos_dashboard/data/repositories/login_repo.dart';
import 'package:pos_dashboard/presentation/controllers/top_dashboard_controller.dart';
import 'package:pos_dashboard/presentation/screens/login/login_screen.dart';
import 'package:pos_dashboard/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:pos_dashboard/core/utils/app_constants.dart';
import 'package:pos_dashboard/core/api/api_client.dart';
import 'package:pos_dashboard/presentation/screens/settings/settings_screen.dart';
import 'package:pos_dashboard/core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dep.init();

    Get.put(ThemeController());

    Get.put<ApiClient>(ApiClient(baseUrl: AppConstants.BASE_URL));

    Get.put<Dio>(Dio(BaseOptions(baseUrl: AppConstants.BASE_URL)));

    Get.put<ItemRepository>(
      ItemRepository(apiClient: Get.find(), loginController: Get.find()),
    );

    Get.put<TopDashboardRepo>(
      TopDashboardRepo(apiClient: Get.find(), loginController: Get.find()),
    );

    Get.put<LoginRepository>(LoginRepository(dio: Get.find()));

    Get.put<ItemController>(ItemController(itemRepository: Get.find()));

    Get.put<TopDashboardController>(
      TopDashboardController(topDashboardRepo: Get.find()),
    );

    Get.put<LoginController>(LoginController(loginRepository: Get.find()));

    runApp(const PosDashboardApp());
  } catch (e) {
    print('Initialization failed: $e');
    runApp(ErrorApp(errorMessage: e.toString()));
  }
}

class PosDashboardApp extends StatelessWidget {
  const PosDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => LoginScreen()),
        GetPage(
          name: "/dashboard",
          page: () => const DashboardScreen(),
          binding: DashboardBinding(),
        ),
      ],
    );
  }
}

class DashboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => DashboardController(
        itemRepository: Get.find(),
        loginController: Get.find(),
      ),
    );
  }
}

class ErrorApp extends StatelessWidget {
  final String errorMessage;

  const ErrorApp({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: Center(child: Text('Error: $errorMessage'))),
    );
  }
}
