// ignore_for_file: constant_identifier_names

class AppConstants {
  static const String APP_NAME = 'DBFood';
  static const int APP_VERSION = 1;

  // static const String baseURL = 'http://mvs.bslmeiyu.com';
  // static const String baseURL = 'http://127.0.0.1:8000';
  static const String BASE_URL = 'http://10.0.2.2:8000';
  static const String POPULAR_PRODUCT_URI = '/api/v1/products/popular';
  static const String RECOMMENDED_PRODUCE_URI = '/api/v1/products/recommended';
  static const String UPLOAD_URL = '$BASE_URL/uploads/';
  // auth end point
  static const String REGISTRATION_URI = '/api/v1/auth/register';
  static const String LOGIN_URI = '/api/v1/auth/login';
  static const String USER_INFO_URI = '/api/v1/customer/info';

  static const String TOKEN = '';
  static const String EMAIL = '';
  static const String PASSWORD = '';

  // SharedPreferences key
  static const String CART_LIST = 'Cart-List';
  static const String CART_HISTORY_LIST = 'Cart-History-List';
}
