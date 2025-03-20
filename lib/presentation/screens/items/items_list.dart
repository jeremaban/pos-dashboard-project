import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_dashboard/presentation/controllers/product_controller.dart';
import 'package:pos_dashboard/core/utils/app_constants.dart';

class ItemsList extends StatefulWidget {

  final String listType;
 
  const ItemsList({super.key, this.listType = 'inventory'});

    @override
    _ItemsListState createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList>{
    final PopularProductController popularProductController = Get.find<PopularProductController>();

    @override
    void initState() {
      super.initState();
      _loadData();
    }

    void _loadData() async {
      await popularProductController.getPopularProductList();
    }

    List<dynamic> getItems() {
      if(popularProductController.popularProductList.isEmpty) {
        return [];
      }

      switch (widget.listType) {
        case 'critical_level':
        return popularProductController.popularProductList.where(
          (item) => item.stars > 0 && item.stars < 5
          ).toList();

        case 'out_of_stock':
        return popularProductController.popularProductList.where(
          (item) => item.stars == 0
          ).toList();
        
        case 'inventory':
        default:
          return popularProductController.popularProductList;
      }
    }

    @override
    Widget build(BuildContext context) {
      return GetBuilder<PopularProductController>(
        builder: (controller) {
      
          List<dynamic> items = getItems();

        
          return items.isEmpty
          ? const Center(child: Text("No items found"))
          : ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              var item = items[index];

              String stockStatus;
              Color stockColor;
              int stock = item.stars;

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
                  "${AppConstants.BASE_URL}${AppConstants.UPLOAD_URL}${item.img}",
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                  errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image_not_supported),
                ),
                  title: Text(item.name),
                  subtitle: Text(
                    stockStatus,
                    style: TextStyle(color: stockColor),
                  ),
              );
            },
            );
        }
      );
    }}