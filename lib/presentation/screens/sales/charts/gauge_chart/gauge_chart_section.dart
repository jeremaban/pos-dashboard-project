import 'package:flutter/material.dart';
import 'package:pos_dashboard/core/utils/dimensions.dart';
import 'gauge_chart_widget.dart';

class GaugeChartSection extends StatelessWidget {
  const GaugeChartSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          GaugeChartWidget(
            title: 'Receipts',
            percentage: 15,
            value: 27,
            color: Colors.orange,
            changePercentage: 35,
            sizeFactor: 0.8,
          ),
          SizedBox(width: Dimensions.width20),
          GaugeChartWidget(
            title: 'Net Sales',
            percentage: 60,
            value: 5309,
            color: Colors.green,
            changePercentage: 21,
            sizeFactor: 0.8,
          ),
          SizedBox(width: Dimensions.width20),
          GaugeChartWidget(
            title: 'Average Sale',
            percentage: 25,
            value: 197,
            color: Colors.blue,
            changePercentage: -9,
            sizeFactor: 0.8,
          ),
        ],
      ),
    );
  }
}