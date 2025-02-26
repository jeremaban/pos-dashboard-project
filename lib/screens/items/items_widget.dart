import 'package:flutter/material.dart';
import 'package:pos_dashboard/utilities/dimensions.dart';

class ItemsWidget extends StatelessWidget {
  final String itemName;
  final double netSales;
  final Image itemImage;

  const ItemsWidget({
    super.key, 
    required this.itemName, 
    required this.netSales, 
    required this.itemImage
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
                radius: Dimensions.radius15,
                backgroundImage: itemImage.image,
              ),
              SizedBox(width: Dimensions.width10),
              Text(
                itemName,
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