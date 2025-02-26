import 'package:flutter/material.dart';
import 'package:pos_dashboard/utilities/dimensions.dart';

class ItemsList extends StatefulWidget {

  final String listType;

  const ItemsList({super.key, this.listType = 'inventory'});

    @override
    _ItemsListState createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList>{
    final List<Map<String, dynamic>> items = [
      {'name': 'Item 1', 'stock': 10, 'image': 'food0.png'},
      {'name': 'Item 2', 'stock': 3, 'image': 'food1.png'},
      {'name': 'Item 3', 'stock': 0, 'image': 'food2.png'},
      {'name': 'Item 4', 'stock': 7, 'image': 'food3.png'},
      {'name': 'Item 5', 'stock': 2, 'image': 'food4.png'},
    ];

    List<Map<String, dynamic>> getItems() {
      switch (widget.listType) {
        case 'critical_level':
        return items.where(
          (item) => item['stock'] > 0 && item['stock'] < 5
          ).toList();

        case 'out_of_stock':
        return items.where(
          (item) => item['stock'] == 0
          ).toList();
        
        case 'inventory':
        default:
          return items;
      }
    }

      @override
    Widget build(BuildContext context) {
      final sortedItems = getItems();

      return ListView.builder(
        itemCount: sortedItems.length,
        itemBuilder: (context, index) {

          final item = sortedItems[index];

          String stockStatus;
          Color stockColor;
          int stock = item['stock'];

          if (stock == 0) {
            stockStatus = "Out of Stock";
            stockColor = Colors.redAccent;
          } else if (stock < 5) {
            stockStatus = "Critical Level: $stock";
            stockColor = Colors.orangeAccent;
          } else {
            stockStatus = "Stock: $stock";
            stockColor = Colors.black;
          }

          return Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey, 
                width: 0.1,
                ),
            ),
            
            child: ListTile(
              leading: Image.asset(
                "assets/image/${item['image']}",
                width: Dimensions.width50,
                height: Dimensions.height50,
                errorBuilder: (context, error, stackTracer) {
                  return Image.asset("assets/image/food0.png", width: Dimensions.width50, height: Dimensions.height50);
                },
              ),
                title: Text("${item['name']}"),
                subtitle: Text(
                stockStatus,
                style: TextStyle(color: stockColor),
            ),
            )
          );
        }
      );
  }
}