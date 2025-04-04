import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pos_dashboard/presentation/screens/login/login_screen.dart';
import 'package:pos_dashboard/core/utils/dimensions.dart';
import 'package:pos_dashboard/presentation/screens/settings/terms_webview_screen.dart';

class ThemeController extends GetxController {
  final _storage = GetStorage();
  final RxBool _isDarkMode = false.obs;

  bool get isDarkMode => _isDarkMode.value;

  @override
  void onInit() {
    super.onInit();

    bool isDarkMode = _storage.read('isDarkMode') ?? false;
    Get.changeThemeMode(isDarkMode ? ThemeMode.dark : ThemeMode.light);
  }

  void toggleTheme() {
    _isDarkMode.value = !_isDarkMode.value;
    Get.changeThemeMode(
      _isDarkMode.value ? ThemeMode.dark : ThemeMode.light
    );

    _storage.write('isDarkMode', _isDarkMode.value);
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    
  final ThemeController themeController = Get.find<ThemeController>();

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Obx(() => SwitchListTile(
                    title: Text('Dark Mode'),
                    value: themeController.isDarkMode, 
                    onChanged: (_) => themeController.toggleTheme(),
                    )),
                ]
              )
            ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: Dimensions.height16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context, 
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Terms and Conditions'),
                            content: SingleChildScrollView(
                              child: Text(
                                'You will be redirected to our page containing the terms and conditions in your browser.'
                              )
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Close'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TermsWebviewScreen(
                                        url: 'https://www.sellercenter.shoppazing.com/home/terms',
                                        ),
                                    ),
                                  );
                                },
                                child: Text('View Full Terms'),
                              )
                            ],
                          );
                        },
                        );
                    },
                    child: Text('Terms and Conditions'))
                ],
              ),
            )
        ],
      ),
         bottomNavigationBar: InkWell(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
            );
          },
          child: BottomAppBar(
            child: SizedBox(
              height: Dimensions.height50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('LOGOUT'),
                ],
              )
            )
          )
         ),
      );
  }
}