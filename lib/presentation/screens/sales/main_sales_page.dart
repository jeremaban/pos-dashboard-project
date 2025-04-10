import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pos_dashboard/core/utils/dimensions.dart';
import 'package:pos_dashboard/data/models/merchant_model.dart';
import 'package:pos_dashboard/presentation/controllers/merchant_controller.dart';
import 'package:pos_dashboard/presentation/controllers/top_dashboard_controller.dart';
import 'package:pos_dashboard/presentation/screens/categories/categories_section.dart';
import 'package:pos_dashboard/presentation/screens/employees/employees_section.dart';
import 'package:pos_dashboard/presentation/screens/sales/charts/chart_section.dart';
import 'package:pos_dashboard/presentation/screens/items/item_section.dart';
import 'package:pos_dashboard/presentation/widgets/date_selector.dart';

class MainSalesPage extends StatefulWidget {
  const MainSalesPage({super.key});

  @override
  _MainSalesPage createState() => _MainSalesPage();
}

class _MainSalesPage extends State<MainSalesPage> {
  final MerchantController merchantController = Get.find<MerchantController>();
  final TopDashboardController topDashboardController = Get.find<TopDashboardController>();

  DateTime selectedDate = DateTime.now();
  int? selectedStoreId;
  String? selectedStoreName;

  @override
  void initState() {
    super.initState();
    _loadData();

  }

  void _loadData() async {
    await merchantController.getMerchantList();
    
    if (merchantController.storeList.isNotEmpty) {
      setState(() {
        selectedStoreId = merchantController.storeList[0].storeId;
        selectedStoreName = merchantController.storeList[0].storeName;
      });

      topDashboardController.getTopList(date: selectedDate, storeIds: [selectedStoreId!]);
    }
  }

  List<Stores> getStores() {
    if (merchantController.storeList.isEmpty) {
      return [];
    }

    return merchantController.storeList;
  }

  @override
  Widget build(BuildContext context) {
    String? _viewMode;

    return SingleChildScrollView(
      padding: EdgeInsets.all(Dimensions.font18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: DateSelector(
                    selectedDate: selectedDate,
                    onDateChanged: (newDate) {
                      setState(() {
                        selectedDate = newDate;
                      });
                    },
                  ),
                ),
                SizedBox(width: Dimensions.width10),
                Obx(() {
                  if (merchantController.isLoading.value) {
                    return const CircularProgressIndicator();
                  }

                  if (merchantController.storeList.isEmpty) {
                    return Flexible(
                      child: Text('Unknown',
                      style: TextStyle(fontSize: Dimensions.font12),
                      overflow: TextOverflow.ellipsis),
                    );
                  }
                
                  return Flexible(
                    child: DropdownButton<int>(
                      icon: Icon(Icons.arrow_drop_down, size: Dimensions.height16),
                      underline: Container(),
                      isExpanded: true,
                      style: TextStyle(
                        fontSize: Dimensions.font12,
                        color: Colors.grey[700],
                      ),
                      value: selectedStoreId,
                      items: merchantController.storeList.map((store) {
                        return DropdownMenuItem(
                          value: store.storeId,
                          child: Text(
                            store.storeName ?? 'Unknown Store',
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedStoreId = value;
                          selectedStoreName = merchantController.storeList
                            .firstWhere((store) => store.storeId == value)
                            .storeName;

                        final topDashboardContoller = Get.find<TopDashboardController>();
                        topDashboardContoller.getTopList(
                          date: selectedDate,
                          storeIds: [selectedStoreId!],
                          );
                        });
                      },
                      hint: Text('Select Store', 
                        style: TextStyle(fontSize: Dimensions.font12),
                        overflow: TextOverflow.ellipsis
                      ),
                    ),
                  );
                }),
              ],
            ),
          SizedBox(height: Dimensions.height20),
          const ChartSection(),
          SizedBox(height: Dimensions.height20),
          const ItemsSection(),
          SizedBox(height: Dimensions.height20),
          const CategoriesSection(),
          SizedBox(height: Dimensions.height20),
          const EmployeesSection(),
        ],
      ),
    );
  }
}
