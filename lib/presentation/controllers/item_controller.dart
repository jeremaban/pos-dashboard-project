import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:pos_dashboard/data/models/items_model.dart';
import 'package:pos_dashboard/data/repositories/item_repo.dart';

class ItemController extends GetxController {
  final ItemRepo itemRepo;

  ItemController({
    required this.itemRepo
  });

  List<dynamic> _itemList = [];
  List<dynamic> get itemList => _itemList;

  Future<void> getItemList() async {
    dio.Response response = await itemRepo.getItemList();

    if(response.statusCode == 200 || response.statusCode == 201){
      print("Got data. Source: item_controller.dart");
      _itemList = [];
      _itemList.addAll(ItemModel.fromJson(response.data).items);
      update();
    } else {
      print("No data. Source: item_controller.dart");
    }
  }
}