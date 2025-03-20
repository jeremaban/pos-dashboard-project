import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BarChartWidget extends StatelessWidget {
  final List<DateTime> dates;
  final List<double> values;

  const BarChartWidget({super.key, required this.dates, required this.values});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: SizedBox(
        height: 280, 
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.center, 
            barTouchData: BarTouchData(
              touchTooltipData: BarTouchTooltipData(
                tooltipPadding: const EdgeInsets.all(6),
                tooltipBorder: const BorderSide(color: Colors.blueGrey, width: 1),
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  return BarTooltipItem(
                    '₱${values[groupIndex].toStringAsFixed(2)}', 
                    const TextStyle(
                      color: Colors.white, 
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      '₱${value.toInt()}', 
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                    );
                  },
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  getTitlesWidget: (value, meta) {
                    int index = value.toInt();
                    if (index < 0 || index >= dates.length) return const SizedBox.shrink();
                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        '${dates[index].day} ${_getMonthAbbreviation(dates[index].month)}',
                        style: const TextStyle(color: Colors.black, fontSize: 12),
                      ),
                    );
                  },
                ),
              ),
              topTitles: const AxisTitles(sideTitles: SideTitles(reservedSize: 0)),
              rightTitles: const AxisTitles(sideTitles: SideTitles(reservedSize: 0)),
            ),
            borderData: FlBorderData(show: false),
            barGroups: List.generate(dates.length, (index) {
              return BarChartGroupData(
                x: index, 
                barRods: [
                  BarChartRodData(
                    toY: values[index],
                    color: const Color(0xFF00308F), 
                    width: 22, 
                    borderRadius: BorderRadius.circular(6),
                  ),
                ],
                barsSpace: 15, 
              );
            }),
            gridData: FlGridData(
              show: true,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Colors.grey.withOpacity(0.3),
                  strokeWidth: 1,
                );
              },
              drawVerticalLine: false,
            ),
            groupsSpace: 70,
          ),
        ),
      ),
    );
  }

  String _getMonthAbbreviation(int month) {
    const monthAbbreviations = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return monthAbbreviations[month - 1];
  }
}
