import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_dashboard/core/utils/dimensions.dart';
import 'package:pos_dashboard/data/models/top_dashboard_model.dart';
import 'package:pos_dashboard/presentation/controllers/top_dashboard_controller.dart';
import 'package:pos_dashboard/presentation/screens/sales/main_sales_widget.dart';
import 'package:pos_dashboard/presentation/screens/settings/settings_screen.dart';

class ItemsSection extends StatefulWidget {
  const ItemsSection({super.key});

  @override
  _ItemsSectionState createState() => _ItemsSectionState();
}

class _ItemsSectionState extends State<ItemsSection> {
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

  List<Top5Items> getItems() {
    if (topDashboardController.top5ItemsList.isEmpty) {
      return [];
    }

    return topDashboardController.top5ItemsList;
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
          GetBuilder<TopDashboardController>(
            builder: (controller) {
              List<Top5Items> items = getItems();
              if (controller.top5ItemsList.isEmpty) {
                return const Center(child: Text("No items found"));
              }

              List<Top5Items> topItems = List.from(controller.top5ItemsList);
              topItems.sort(
                (a, b) => (b.grossSales ?? 0).compareTo(a.grossSales ?? 0),
              );
              topItems = topItems.take(3).toList();

              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: topItems.length,
                separatorBuilder:
                    (context, index) =>
                        Divider(color: Colors.grey.shade300, thickness: 1),
                itemBuilder: (context, index) {
                  var item = topItems[index];

                  String itemName = item.itemName ?? "Unknown Item";
                  if (itemName.length > 20) {
                    itemName = '${itemName.substring(0, 20)}...';
                  }

                  double quantity = item.grossSales ?? 0;

                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: Dimensions.height8),
                    child: MainSalesWidget(
                      itemName: itemName,
                      quantity: quantity,
                      itemImage: Image.network(
                        "Icons.image_not_supported",
                        width: Dimensions.width60,
                        height: Dimensions.height60,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.image_not_supported,
                          );
                        },
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
