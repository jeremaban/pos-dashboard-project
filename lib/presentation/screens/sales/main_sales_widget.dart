import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pos_dashboard/core/utils/dimensions.dart';

class MainSalesWidget extends StatelessWidget {
  final String itemName;
  final double quantity;
  final Widget? itemImage;

  const MainSalesWidget({
    super.key,
    required this.itemName,
    required this.quantity,
    this.itemImage
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Dimensions.height12,
        horizontal: Dimensions.width16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (itemImage != null)
              CircleAvatar(
                radius: Dimensions.radius15,
                backgroundColor: Colors.grey[200],
                child: ClipOval(
                  child: SizedBox(
                    width: Dimensions.width30, 
                    height: Dimensions.height30, 
                    child: itemImage
                  ),
                ),
              ),
              if (itemImage != null)
              SizedBox(width: Dimensions.width10),
              Text(itemName, style: TextStyle(fontSize: Dimensions.font16))
            ]
          ),
          Text(
            quantity.toString(), 
            style: TextStyle(fontSize: Dimensions.font16)
          ),
        ]
      )
    );
  }
}
