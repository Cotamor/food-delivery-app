import 'package:food_deli/main.dart';
import 'package:food_deli/pages/food/popular_food_detail.dart';
import 'package:food_deli/pages/food/recommended_food_detail.dart';
import 'package:food_deli/pages/home/main_food_page.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String initial = '/';
  static const String popularFood = '/popular-food';
  static const String recommendedFood = '/recommended-food';

  static String getInitial() => '$initial';
  static String getPopularFood(int pageId) => '$popularFood?pageId=$pageId';
  static String getRecommendedFood(int pageId) =>
      '$recommendedFood?pageId=$pageId';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => const MainFoodPage()),
    GetPage(
      name: popularFood,
      page: () {
        final pageId = Get.parameters['pageId'];
        return PopularFoodDetail(pageId: int.parse(pageId!));
      },
      transition: Transition.zoom,
    ),
    GetPage(
      name: recommendedFood,
      page: () {
        final pageId = Get.parameters['pageId'];
        return RecommendedFoodDetail(pageId: int.parse(pageId!));
      },
      transition: Transition.zoom,
    ),
  ];
}
