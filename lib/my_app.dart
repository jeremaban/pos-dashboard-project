import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_dashboard/controllers/product_controller.dart';
import 'screens/login/login_screen.dart'; // Import LoginScreen

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().getPopularProductList(); //makes get request to api

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
      initialBinding: BindingsBuilder(() {
        Get.find<PopularProductController>().getPopularProductList();
      }),
    );
  }
}