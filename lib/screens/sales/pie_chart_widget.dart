import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

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
    double size = 80;

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
        const SizedBox(height: 40),
        Text(
          '$title: ${percentage.toStringAsFixed(1)}%',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}