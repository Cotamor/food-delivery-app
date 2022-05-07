import 'package:flutter/material.dart';
import 'package:food_deli/Utils/app_constants.dart';
import 'package:food_deli/Utils/colors.dart';
import 'package:food_deli/Utils/dimentions.dart';
import 'package:food_deli/Utils/dummy_text.dart';
import 'package:food_deli/controllers/cart_controller.dart';
import 'package:food_deli/controllers/popular_product_controller.dart';
import 'package:food_deli/models/products_model.dart';
import 'package:food_deli/pages/home/main_food_page.dart';
import 'package:food_deli/routes/route_helper.dart';
import 'package:food_deli/widgets/app_column.dart';
import 'package:food_deli/widgets/app_icon.dart';
import 'package:food_deli/widgets/expandable_text_widget.dart';
import 'package:food_deli/widgets/large_text.dart';
import 'package:get/get.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  const PopularFoodDetail({
    Key? key,
    required this.pageId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductModel product =
        Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(Get.find<CartController>());

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimentions.popularFoodImgSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(AppConstants.uploadURL + product.img!),
                  // image: AssetImage('assets/image/food0.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Navigations Top
          Positioned(
            left: Dimentions.width20,
            right: Dimentions.width20,
            top: Dimentions.height45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: const AppIcon(icon: Icons.arrow_back_ios),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const AppIcon(icon: Icons.shopping_cart),
                ),
              ],
            ),
          ),
          // Title Section
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimentions.popularFoodImgSize - 20,
            child: Container(
              padding: EdgeInsets.only(
                left: Dimentions.width20,
                right: Dimentions.width20,
                top: Dimentions.height20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimentions.radius20),
                  topRight: Radius.circular(Dimentions.radius20),
                ),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColumn(title: product.name!),
                  SizedBox(height: Dimentions.height20),
                  const LargeText(text: 'Introduce'),
                  SizedBox(height: Dimentions.height20),
                  // Description Section(ExpandableTextWidget)
                  Expanded(
                    child: SingleChildScrollView(
                      child: ExpandableTextWidget(text: product.description!),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          GetBuilder<PopularProductController>(builder: (popularProduct) {
        return Container(
          height: Dimentions.bottomHeightBar120,
          padding: EdgeInsets.only(
            top: Dimentions.height30,
            bottom: Dimentions.height30,
            left: Dimentions.width20,
            right: Dimentions.width20,
          ),
          decoration: BoxDecoration(
            color: Colors.pink.shade100,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimentions.radius20),
              topRight: Radius.circular(Dimentions.radius20),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimentions.width20,
                    vertical: Dimentions.height20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimentions.radius20),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        popularProduct.setQuantity(false);
                      },
                      child: const Icon(
                        Icons.remove,
                        color: AppColors.signColor,
                      ),
                    ),
                    SizedBox(width: Dimentions.width10 / 2),
                    LargeText(text: popularProduct.quantity.toString()),
                    SizedBox(width: Dimentions.width10 / 2),
                    GestureDetector(
                      onTap: () {
                        popularProduct.setQuantity(true);
                      },
                      child: const Icon(
                        Icons.add,
                        color: AppColors.signColor,
                      ),
                    ),
                  ],
                ),
              ),
              // Bottom Nav(Add to Cart Button)
              GestureDetector(
                onTap: () {
                  popularProduct.addItem(product);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimentions.width20,
                      vertical: Dimentions.height20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimentions.radius20),
                    color: AppColors.mainColor,
                  ),
                  child: LargeText(
                    text: '\$${product.price} | Add to cart',
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
