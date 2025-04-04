import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_dashboard/core/utils/dimensions.dart';
import 'package:pos_dashboard/data/models/top_dashboard_model.dart';
import 'package:pos_dashboard/presentation/controllers/top_dashboard_controller.dart';
import 'package:pos_dashboard/presentation/screens/sales/main_sales_widget.dart';
import 'package:pos_dashboard/presentation/screens/settings/settings_screen.dart';

class CategoriesSection extends StatefulWidget {
  const CategoriesSection({super.key});

  @override
  _CategoriesSectionState createState() => _CategoriesSectionState();
}

class _CategoriesSectionState extends State<CategoriesSection> {
  final TopDashboardController topDashboardController =
    Get.find<TopDashboardController>();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    await topDashboardController.getTopList();
  }

  List<Top5Categories> getCategories() {
    if (topDashboardController.top5CategoriesList.isEmpty) {
      return [];
    }

    return topDashboardController.top5CategoriesList;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();

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
          GetBuilder<TopDashboardController>(
            builder: (controller) {
              List<Top5Categories> categories = getCategories();
              if (controller.top5CategoriesList.isEmpty) {
                return const Center(child: Text("No categories found"));
              }

              List<Top5Categories> topCategories = List.from(controller.top5CategoriesList);
              topCategories.sort(
                (a, b) => (b.grossSales ?? 0).compareTo(a.grossSales ?? 0),
              );
              topCategories = topCategories.take(3).toList();

              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: topCategories.length,
                separatorBuilder: (context, index) => Divider(
                  color: Colors.grey.shade300,
                  thickness: 1,
                ),
                itemBuilder: (context, index) {
                  var category = topCategories[index];

                  String categoryName = category.categoryName ?? "Unknown Item";
                  if (categoryName.length > 20) {
                    categoryName = '${categoryName.substring(0, 20)}...';
                  }

                  double quantity = category.grossSales ?? 0;

                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: Dimensions.height8),
                    child: MainSalesWidget(
                      itemName: categoryName,
                      quantity: quantity,
                      // itemImage: Image.network(
                      //   imageUrl,
                      //   width: 60,
                      //   height: 60,
                      //   fit: BoxFit.cover,
                      //   errorBuilder: (context, error, stackTrace) =>
                      //       const Icon(Icons.image_not_supported),
                      // ),
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