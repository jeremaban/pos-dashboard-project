import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'sales_details_page.dart';
import 'pie_chart_widget.dart';
import 'bar_chart_widget.dart';
import '../employees/employee_widget.dart';

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
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDateSelector(context),
          const SizedBox(height: 20),
          const Center(
            child: Text('SALES SUMMARY', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ),
          const SizedBox(height: 20),
          _buildSalesChartsAndDetails(context),
          const SizedBox(height: 20),
          _buildEmployeeSection(),
        ],
      ),
    );
  }

  Widget _buildDateSelector(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(DateFormat.yMMMMd().format(selectedDate), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
        children: const [
          SizedBox(height: 35),
          PieChartWidget(title: 'Receipts', percentage: 15, color: Colors.blue),
          SizedBox(height: 55),
          PieChartWidget(title: 'Net Sales', percentage: 60, color: Colors.green),
          SizedBox(height: 55),
          PieChartWidget(title: 'Average Sale', percentage: 25, color: Colors.orange),
          SizedBox(height: 55),
        ] + [BarChartWidget(dates: dates, netSales: netSales)],
      ),
    );
  }

  Widget _buildEmployeeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'EMPLOYEES',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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