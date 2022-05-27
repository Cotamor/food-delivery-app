import 'package:flutter/material.dart';
import 'package:food_deli/Utils/app_constants.dart';
import 'package:food_deli/Utils/colors.dart';
import 'package:food_deli/Utils/dimensions.dart';
import 'package:food_deli/base/no_data_page.dart';
import 'package:food_deli/base/show_custom_snackbar.dart';
import 'package:food_deli/controllers/auth_controller.dart';
import 'package:food_deli/controllers/cart_controller.dart';
import 'package:food_deli/controllers/location_controller.dart';
import 'package:food_deli/controllers/order_controller.dart';
import 'package:food_deli/controllers/popular_product_controller.dart';
import 'package:food_deli/controllers/recommended_product_controller.dart';
import 'package:food_deli/controllers/user_controller.dart';
import 'package:food_deli/models/place_order_model.dart';
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
            left: Dimensions.width20,
            right: Dimensions.width20,
            top: Dimensions.width20 * 3,
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
                    iconSize: Dimensions.iconSize24,
                  ),
                ),
                SizedBox(
                  width: Dimensions.width100,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIcon(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    bgColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                ),
                AppIcon(
                  icon: Icons.shopping_cart_outlined,
                  iconColor: Colors.white,
                  bgColor: AppColors.mainColor,
                  iconSize: Dimensions.iconSize24,
                ),
              ],
            ),
          ),
          // List of Items in the Cart
          GetBuilder<CartController>(
            builder: (_cartController) {
              return _cartController.getItems.isNotEmpty
                  ? Positioned(
                      top: Dimensions.height20 * 5,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      bottom: 0,
                      child: Container(
                        margin: EdgeInsets.only(top: Dimensions.height15),
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
                                      margin: EdgeInsets.only(bottom: Dimensions.height10),
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
                                              width: Dimensions.width20 * 5,
                                              height: Dimensions.height20 * 5,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(Dimensions.radius20),
                                                color: Colors.white,
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        AppConstants.UPLOAD_URL + controller.getItems[index].img!),
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: Dimensions.width10),
                                          // Food name
                                          Expanded(
                                            child: Container(
                                              color: Colors.white,
                                              height: Dimensions.height20 * 5,
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
                                                              horizontal: Dimensions.width10,
                                                              vertical: Dimensions.height10),
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(Dimensions.radius20),
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
                                                              SizedBox(width: Dimensions.width10 / 2),
                                                              LargeText(text: _cartList[index].quantity.toString()),
                                                              SizedBox(width: Dimensions.width10 / 2),
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
          height: Dimensions.bottomHeightBar120,
          padding: EdgeInsets.only(
            top: Dimensions.height30,
            bottom: Dimensions.height30,
            left: Dimensions.width20,
            right: Dimensions.width20,
          ),
          decoration: BoxDecoration(
            color: AppColors.buttonBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radius20),
              topRight: Radius.circular(Dimensions.radius20),
            ),
          ),
          child: cartController.getItems.isEmpty
              ? Container()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.width20, vertical: Dimensions.height20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color: Colors.white,
                      ),
                      // Bottom Nav(+ & - button)
                      child: Row(
                        children: [
                          SizedBox(width: Dimensions.width10 / 2),
                          LargeText(text: '\$ ${cartController.getTotalAmount}'),
                          SizedBox(width: Dimensions.width10 / 2),
                        ],
                      ),
                    ),
                    // Bottom Nav(Add to Cart Button)
                    GestureDetector(
                      onTap: () {
                        if (Get.find<AuthController>().userLoggedIn()) {
                          if (Get.find<LocationController>().addressList.isEmpty) {
                            Get.toNamed(RouteHelper.getAddAddressPage());
                          } else {
                            var location = Get.find<LocationController>().getUserAddress();
                            var cart = Get.find<CartController>().getItems;
                            var user = Get.find<UserController>().userModel;
                            PlaceOrderBody placeOrder = PlaceOrderBody(
                              cart: cart,
                              orderAmount: 100.0,
                              distance: 10.0,
                              scheduleAt: '',
                              orderNote: 'Note abount the food',
                              address: location.address,
                              latitude: location.latitude,
                              longitude: location.longitude,
                              contactPersonName: user!.name,
                              contactPersonNumber: user.phone,
                            );
                            Get.find<OrderController>().placeOrder(placeOrder, _callBack);
                          }
                        } else {
                          Get.toNamed(RouteHelper.getSignInPage());
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.width20, vertical: Dimensions.height20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
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

  void _callBack(bool isSuccess, String message, String orderID) {
    if (isSuccess) {
      Get.offNamed(RouteHelper.getPaymentPage(orderID, Get.find<UserController>().userModel!.id));
    } else {
      showCustomSnackBar(message);
    }
  }
}
