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
    _isDarkMode.value = _storage.read('isDarkMode') ?? false;
    Get.changeThemeMode(_isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  void toggleTheme() {
    _isDarkMode.value = !_isDarkMode.value;
    Get.changeThemeMode(_isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
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
      bottomNavigationBar: InkWell(
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
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
    );
  }
}
