import 'package:flutter/material.dart';
import 'package:food_deli/Utils/app_constants.dart';
import 'package:food_deli/Utils/colors.dart';
import 'package:food_deli/Utils/dimentions.dart';
import 'package:food_deli/controllers/cart_controller.dart';
import 'package:food_deli/controllers/popular_product_controller.dart';
import 'package:food_deli/models/cart_model.dart';
import 'package:food_deli/routes/route_helper.dart';
import 'package:food_deli/widgets/app_icon.dart';
import 'package:food_deli/widgets/large_text.dart';
import 'package:food_deli/widgets/small_text.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<CartModel> items = Get.find<PopularProductController>().getItems;
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
                    print('go back');
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
          items.isEmpty
              ? Positioned(
                  top: Dimentions.height20 * 5,
                  left: Dimentions.width20,
                  right: Dimentions.width20,
                  bottom: 0,
                  child: Container(
                    color: Colors.green.shade100,
                    child: const Center(
                      child: LargeText(text: 'No Items'),
                    ),
                  ),
                )
              : Positioned(
                  top: Dimentions.height20 * 5,
                  left: Dimentions.width20,
                  right: Dimentions.width20,
                  bottom: 0,
                  child: Container(
                    margin: EdgeInsets.only(top: Dimentions.height15),
                    // color: Colors.red,
                    child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: GetBuilder<CartController>(
                          builder: (controller) {
                            return ListView.builder(
                              itemCount: controller.getItems.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(
                                      bottom: Dimentions.height10),
                                  height: 100,
                                  width: double.maxFinite,
                                  // Item Cards
                                  child: Row(
                                    children: [
                                      // Images
                                      Container(
                                        width: Dimentions.width20 * 5,
                                        height: Dimentions.height20 * 5,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Dimentions.radius20),
                                          color: Colors.white,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  AppConstants.uploadURL +
                                                      controller.getItems[index]
                                                          .img!),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      SizedBox(width: Dimentions.width10),
                                      // Recipe name
                                      Expanded(
                                        child: Container(
                                          color: Colors.white,
                                          height: Dimentions.height20 * 5,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              LargeText(
                                                  text: controller
                                                      .getItems[index].name!),
                                              // Description
                                              const SmallText(
                                                  text: 'spicy',
                                                  color: Colors.black54),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  // Price
                                                  LargeText(
                                                    text:
                                                        '\$${controller.getItems[index].price!}',
                                                    color: Colors.redAccent,
                                                  ),
                                                  // Add or Reduce button
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                Dimentions
                                                                    .width10,
                                                            vertical: Dimentions
                                                                .height10),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              Dimentions
                                                                  .radius20),
                                                      color: Colors.white,
                                                    ),
                                                    // Bottom Nav(+ & - button)
                                                    child: Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            // popularProduct.setQuantity(false);
                                                          },
                                                          child: const Icon(
                                                            Icons.remove,
                                                            color: AppColors
                                                                .signColor,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width: Dimentions
                                                                    .width10 /
                                                                2),
                                                        const LargeText(
                                                            text: '0'),
                                                        SizedBox(
                                                            width: Dimentions
                                                                    .width10 /
                                                                2),
                                                        GestureDetector(
                                                          onTap: () {
                                                            // popularProduct.setQuantity(true);
                                                          },
                                                          child: const Icon(
                                                            Icons.add,
                                                            color: AppColors
                                                                .signColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
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
                ),
        ],
      ),
    );
  }
}
