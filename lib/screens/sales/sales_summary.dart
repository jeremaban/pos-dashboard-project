import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pos_dashboard/screens/items/categories_widget.dart';
import 'package:pos_dashboard/screens/items/items_widget.dart';
import 'package:pos_dashboard/utilities/dimensions.dart';
import 'sales_details_page.dart';
import 'pie_chart_widget.dart';
import 'bar_chart_widget.dart';
import '../items/employee_widget.dart';

class SalesSummary extends StatefulWidget {
  const SalesSummary({super.key});

  @override
  _SalesSummaryState createState() => _SalesSummaryState();
}

class _SalesSummaryState extends State<SalesSummary> {
  DateTime selectedDate = DateTime.now();
  final List<DateTime> dates = [
    DateTime.now().subtract(const Duration(days: 2)),
    DateTime.now().subtract(const Duration(days: 1)),
    DateTime.now(),
  ];
  final List<double> netSales = [200, 350, 500];

  void _selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() => selectedDate = pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(Dimensions.font18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDateSelector(context),
          SizedBox(height: Dimensions.height20),
          Center(
            child: Text('SALES SUMMARY', style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.font18)),
          ),
          SizedBox(height: Dimensions.height20),
          _buildSalesChartsAndDetails(context),
          SizedBox(height: Dimensions.height20),
          _buildSalesSelection(),
          SizedBox(height: Dimensions.height20),
          _buildCategoriesSection(),
          SizedBox(height: Dimensions.height20),
          _buildEmployeeSection(),
        ],
      ),
    );
  }

  Widget _buildDateSelector(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(DateFormat.yMMMMd().format(selectedDate), style: TextStyle(fontSize: Dimensions.font18, fontWeight: FontWeight.bold)),
        ElevatedButton(onPressed: () => _selectDate(context), child: const Text("Select Date")),
      ],
    );
  }

  Widget _buildSalesChartsAndDetails(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SalesDetailsPage())),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          SizedBox(height: Dimensions.height35),
          PieChartWidget(title: 'Receipts', percentage: 15, color: Colors.blue),
          SizedBox(height: Dimensions.height55),
          PieChartWidget(title: 'Net Sales', percentage: 60, color: Colors.green),
          SizedBox(height: Dimensions.height55),
          PieChartWidget(title: 'Average Sale', percentage: 25, color: Colors.orange),
          SizedBox(height: Dimensions.height55),
        ] + [BarChartWidget(dates: dates, netSales: netSales)],
      ),
    );
  }

  Widget _buildSalesSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.all(Dimensions.width16),
          child: Text(
            'ITEMS',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.font18),
            textAlign: TextAlign.center,
          ),
        ),
        Column(
          children: [
            ItemsWidget(itemName: 'Item 1', netSales: 1289.00, itemImage: Image.asset("assets/image/food0.png"),),
            ItemsWidget(itemName: 'Item 2', netSales: 2168.50, itemImage: Image.asset("assets/image/food1.png"),),
            ItemsWidget(itemName: 'Item 3', netSales: 700.50, itemImage: Image.asset("assets/image/food2.png"),),
          ],
        ),
      ],
    );
  }

  Widget _buildCategoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.all(Dimensions.width16),
          child: Text(
            'CATEGORIES',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.font18),
            textAlign: TextAlign.center,
          ),
        ),
        Column(
          children: [
            CategoriesWidget(categoryName: 'Item 1', netSales: 1289.00, circleColor: Colors.red,),
            CategoriesWidget(categoryName: 'Item 2', netSales: 1289.00, circleColor: Colors.brown,),
            CategoriesWidget(categoryName: 'Item 3', netSales: 1289.00, circleColor: Colors.green,),
          ],
        ),
      ],
    );
  }

  Widget _buildEmployeeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.all(Dimensions.width16),
          child: Text(
            'EMPLOYEES',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.font18),
            textAlign: TextAlign.center,
          ),
        ),
        const Column(
          children: [
            EmployeeWidget(employeeName: 'Owner', netSales: 2268.50, circleColor: Colors.red),
            EmployeeWidget(employeeName: 'John', netSales: 1617.70, circleColor: Colors.brown),
            EmployeeWidget(employeeName: 'Jane', netSales: 2560.60, circleColor: Colors.green),
          ],
        ),
      ],
    );
  }
}