class AppConstants {
  static const String appName = 'DBFood';
  static const int appVersion = 1;

  // static const String baseURL = 'http://mvs.bslmeiyu.com';
  // static const String baseURL = 'http://127.0.0.1:8000';
  static const String baseURL = 'http://10.0.2.2:8000';
  static const String popularProductURI = '/api/v1/products/popular';
  static const String recommendedProductURI = '/api/v1/products/recommended';
  // static const String drinksURI = '/api/v1/products/drinks';
  static const String uploadURL = '$baseURL/uploads/';

  static const String token = 'DBtoken';

  // SharedPreferences key
  static const String cartList = 'Cart-List';
  static const String cartHistoryList = 'Cart-History-List';
}
