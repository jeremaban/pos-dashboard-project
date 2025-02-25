import 'package:flutter/material.dart';

class ItemsList extends StatelessWidget {
  const ItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Image.asset("assets/image/food0.png", width: 50, height: 50),
          title: Text("Item Name ${index + 1}"),
          subtitle: const Text("Stock: 1"),
        );
      },
    );
  }
}