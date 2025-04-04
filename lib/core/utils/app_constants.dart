class AppConstants {
  static const String APP_NAME = 'ShoppazingDashboard';
  static const int APP_VERSION = 1;

  static const String BASE_URL = "http://test.shoppazing.com/api";
  static const String PRODUCT_URI = "/shop/getstoreitemsbystoreidByPage";
  static const String TOP5_PRODUCT = "/shop/getMerchantDashboardData";
  static const String RECOMMENDED_PRODUCT_URI = "/api/v1/products/popular/recommended";
  static const String UPLOAD_URL = "/uploads/";

  static const String TOKEN_URL = "$BASE_URL/token";
  static String getTokenUrl() {
    return Uri.parse("$BASE_URL/token").toString();
  }

}


