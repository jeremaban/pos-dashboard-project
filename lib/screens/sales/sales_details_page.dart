import 'package:flutter/material.dart';
import '../dashboard/dashboard_screen.dart';

class SalesDetailsPage extends StatelessWidget {
  const SalesDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sales Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ... Sales details UI
            ElevatedButton(onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashboardScreen()));
            }, child: const Text("Go Back")),
          ],
        ),
      ),
    );
  }
}