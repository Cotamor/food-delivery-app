import 'package:food_deli/pages/cart/cart_page.dart';
import 'package:food_deli/pages/cart/cart_history.dart';
import 'package:food_deli/pages/food/popular_food_detail.dart';
import 'package:food_deli/pages/food/recommended_food_detail.dart';
import 'package:food_deli/pages/home/home_page.dart';
import 'package:food_deli/pages/splash/splash_page.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String splashPage = '/splash-page';
  static const String initial = '/';
  static const String popularFood = '/popular-food';
  static const String recommendedFood = '/recommended-food';
  static const String cartPage = '/cart-page';
  static const String checkoutPage = '/checkout-page';

  static String getSplashPage() => '$splashPage';
  static String getInitial() => '$initial';
  static String getPopularFood(int pageId, String page) => '$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId, String page) => '$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage() => '$cartPage';
  static String getCheckoutPage() => '$checkoutPage';

  static List<GetPage> routes = [
    GetPage(
      name: splashPage,
      page: () => const SplashPage(),
      transition: Transition.zoom,
    ),
    GetPage(name: initial, page: () => const HomePage()),
    GetPage(
      name: popularFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters['page'];
        return PopularFoodDetail(pageId: int.parse(pageId!), page: page!);
      },
      transition: Transition.zoom,
    ),
    GetPage(
      name: recommendedFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters['page'];
        return RecommendedFoodDetail(pageId: int.parse(pageId!), page: page!);
      },
      transition: Transition.zoom,
    ),
    GetPage(
      name: cartPage,
      page: () => const CartPage(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: checkoutPage,
      page: () => const CartHistory(),
      transition: Transition.zoom,
    ),
  ];
}
