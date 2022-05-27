import 'package:flutter/material.dart';
import 'package:food_deli/Utils/colors.dart';
import 'package:food_deli/Utils/dimensions.dart';
import 'package:food_deli/controllers/popular_product_controller.dart';
import 'package:food_deli/controllers/recommended_product_controller.dart';
import 'package:food_deli/pages/home/food_page_body.dart';
import 'package:food_deli/widgets/large_text.dart';
import 'package:food_deli/widgets/small_text.dart';
import 'package:get/get.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  Future<void> _loadResources() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: Column(
          children: [
            // Header Section
            Container(
              // Scrolling Feature implement tbd
              color: Colors.grey.shade200,
              margin: EdgeInsets.only(top: Dimensions.height45, bottom: Dimensions.height15),
              padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      const LargeText(
                        text: 'Japan',
                        color: AppColors.mainColor,
                      ),
                      Row(
                        children: const [
                          SmallText(text: 'Yokohama'),
                          Icon(
                            Icons.arrow_drop_down_rounded,
                            color: AppColors.mainBlackColor,
                          )
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: Dimensions.height45,
                    height: Dimensions.height45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      color: AppColors.mainColor,
                    ),
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: Dimensions.iconSize24,
                    ),
                  )
                ],
              ),
            ),
            // FoodPageBody
            const Expanded(
              child: SingleChildScrollView(
                child: FoodPageBody(),
              ),
            ),
          ],
        ),
        onRefresh: _loadResources);
  }
}
