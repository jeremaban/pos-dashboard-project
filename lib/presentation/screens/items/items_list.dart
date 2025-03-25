import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_dashboard/core/utils/dimensions.dart';
import 'package:pos_dashboard/presentation/controllers/item_controller.dart';
import 'package:pos_dashboard/core/utils/app_constants.dart';
import 'package:pos_dashboard/data/models/items_model.dart'; // Import the Items model

class ItemsList extends StatefulWidget {
  final String listType;

  const ItemsList({super.key, this.listType = 'inventory'});

  @override
  _ItemsListState createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
  final ItemController itemController = Get.find<ItemController>();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    await itemController.getItemList();
  }

  List<Items> getItems() { // Corrected to List<Items>
    if (itemController.itemList.isEmpty) {
      return [];
    }

    switch (widget.listType) {
      case 'critical_level':
        return itemController.itemList
            .where((item) => item.currentStock! > 0 && item.currentStock! < 5)
            .toList();

      case 'out_of_stock':
        return itemController.itemList
            .where((item) => item.currentStock == 0)
            .toList();

      case 'inventory':
      default:
        return itemController.itemList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ItemController>( //Corrected GetBuilder
      builder: (controller) {
        List<Items> items = getItems(); // Corrected to List<Items>

        return items.isEmpty
            ? const Center(child: Text("No items found"))
            : ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  var item = items[index];

                  String stockStatus;
                  Color stockColor;
                  int stock = item.currentStock!;

                  if (stock == 0) {
                    stockStatus = "Out of Stock";
                    stockColor = Colors.redAccent;
                  } else if (stock < 5) {
                    stockStatus = "Critical Level: $stock";
                    stockColor = Colors.orangeAccent;
                  } else {
                    stockStatus = "$stock in stock";
                    stockColor = Colors.black;
                  }

                  return ListTile(
                    leading: Image.network(
                      "${AppConstants.BASE_URL}${item.imgUrl}",
                      width: Dimensions.height50,
                      height: Dimensions.height50,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.image_not_supported),
                    ),
                    title: Text(item.itemName!),
                    subtitle: Text(
                      stockStatus,
                      style: TextStyle(color: stockColor),
                    ),
                  );
                },
              );
      },
    );
  }
}