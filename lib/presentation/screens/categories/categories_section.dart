import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_dashboard/core/utils/app_constants.dart';
import 'package:pos_dashboard/core/utils/dimensions.dart';
import 'package:pos_dashboard/data/models/items_model.dart';
import 'package:pos_dashboard/presentation/controllers/item_controller.dart';
import 'package:pos_dashboard/presentation/screens/categories/categories_widget.dart';
import 'package:pos_dashboard/presentation/screens/items/items_widget.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ItemController itemController = Get.find<ItemController>();

    return Container(
      padding: EdgeInsets.all(Dimensions.width16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.height12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: Dimensions.height6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'CATEGORIES',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Dimensions.font18,
                color: const Color(0xFF00308F), // Air Force Blue
              ),
            ),
          ),
          SizedBox(height: Dimensions.height10),
          GetBuilder<ItemController>(
            builder: (controller) {
              if (controller.categoryList.isEmpty) {
                return const Center(child: Text("No categories found"));
              }

              Map<Categories, double> categoryPriceMap = {};

              for (var category in controller.categoryList) {
                List<Items> categoryItems = controller.itemList
                    .where((item) => item.categoryId == category.id)
                    .toList();

                double totalPrice = 0;
                for (var item in categoryItems) {
                  //PRICE FOR UI, CHANGE TO SALES LATER
                  totalPrice += item.price ?? 0;
                }

                categoryPriceMap[category] = totalPrice;
              }

              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.categoryList.length,
                separatorBuilder: (context, index) => Divider(
                  color: Colors.grey.shade300,
                  thickness: 1,
                ),
                itemBuilder: (context, index) {
                  var category = controller.categoryList[index];
                  double totalPrice = categoryPriceMap[category] ?? 0;

                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: Dimensions.height8),
                    child: CategoriesWidget(
                      categoryName: category.categoryName ?? "Unknwon Category", 
                      totalSales: totalPrice, 
                      ),
                  );

                  // String itemName = item.itemName ?? "Unknown Item";
                  // if (itemName.length > 20) {
                  //   itemName = '${itemName.substring(0, 20)}...';
                  // }

                  // int quantity = item.currentStock ?? 0;
                  // String imageUrl = "${AppConstants.BASE_URL}${item.imgUrl}";

                  // return Padding(
                  //   padding: EdgeInsets.symmetric(vertical: Dimensions.height8),
                  //   child: ItemsWidget(
                  //     itemName: itemName,
                  //     quantity: quantity,
                  //     itemImage: Image.network(
                  //       imageUrl,
                  //       width: 60,
                  //       height: 60,
                  //       fit: BoxFit.cover,
                  //       errorBuilder: (context, error, stackTrace) =>
                  //           const Icon(Icons.image_not_supported),
                  //     ),
                  //   ),
                  // );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}