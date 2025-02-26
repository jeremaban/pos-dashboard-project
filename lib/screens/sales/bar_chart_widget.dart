import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class BarChartWidget extends StatelessWidget {
  final List<DateTime> dates;
  final List<double> netSales;

  const BarChartWidget({
    super.key,
    required this.dates,
    required this.netSales,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
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
                  String text = '${value.toInt()}';
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