// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'sales_details_page.dart'; // Import SalesDetailsPage

class SalesSummary extends StatefulWidget {
  const SalesSummary({super.key});

  @override
  _SalesSummaryState createState() => _SalesSummaryState();
}

class _SalesSummaryState extends State<SalesSummary> {
  DateTime selectedDate = DateTime.now();

  void _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
Widget build(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              DateFormat.yMMMMd().format(selectedDate),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: const Text("Select Date"),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Center(
          child: Text(
            'Sales Summary',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 50),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SalesDetailsPage()),
            );
          },
          child: Column(
            children: [
              _buildPieChart('Receipts', 15, Colors.blue),
              const SizedBox(height: 55), // Space between Receipts and Net Sales
              _buildPieChart('Net Sales', 60, Colors.green),
              const SizedBox(height: 55), // Space between Net Sales and Average Sale
              _buildPieChart('Average Sale', 25, Colors.orange),
              const SizedBox(height: 55), // Space before Bar Chart
              _buildBarChart(),
            ],
          ),
        ),
      ],
    ),
  );
}

  Widget _buildPieChart(String title, double percentage, Color color) {
  double size = 80; // Default size (you can adjust this)

  return Column(
    children: [
      Center(
        child: SizedBox(
          height: size,
          width: size,
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 40,
              sections: [
                PieChartSectionData(
                  value: percentage,
                  color: color,
                  showTitle: false,
                ),
              ],
            ),
          ),
        ),
      ),
      const SizedBox(height: 40), // Reduced space to 10
      Text(
        '$title: ${percentage.toStringAsFixed(1)}%',
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ],
  );
}
Widget _buildBarChart() {
  List<DateTime> dates = [
    DateTime.now().subtract(const Duration(days: 2)),
    DateTime.now().subtract(const Duration(days: 1)),
    DateTime.now(),
  ];
  List<double> netSales = [2000, 3500, 5000];

  return SizedBox(
    height: 300, // Increased height
    width: 280, // Decreased width
    child: BarChart(
      BarChartData(
        barGroups: dates
            .asMap()
            .map((index, date) => MapEntry(
                  index,
                  BarChartGroupData(x: index, barRods: [
                    BarChartRodData(toY: netSales[index], color: Colors.blue)
                  ]),
                ))
            .values
            .toList(),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index >= 0 && index < dates.length) {
                  return Text(DateFormat('MM/dd').format(dates[index]),
                      style: const TextStyle(fontSize: 10));
                }
                return const Text('');
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                String text = '${value.toInt()}K';
                return Text(text, style: const TextStyle(fontSize: 10));
              },
            ),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
      ),
    ),
  );
}
}