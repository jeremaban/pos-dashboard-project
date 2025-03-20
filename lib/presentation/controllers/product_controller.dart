import 'package:pos_dashboard/data/repositories/product_repo.dart';
import 'package:pos_dashboard/data/models/products_model.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class PopularProductController extends GetxController{
  final PopularProductRepo popularProductRepo;

  PopularProductController({
    required this.popularProductRepo
    });

  //in dart, underscore means private variable
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;

  Future<void> getPopularProductList() async{
    dio.Response response = await popularProductRepo.getPopularProductList();

    if(response.statusCode == 200){ //200 means success
      print("got data");
      _popularProductList = []; //initialize to null to prevent repetition of data
      _popularProductList.addAll(Product.fromJson(response.data).products); //add all data to the list
      //print(_popularProductList);
      update(); //setState in a sense that the ui will be updated based on data
    } else {

    }
  }
}