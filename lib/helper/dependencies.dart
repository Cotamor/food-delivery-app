import 'package:food_deli/Utils/app_constants.dart';
import 'package:food_deli/controllers/auth_controller.dart';
import 'package:food_deli/controllers/cart_controller.dart';
import 'package:food_deli/controllers/location_controller.dart';
import 'package:food_deli/controllers/popular_product_controller.dart';
import 'package:food_deli/controllers/recommended_product_controller.dart';
import 'package:food_deli/controllers/user_controller.dart';
import 'package:food_deli/data/api/api_client.dart';
import 'package:food_deli/data/repository/auth_repo.dart';
import 'package:food_deli/data/repository/cart_repo.dart';
import 'package:food_deli/data/repository/location_repo.dart';
import 'package:food_deli/data/repository/popular_product_repo.dart';
import 'package:food_deli/data/repository/recommended_product_repo.dart';
import 'package:food_deli/data/repository/user_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  // Api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL, prefs: Get.find()));
  // Repos
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(prefs: Get.find()));
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), prefs: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));
  Get.lazyPut(() => LocationRepo(apiClient: Get.find(), prefs: Get.find()));
  // Controller
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => LocationController(locationRepo: Get.find()));
}
