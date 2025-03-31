import 'package:flutter/material.dart';
import 'package:pos_dashboard/core/utils/dimensions.dart';

class CategoriesWidget extends StatelessWidget {
  final String categoryName;
  final double totalSales;

  const CategoriesWidget({
    super.key, 
    required this.categoryName, 
    required this.totalSales, 
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
              // CircleAvatar(
              //   radius: Dimensions.radius15,
              //   backgroundColor: Colors.grey[200],
              //   child: ClipOval(
              //     child: SizedBox(
              //       width: 30,
              //       height: 30,
              //       child: categoryImage,
              //     ),
              //   ),
              // ),
              SizedBox(width: Dimensions.width10),
              Text(
                categoryName,
                style: TextStyle(fontSize: Dimensions.font16),
              ),
            ],
          ),
          Text(
            totalSales.toString(),
            style: TextStyle(fontSize: Dimensions.font16),
          ),
        ],
      ),
    );
  }
}
