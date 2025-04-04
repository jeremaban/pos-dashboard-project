import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_dashboard/presentation/controllers/top_dashboard_controller.dart';
import 'bar_chart_widget.dart';

class BarChartSection extends StatefulWidget {
  const BarChartSection({super.key});

  @override
  State<BarChartSection> createState() => _BarChartSectionState();
}

class _BarChartSectionState extends State<BarChartSection> {
  final TopDashboardController topDashboardController =
      Get.find<TopDashboardController>();
  late List<DateTime> dates;
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    _initializeDates();
  }

  void _initializeDates() {
    selectedDate = DateTime.now();
    dates = List.generate(24, (index) {
      return DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        index,
      );
    });
  }

  List<double> _parseHourlyData(String? barchartData) {
    if (barchartData == null) return List.filled(24, 0.0);
    final values = barchartData.split(',');
    return values.map((v) => double.tryParse(v) ?? 0.0).toList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TopDashboardController>(
      builder: (controller) {
        final hourlyValues = _parseHourlyData(controller.barchartPerHour);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            BarChartWidget(
              dates: dates,
              values: hourlyValues,
              selectedDate: selectedDate,
            ),
          ],
        );
      },
    );
  }
}
