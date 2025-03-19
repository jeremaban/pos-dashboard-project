import 'package:flutter/material.dart';
import 'package:pos_dashboard/core/utils/dimensions.dart';
import 'categories_widget.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"name": "Item 1", "sales": 32.3, "color": Colors.red},
      {"name": "Item 2", "sales": 54.4, "color": Colors.brown},
      {"name": "Item 3", "sales": 23.22, "color": Colors.green},
    ];

    return Container(
      padding: EdgeInsets.all(Dimensions.width16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'CATEGORIES',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Dimensions.font18,
                color: Color(0xFF00308F), // Air Force Blue
              ),
            ),
          ),
          SizedBox(height: Dimensions.height10),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: categories.length,
            separatorBuilder: (context, index) => Divider(
              color: Colors.grey.shade300,
              thickness: 1,
            ),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: Dimensions.height8),
                child: CategoriesWidget(
                  categoryName: categories[index]['name'],
                  netSales: categories[index]['sales'],
                  circleColor: categories[index]['color'],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
