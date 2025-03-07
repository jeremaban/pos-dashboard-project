import 'package:flutter/material.dart';
import 'package:pos_dashboard/helper/dependencies.dart' as dep;
import 'my_app.dart'; // Import MyApp

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized(); //ensures that dependencies are loaded in
  await dep.init();
  
  runApp(const MyApp());
}