import 'package:flutter/material.dart';
import 'package:pos_dashboard/core/utils/dimensions.dart';
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
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(Dimensions.font18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DateSelector(
            selectedDate: selectedDate,
            onDateChanged: (newDate) {
              setState(() {
                selectedDate = newDate;
              });
            },
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
