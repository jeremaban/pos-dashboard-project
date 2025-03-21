import 'package:flutter/material.dart';
import 'package:pos_dashboard/core/utils/dimensions.dart';
import 'package:pos_dashboard/presentation/widgets/date_selector.dart';

class SalesDetailsPage extends StatefulWidget {
  const SalesDetailsPage({super.key});
  @override
  _SalesDetailsPageState createState() => _SalesDetailsPageState();
}

class _SalesDetailsPageState extends State<SalesDetailsPage> {
  DateTime _selectedDate = DateTime.now();
  Map<String, double> _salesData = {
    'Gross Sales': 1500.00,
    'Refunds': 100.00,
    'Discounts': 50.00,
  };

  Map<String, double> _fetchSalesData(DateTime date) => {
        'Gross Sales': 1500.00,
        'Refunds': 100.00,
        'Discounts': 50.00,
        'Net Sales': 1350.00,
        'Taxes': 135.00,
        'Tips': 75.00,
        'Total Tendered': 1560.00,
        'Cost of Goods': 600.00,
        'Gross Profit': 750.00,
      };

  @override
  Widget build(BuildContext context) {
    final data = _salesData;
    final grossSales = data['Gross Sales'] ?? 0.0;
    final refunds = data['Refunds'] ?? 0.0;
    final discounts = data['Discounts'] ?? 0.0;
    final netSales = data['Net Sales'] ?? 0.0;
    final taxes = data['Taxes'] ?? 0.0;
    final tips = data['Tips'] ?? 0.0;
    final totalTendered = data['Total Tendered'] ?? 0.0;
    final costOfGoods = data['Cost of Goods'] ?? 0.0;
    final grossProfit = data['Gross Profit'] ?? 0.0;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          'Sales Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF00308F),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(Dimensions.height16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DateSelector(
              selectedDate: _selectedDate,
              onDateChanged: (newDate) {
                setState(() {
                  _selectedDate = newDate;
                  _salesData = _fetchSalesData(_selectedDate);
                });
              },
            ),
            SizedBox(height: Dimensions.height30),
            _buildDetailRow('Gross Sales', grossSales, isBold: true),
            SizedBox(height: Dimensions.height20),
            _buildDetailRow('Refunds', refunds),
            SizedBox(height: Dimensions.height20),
            _buildDetailRow('Discounts', discounts),
            const Divider(),
            SizedBox(height: Dimensions.height20),
            _buildDetailRow('Net Sales', netSales, isBold: true),
            SizedBox(height: Dimensions.height20),
            _buildDetailRow('Taxes', taxes),
            SizedBox(height: Dimensions.height20),
            _buildDetailRow('Tips', tips),
            const Divider(),
            SizedBox(height: Dimensions.height20),
            _buildDetailRow('Total Tendered', totalTendered, isBold: true),
            const Divider(),
            SizedBox(height: Dimensions.height20),
            _buildDetailRow('Cost of Goods', costOfGoods),
            SizedBox(height: Dimensions.height20),
            _buildDetailRow('Gross Profit', grossProfit, isBold: true),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, double value, {bool isBold = false}) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: Dimensions.font16,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            Text(
              '₱${value.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: Dimensions.font16,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      );
}
