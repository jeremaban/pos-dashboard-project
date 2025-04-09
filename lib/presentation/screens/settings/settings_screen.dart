import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_dashboard/presentation/screens/login/login_screen.dart';
import 'package:pos_dashboard/core/utils/dimensions.dart';
import 'package:pos_dashboard/presentation/screens/settings/terms_webview_screen.dart';
import 'package:pos_dashboard/presentation/controllers/theme_controller.dart';
import 'package:pos_dashboard/presentation/controllers/login_controller.dart';

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
      body: ListView(
        children: [
          const SizedBox(height: 16),
          Obx(
            () => SwitchListTile(
              title: const Text('Dark Mode'),
              subtitle: Text(
                themeController.isDarkMode
                    ? 'Dark theme enabled'
                    : 'Light theme enabled',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              value: themeController.isDarkMode,
              onChanged: (_) => themeController.toggleTheme(),
            ),
          ),
          const Divider(),
          // Add more settings items here
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => const TermsWebviewScreen(
                              url:
                                  'https://sellercenter.shoppazing.com/home/terms',
                              title: 'Terms and Conditions',
                            ),
                      ),
                    );
                  },
                  child: Text(
                    'Terms and Conditions',
                    style: TextStyle(fontSize: Dimensions.font12),
                  ),
                ),
                Text(' · ', style: TextStyle(fontSize: Dimensions.font18)),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => const TermsWebviewScreen(
                              url:
                                  'https://sellercenter.shoppazing.com/home/privacy',
                              title: 'Privacy Policy',
                            ),
                      ),
                    );
                  },
                  child: Text(
                    'Privacy Policy',
                    style: TextStyle(fontSize: Dimensions.font12),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Get.find<LoginController>().logout();
            },
            child: BottomAppBar(
              child: SizedBox(
                height: Dimensions.height50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('LOGOUT')],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
