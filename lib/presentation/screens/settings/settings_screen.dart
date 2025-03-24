import 'package:flutter/material.dart';
import 'package:pos_dashboard/presentation/screens/login/login_screen.dart';
import 'package:pos_dashboard/core/utils/dimensions.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Center(
              child: Text('Test'),
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
                                'Test for Terms and Conditions.\n\n'
                                'Add terms and conditions here.'
                              )
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Close'),
                              ),
                            ],
                          );
                        },
                        );
                    },
                    child: Text('Terms and Conditions')),
                  SizedBox(width: Dimensions.width10),
                  Icon(Icons.circle, size: Dimensions.iconSize5, color: Colors.grey),
                  SizedBox(width: Dimensions.width10),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context, 
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Privacy Policy'),
                            content: SingleChildScrollView(
                              child: Text(
                                'Test for Privacy Policy.\n\n'
                                'Add policy here.'
                              )
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Close'),
                              ),
                            ],
                          );
                        },
                        );
                    },
                    child: Text('Privacy Policy')),
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