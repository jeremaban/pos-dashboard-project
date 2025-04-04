import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BarChartWidget extends StatefulWidget {
  final List<DateTime> dates;
  final List<double> values;
  final DateTime selectedDate;

  const BarChartWidget({
    super.key,
    required this.dates,
    required this.values,
    required this.selectedDate,
  });

  @override
  State<BarChartWidget> createState() => _BarChartWidgetState();
}

class _BarChartWidgetState extends State<BarChartWidget> {
  double _minX = 0;
  double _maxX = 3;
  double _visibleBars = 4.0; 

  String _getTooltipText(int index) {
    if (index < 0 || index >= widget.values.length) return '';
    return '${index}:00\n₱${widget.values[index].toStringAsFixed(2)}';
  }

  Widget _getBottomTitle(double value) {
    final index = value.toInt();
    if (index < 0 || index >= widget.dates.length) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        '${index}:00',
        style: const TextStyle(color: Colors.black, fontSize: 12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: GestureDetector(
        onHorizontalDragUpdate: (details) {
          setState(() {
            final maxAllowed = widget.dates.length - _visibleBars;
            _minX = (_minX - details.delta.dx / 50).clamp(0.0, maxAllowed);
            _maxX = _minX + _visibleBars;
          });
        },
        child: SizedBox(
          height: 280,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.center,
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  tooltipPadding: const EdgeInsets.all(6),
                  tooltipBorder: const BorderSide(
                    color: Colors.blueGrey,
                    width: 1,
                  ),
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    return BarTooltipItem(
                      _getTooltipText(group.x.toInt()),
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
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      );
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) => _getBottomTitle(value),
                  ),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(reservedSize: 0),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(reservedSize: 0),
                ),
              ),
              borderData: FlBorderData(show: false),
              barGroups:
                  List.generate(widget.dates.length, (index) {
                        return BarChartGroupData(
                          x: index,
                          barRods: [
                            BarChartRodData(
                              toY: widget.values[index],
                              color: const Color(0xFF00308F),
                              width: 30,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ],
                          barsSpace: 20,
                        );
                      })
                      .where((group) => group.x >= _minX && group.x <= _maxX)
                      .toList(),
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
              groupsSpace: 50,
              minY: 0,
              maxY: widget.values.reduce(max),
            ),
          ),
        ),
      ),
    );
  }
}
