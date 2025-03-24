import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_dashboard/core/utils/dimensions.dart';
import 'package:pos_dashboard/presentation/controllers/item_controller.dart';
import 'package:pos_dashboard/core/utils/app_constants.dart';
import 'items_widget.dart';
import 'package:pos_dashboard/data/models/items_model.dart'; 

class ItemsSection extends StatelessWidget {
  const ItemsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ItemController itemController = Get.find<ItemController>();

    return Container(
      padding: EdgeInsets.all(Dimensions.width16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'ITEMS',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Dimensions.font18,
                color: const Color(0xFF00308F),
              ),
            ),
          ),
          SizedBox(height: Dimensions.height10),
          GetBuilder<ItemController>(
            builder: (controller) {
              if (controller.itemList.isEmpty) {
                return const Center(child: Text("No items found"));
              }

              List<Items> topItems = List.from(controller.itemList);
              topItems.sort((a, b) => (b.currentStock ?? 0).compareTo(a.currentStock ?? 0));
              topItems = topItems.take(3).toList();

              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: topItems.length,
                separatorBuilder: (context, index) => Divider(
                  color: Colors.grey.shade300,
                  thickness: 1,
                ),
                itemBuilder: (context, index) {
                  var item = topItems[index];

                  String itemName = item.itemName ?? "Unknown Item";
                  if (itemName.length > 20) {
                    itemName = '${itemName.substring(0, 20)}...';
                  }

                  int quantity = item.currentStock ?? 0;

                  String imageUrl = "${AppConstants.BASE_URL}${item.imgUrl}";

                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: Dimensions.height8),
                    child: ItemsWidget(
                      itemName: itemName,
                      quantity: quantity,
                      itemImage: Image.network(
                        imageUrl,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.image_not_supported),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}