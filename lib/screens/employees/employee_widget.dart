import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: circleColor,
                radius: 15,
              ),
              const SizedBox(width: 10),
              Text(
                employeeName,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          Text(
            netSales.toStringAsFixed(2),
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}