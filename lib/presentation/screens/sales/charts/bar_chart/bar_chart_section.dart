import 'package:flutter/material.dart';
import 'bar_chart_widget.dart';

class BarChartSection extends StatelessWidget {
  final List<DateTime> dates;
  final List<double> values;

  const BarChartSection({super.key, required this.dates, required this.values});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        BarChartWidget(dates: dates, values: values),
      ],
    );
  }
}
