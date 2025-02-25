import 'package:get/get.dart';

class Dimensions { 

  static double screenHeight = Get.context!.height; //778.4000244140625
  static double screenWidth = Get.context!.width; //500

  //height
  static double height10 = screenHeight / 75.44000244140625;
  static double height15 = screenHeight / 51.893335978190104;
  static double height20 = screenHeight / 38.920001220703125;
  static double height700 = screenHeight / 1.112571463759512;

  //width
  static double width10 = screenWidth / 50;
  static double width15 = screenWidth / 33.333333333333336;
  static double width20 = screenWidth / 25;

  //radius
  static double radius20 = screenHeight / 38.920001220703125;

  //listview image
  static double listViewImgSize = screenWidth / 7.784000244140625;
  static double listViewTextContainerSize = screenWidth / 5;

}