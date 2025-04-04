import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:pos_dashboard/data/models/top_dashboard_model.dart';
import 'package:pos_dashboard/data/repositories/top_dashboard_repo.dart';

class TopDashboardController extends GetxController {
  final TopDashboardRepo topDashboardRepo;

  TopDashboardController({required this.topDashboardRepo});

  List<Top5Categories> _top5CategoriesList = [];
  List<Top5Categories> get top5CategoriesList => _top5CategoriesList;

  List<Top5Employees> _top5EmployeesList = [];
  List<Top5Employees> get top5EmployeesList => _top5EmployeesList;

  List<Top5Items> _top5ItemsList = [];
  List<Top5Items> get top5ItemsList => _top5ItemsList;

  Future<void> getTopList() async {
    try {
      dio.Response response = await topDashboardRepo.getTopList();

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Got data. Source: top_dashboard_controller.dart");
        TopDashboardModel topDashboardModel = TopDashboardModel.fromJson(response.data);

        _top5CategoriesList = topDashboardModel.top5Categories;
        _top5EmployeesList = topDashboardModel.top5Employees;
        _top5ItemsList = topDashboardModel.top5Items;
        
        update();

        print("Number of top 5 categories loaded: ${_top5CategoriesList.length}");
        print("Number of top 5 employees loaded: ${_top5EmployeesList.length}");
        print("Number of top 5 items loaded: ${_top5ItemsList.length}");

        if (_top5CategoriesList.isNotEmpty) {
          print("Sample top category: ${_top5CategoriesList.first}");
        }

        if (_top5EmployeesList.isNotEmpty) {
          print("Sample top employee: ${_top5EmployeesList.first}");
        }

        if (_top5ItemsList.isNotEmpty) {
          print("Sample top item: ${_top5ItemsList.first}");
        }
      } else {
        print("No data. Source: top_dashboard_controller.dart, status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching top list: $e");
    }
  }
}