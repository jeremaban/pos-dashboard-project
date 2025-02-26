import 'package:flutter/material.dart';
import 'package:pos_dashboard/utilities/dimensions.dart';

class EmployeeWidget extends StatelessWidget {
  final String employeeName;
  final double netSales;
  final Color circleColor;

  const EmployeeWidget({
    super.key,
    required this.employeeName,
    required this.netSales,
    required this.circleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding( // Use Padding for spacing and background
      padding: EdgeInsets.symmetric(vertical: Dimensions.height12, horizontal: Dimensions.width16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: circleColor,
                radius: Dimensions.radius15,
              ),
              SizedBox(width: Dimensions.width10),
              Text(
                employeeName,
                style: TextStyle(fontSize: Dimensions.font16),
              ),
            ],
          ),
          Text(
            netSales.toStringAsFixed(2),
            style: TextStyle(fontSize: Dimensions.font16),
          ),
        ],
      ),
    );
  }
}