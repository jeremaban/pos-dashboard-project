import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_dashboard/core/utils/dimensions.dart';
import 'package:pos_dashboard/presentation/controllers/top_dashboard_controller.dart';
import 'package:pos_dashboard/presentation/widgets/date_selector.dart';

class SalesDetailsPage extends StatefulWidget {
  const SalesDetailsPage({super.key});
  @override
  _SalesDetailsPageState createState() => _SalesDetailsPageState();
}

class _SalesDetailsPageState extends State<SalesDetailsPage> {
  DateTime _selectedDate = DateTime.now();
  late TopDashboardController _topDashboardController;

  @override
  void initState() {
    super.initState();
    _topDashboardController = Get.find<TopDashboardController>();
    _refreshData();
  }

  void _refreshData() {
    _topDashboardController.getTopList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Sales Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF00308F),
      ),
      backgroundColor: Colors.white,
      body: GetBuilder<TopDashboardController>(
        builder: (controller) {
          final model = controller.topDashboardModel;

          return Padding(
            padding: EdgeInsets.all(Dimensions.height16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DateSelector(
                  selectedDate: _selectedDate,
                  onDateChanged: (newDate) {
                    setState(() {
                      _selectedDate = newDate;
                      _refreshData();
                    });
                  },
                ),
                SizedBox(height: Dimensions.height30),
                _buildDetailRow(
                  'Gross Sales',
                  model?.grossSales ?? 0.0,
                  isBold: true,
                ),
                SizedBox(height: Dimensions.height20),
                _buildDetailRow('Sales Today', model?.salesToday ?? 0.0),
                SizedBox(height: Dimensions.height20),
                _buildDetailRow('Receipts', (model?.receipts ?? 0).toDouble()),
                SizedBox(height: Dimensions.height20),
                _buildDetailRow('Refunds', model?.refunds ?? 0.0),
                const Divider(),
                SizedBox(height: Dimensions.height20),
                _buildDetailRow('Discounts', model?.discounts ?? 0.0),
                SizedBox(height: Dimensions.height20),
                _buildDetailRow('Cost of Goods', model?.costOfGoods ?? 0.0),
                const Divider(),
                SizedBox(height: Dimensions.height20),
                _buildDetailRow(
                  'Gross Profit',
                  model?.grossProfit ?? 0.0,
                  isBold: true,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailRow(String label, double value, {bool isBold = false}) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: Dimensions.font16,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            Text(
              '₱${value.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: Dimensions.font16,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      );
}
