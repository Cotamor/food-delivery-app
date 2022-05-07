import 'package:food_deli/Utils/app_constants.dart';
import 'package:food_deli/controllers/cart_controller.dart';
import 'package:food_deli/controllers/popular_product_controller.dart';
import 'package:food_deli/controllers/recommended_product_controller.dart';
import 'package:food_deli/data/api/api_client.dart';
import 'package:food_deli/data/repository/cart_repo.dart';
import 'package:food_deli/data/repository/popular_product_repo.dart';
import 'package:food_deli/data/repository/recommended_product_repo.dart';
import 'package:get/get.dart';

Future<void> init() async {
  // Api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.baseURL));
  // Repos
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo());
  // Controller
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}
