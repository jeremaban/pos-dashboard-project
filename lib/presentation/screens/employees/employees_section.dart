import 'package:flutter/material.dart';
import 'package:pos_dashboard/core/utils/dimensions.dart';
import 'employees_widget.dart';

class EmployeesSection extends StatelessWidget {
  const EmployeesSection({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> employees = [
      {"name": "Owner", "sales": 2268.50, "color": Colors.red},
      {"name": "John", "sales": 1617.70, "color": Colors.brown},
      {"name": "Jane", "sales": 2560.60, "color": Colors.green},
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
              'EMPLOYEES',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Dimensions.font18,
                color: Color(0xFF00308F),
              ),
            ),
          ),
          SizedBox(height: Dimensions.height10),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: employees.length,
            separatorBuilder: (context, index) => Divider(
              color: Colors.grey.shade300,
              thickness: 1,
            ),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: Dimensions.height8),
                child: EmployeeWidget(
                  employeeName: employees[index]['name'],
                  netSales: employees[index]['sales'],
                  circleColor: employees[index]['color'],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}