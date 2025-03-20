import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_dashboard/core/utils/dimensions.dart';
import 'package:pos_dashboard/presentation/controllers/product_controller.dart';
import 'package:pos_dashboard/core/utils/app_constants.dart';
import 'items_widget.dart';

class ItemsSection extends StatelessWidget {
  const ItemsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final PopularProductController productController = Get.find<PopularProductController>();

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

          GetBuilder<PopularProductController>(
            builder: (controller) {
              if (controller.popularProductList.isEmpty) {
                return const Center(child: Text("No items found"));
              }

              List<dynamic> topItems = List.from(controller.popularProductList)
                ..sort((a, b) => (b.stars ?? 0).compareTo(a.stars ?? 0));

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

                  String itemName = item.name ?? "Unknown Item";
                  if (itemName.length > 20) {
                    itemName = '${itemName.substring(0, 20)}...';
                  }

                  int quantity = item.stars?.toInt() ?? 0;

                  // Ensure the image URL is complete
                  String imageUrl = "${AppConstants.BASE_URL}${AppConstants.UPLOAD_URL}${item.img}";

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
