import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pos_dashboard/core/dependencies.dart' as dep;
import 'package:pos_dashboard/data/repositories/item_repo.dart';
import 'package:pos_dashboard/data/repositories/top_dashboard_repo.dart';
import 'package:pos_dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:pos_dashboard/presentation/controllers/item_controller.dart';
import 'package:pos_dashboard/presentation/controllers/login_controller.dart';
import 'package:pos_dashboard/data/repositories/login_repo.dart';
import 'package:pos_dashboard/presentation/controllers/top_dashboard_controller.dart';
import 'package:pos_dashboard/presentation/screens/login/login_screen.dart';
import 'package:pos_dashboard/presentation/screens/login/otp_verification_screen.dart';
import 'package:pos_dashboard/presentation/screens/login/pin_verification_screen.dart';
import 'package:pos_dashboard/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:pos_dashboard/core/utils/app_constants.dart';
import 'package:pos_dashboard/core/api/api_client.dart';
import 'package:pos_dashboard/presentation/screens/settings/settings_screen.dart';
import 'package:pos_dashboard/core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  try {
    await dep.init();

    // Initialize controllers and dependencies
    final themeController = Get.put(ThemeController());
    await themeController.loadTheme();

    Get.put<ApiClient>(ApiClient(baseUrl: AppConstants.BASE_URL));
    Get.put<Dio>(Dio(BaseOptions(baseUrl: AppConstants.BASE_URL)));
    Get.put<LoginRepository>(LoginRepository(dio: Get.find()));
    Get.put<LoginController>(LoginController(loginRepository: Get.find()));

    // Initialize repositories that depend on LoginController
    Get.put<ItemRepository>(
      ItemRepository(apiClient: Get.find(), loginController: Get.find()),
    );
    Get.put<TopDashboardRepo>(
      TopDashboardRepo(apiClient: Get.find(), loginController: Get.find()),
    );

    // Initialize remaining controllers
    Get.put<ItemController>(ItemController(itemRepository: Get.find()));
    Get.put<TopDashboardController>(
      TopDashboardController(topDashboardRepo: Get.find()),
    );

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
    return GetBuilder<ThemeController>(
      builder:
          (themeController) => FutureBuilder<String>(
            future: Get.find<LoginController>().getInitialRoute(),
            builder: (context, snapshot) {
              // Show loading screen while checking credentials
              if (snapshot.connectionState == ConnectionState.waiting) {
                return MaterialApp(
                  home: Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(
                        color: AppTheme.lightTheme.primaryColor,
                      ),
                    ),
                  ),
                );
              }

              // If there's an error, default to login screen
              if (snapshot.hasError) {
                print('Error determining initial route: ${snapshot.error}');
                return GetMaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: AppTheme.lightTheme,
                  darkTheme: AppTheme.darkTheme,
                  themeMode:
                      themeController.isDarkMode
                          ? ThemeMode.dark
                          : ThemeMode.light,
                  home: LoginScreen(),
                );
              }

              return GetMaterialApp(
                debugShowCheckedModeBanner: false,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode:
                    themeController.isDarkMode
                        ? ThemeMode.dark
                        : ThemeMode.light,
                initialRoute: snapshot.data ?? '/',
                getPages: [
                  GetPage(name: "/", page: () => LoginScreen()),
                  GetPage(
                    name: "/otp-verification",
                    page: () => const OTPVerificationScreen(),
                  ),
                  GetPage(
                    name: "/pin-verification",
                    page: () => PinVerificationScreen(),
                  ),
                  GetPage(
                    name: "/dashboard",
                    page: () => const DashboardScreen(),
                    binding: DashboardBinding(),
                  ),
                ],
              );
            },
          ),
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
