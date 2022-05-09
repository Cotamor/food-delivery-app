import 'package:flutter/material.dart';
import 'package:food_deli/Utils/colors.dart';
import 'package:food_deli/controllers/cart_controller.dart';
import 'package:food_deli/controllers/popular_product_controller.dart';
import 'package:food_deli/controllers/recommended_product_controller.dart';
import 'package:food_deli/pages/cart/cart_page.dart';
import 'package:food_deli/pages/home/main_food_page.dart';
import 'package:food_deli/routes/route_helper.dart';
import 'package:get/get.dart';
import 'helper/dependencies.dart' as dep;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList();
    Get.find<CartController>();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demo',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      // home: CartPage(),
      home: const MainPage(),
      initialRoute: RouteHelper.getInitial(),
      getPages: RouteHelper.routes,
      // home: const RecommendedFoodDetail(),
      // home: const PopularFoodDetail(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  List pages = [
    const MainFoodPage(),
    const MainFoodPage(),
    const CartPage(),
    const MainFoodPage(),
  ];
  @override
  Widget build(BuildContext context) {
    double screenHeight = Get.height;
    double screenWidth = Get.width;
    print('height: $screenHeight.');
    print('width: $screenWidth.');
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.mainColor,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.black54,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
