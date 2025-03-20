import 'package:flutter/material.dart';
import 'package:pos_dashboard/core/utils/dimensions.dart';
import 'package:pos_dashboard/presentation/screens/sales/sales_details_page.dart';
import 'package:pos_dashboard/presentation/screens/sales/charts/gauge_chart/gauge_chart_section.dart';
import 'package:pos_dashboard/presentation/screens/sales/charts/bar_chart/bar_chart_section.dart';

class ChartSection extends StatelessWidget {
  final List<DateTime> dates;
  final List<double> netSales;

  const ChartSection({super.key, required this.dates, required this.netSales});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SalesDetailsPage()),
      ),
      child: Container(
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: Dimensions.height10),
              child: Text(
                'SALES SUMMARY',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Dimensions.font18,
                  color: Color(0xFF00308F),
                ),
              ),
            ),
             SizedBox(height: Dimensions.height20),
            GaugeChartSection(),
            SizedBox(height: Dimensions.height20),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Dimensions.height10),
                BarChartSection(dates: dates, values: netSales),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
