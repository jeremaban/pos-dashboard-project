import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_dashboard/core/utils/dimensions.dart';
import 'package:pos_dashboard/presentation/controllers/login_controller.dart';
import 'package:pos_dashboard/presentation/screens/settings/settings_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController loginController = Get.find();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
        final ThemeController themeController = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF00308F),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(Dimensions.height16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: const TextStyle(color: Color(0xFF00308F)),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF00308F)),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF00308F), width: 2),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.height10),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: const TextStyle(color: Color(0xFF00308F)),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF00308F)),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF00308F), width: 2),
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: Dimensions.height20),
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF00308F),
                      side: const BorderSide(color: Color(0xFF00308F)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: loginController.isLoading.value
                        ? null
                        : () {
                            loginController.login(
                              usernameController.text,
                              passwordController.text,
                            ).then((_) {
                              if (loginController.errorMessage.isNotEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(loginController.errorMessage.value),
                                  ),
                                );
                              }
                            });
                          },
                    child: loginController.isLoading.value
                        ? const CircularProgressIndicator()
                        : const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              "Login",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}