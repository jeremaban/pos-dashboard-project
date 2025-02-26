import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pos_dashboard/utilities/dimensions.dart';

class PieChartWidget extends StatelessWidget {
  final String title;
  final double percentage;
  final Color color;

  const PieChartWidget({
    super.key,
    required this.title,
    required this.percentage,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: SizedBox(
            height: Dimensions.height80,
            width: Dimensions.width80,
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
        SizedBox(height: Dimensions.height40),
        Text(
          '$title: ${percentage.toStringAsFixed(1)}%',
          style: TextStyle(fontSize: Dimensions.font16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}