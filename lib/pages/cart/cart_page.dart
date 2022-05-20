import 'package:flutter/material.dart';
import 'package:food_deli/Utils/app_constants.dart';
import 'package:food_deli/Utils/colors.dart';
import 'package:food_deli/Utils/dimentions.dart';
import 'package:food_deli/base/no_data_page.dart';
import 'package:food_deli/controllers/auth_controller.dart';
import 'package:food_deli/controllers/cart_controller.dart';
import 'package:food_deli/controllers/popular_product_controller.dart';
import 'package:food_deli/controllers/recommended_product_controller.dart';
import 'package:food_deli/routes/route_helper.dart';
import 'package:food_deli/widgets/app_icon.dart';
import 'package:food_deli/widgets/large_text.dart';
import 'package:food_deli/widgets/small_text.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Top Navigation
          Positioned(
            left: Dimentions.width20,
            right: Dimentions.width20,
            top: Dimentions.width20 * 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: AppIcon(
                    icon: Icons.arrow_back_ios,
                    iconColor: Colors.white,
                    bgColor: AppColors.mainColor,
                    iconSize: Dimentions.iconSize24,
                  ),
                ),
                SizedBox(
                  width: Dimentions.width100,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIcon(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    bgColor: AppColors.mainColor,
                    iconSize: Dimentions.iconSize24,
                  ),
                ),
                AppIcon(
                  icon: Icons.shopping_cart_outlined,
                  iconColor: Colors.white,
                  bgColor: AppColors.mainColor,
                  iconSize: Dimentions.iconSize24,
                ),
              ],
            ),
          ),
          // List of Items in the Cart
          GetBuilder<CartController>(
            builder: (_cartController) {
              return _cartController.getItems.isNotEmpty
                  ? Positioned(
                      top: Dimentions.height20 * 5,
                      left: Dimentions.width20,
                      right: Dimentions.width20,
                      bottom: 0,
                      child: Container(
                        margin: EdgeInsets.only(top: Dimentions.height15),
                        child: MediaQuery.removePadding(
                            // Remove default padding from ListView
                            context: context,
                            removeTop: true,
                            child: GetBuilder<CartController>(
                              builder: (controller) {
                                var _cartList = controller.getItems;
                                return ListView.builder(
                                  itemCount: _cartList.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.only(bottom: Dimentions.height10),
                                      height: 100,
                                      width: double.maxFinite,
                                      // Item Content below
                                      child: Row(
                                        children: [
                                          // Food Images
                                          GestureDetector(
                                            onTap: () {
                                              var popularIndex = Get.find<PopularProductController>()
                                                  .popularProductList
                                                  .indexOf(_cartList[index].product);
                                              if (popularIndex >= 0) {
                                                // Navigate to PopularFoodDetailPage
                                                Get.toNamed(RouteHelper.getPopularFood(popularIndex, 'cart-page'));
                                              } else {
                                                var recommendedIndex = Get.find<RecommendedProductController>()
                                                    .recommendedProductList
                                                    .indexOf(_cartList[index].product);
                                                if (recommendedIndex < 0) {
                                                  Get.snackbar(
                                                    'History Product',
                                                    'Product view is not available for history product!',
                                                    backgroundColor: Colors.red.shade300,
                                                    colorText: Colors.white,
                                                  );
                                                } else {
                                                  // Navigate to RecommendedFoodDetailPage
                                                  Get.toNamed(
                                                      RouteHelper.getRecommendedFood(recommendedIndex, 'cart-page'));
                                                }
                                              }
                                            },
                                            child: Container(
                                              width: Dimentions.width20 * 5,
                                              height: Dimentions.height20 * 5,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(Dimentions.radius20),
                                                color: Colors.white,
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        AppConstants.UPLOAD_URL + controller.getItems[index].img!),
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: Dimentions.width10),
                                          // Food name
                                          Expanded(
                                            child: Container(
                                              color: Colors.white,
                                              height: Dimentions.height20 * 5,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  LargeText(text: _cartList[index].name!),
                                                  // Description
                                                  const SmallText(text: 'spicy', color: Colors.black54),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      // Price
                                                      LargeText(
                                                        text: '\$${_cartList[index].price!}',
                                                        color: Colors.redAccent,
                                                      ),
                                                      // Add or Reduce button
                                                      Container(
                                                          padding: EdgeInsets.symmetric(
                                                              horizontal: Dimentions.width10,
                                                              vertical: Dimentions.height10),
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(Dimentions.radius20),
                                                            color: Colors.white,
                                                          ),
                                                          // Bottom Nav(+ & - button)
                                                          child: Row(
                                                            children: [
                                                              GestureDetector(
                                                                onTap: () {
                                                                  controller.addItem(_cartList[index].product!, -1);
                                                                },
                                                                child: const Icon(
                                                                  Icons.remove,
                                                                  color: AppColors.signColor,
                                                                ),
                                                              ),
                                                              SizedBox(width: Dimentions.width10 / 2),
                                                              LargeText(text: _cartList[index].quantity.toString()),
                                                              SizedBox(width: Dimentions.width10 / 2),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  controller.addItem(_cartList[index].product!, 1);
                                                                },
                                                                child: const Icon(
                                                                  Icons.add,
                                                                  color: AppColors.signColor,
                                                                ),
                                                              ),
                                                            ],
                                                          )),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            )),
                      ),
                    )
                  : const NoDataPage(text: 'Your Cart is Empty!');
            },
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(builder: (cartController) {
        return Container(
          height: Dimentions.bottomHeightBar120,
          padding: EdgeInsets.only(
            top: Dimentions.height30,
            bottom: Dimentions.height30,
            left: Dimentions.width20,
            right: Dimentions.width20,
          ),
          decoration: BoxDecoration(
            color: AppColors.buttonBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimentions.radius20),
              topRight: Radius.circular(Dimentions.radius20),
            ),
          ),
          child: cartController.getItems.isEmpty
              ? Container()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: Dimentions.width20, vertical: Dimentions.height20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimentions.radius20),
                        color: Colors.white,
                      ),
                      // Bottom Nav(+ & - button)
                      child: Row(
                        children: [
                          SizedBox(width: Dimentions.width10 / 2),
                          LargeText(text: '\$ ${cartController.getTotalAmount}'),
                          SizedBox(width: Dimentions.width10 / 2),
                        ],
                      ),
                    ),
                    // Bottom Nav(Add to Cart Button)
                    GestureDetector(
                      onTap: () {
                        if (Get.find<AuthController>().userLoggedIn()) {
                          cartController.addToHistoryAndClearCart();
                        } else {
                          Get.toNamed(RouteHelper.getSignInPage());
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: Dimentions.width20, vertical: Dimentions.height20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimentions.radius20),
                          color: AppColors.mainColor,
                        ),
                        child: const LargeText(
                          text: 'Check Out',
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
