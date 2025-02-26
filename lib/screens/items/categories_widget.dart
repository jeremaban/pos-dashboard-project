import 'package:flutter/material.dart';
import 'package:pos_dashboard/utilities/dimensions.dart';

class CategoriesWidget extends StatelessWidget {
  final String categoryName;
  final double netSales;
  final Color circleColor;

  const CategoriesWidget({
    super.key, 
    required this.netSales, 
    required this.categoryName, 
    required this.circleColor
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                categoryName,
                style: TextStyle(fontSize: Dimensions.font16),
              ),
            ],
          ),
          Text(
            netSales.toStringAsFixed(2),
            style: TextStyle(fontSize: Dimensions.font16),
          ),
        ],
      )
    );
  }
}