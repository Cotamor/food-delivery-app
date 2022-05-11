import 'package:flutter/material.dart';
import 'package:food_deli/Utils/app_constants.dart';
import 'package:food_deli/Utils/colors.dart';
import 'package:food_deli/Utils/dimentions.dart';
import 'package:food_deli/controllers/cart_controller.dart';
import 'package:food_deli/widgets/app_icon.dart';
import 'package:food_deli/widgets/large_text.dart';
import 'package:food_deli/widgets/small_text.dart';
import 'package:get/get.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList = Get.find<CartController>().getCartHistoryList();
    Map<String, int> cartItemsPerOrder = <String, int>{};

    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<int> itemsPerOrder = cartOrderTimeToList(); // 3, 2, 3
    var listCounter = 0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Top title bar and Navigation
          Container(
            color: AppColors.mainColor,
            height: Dimentions.height100,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: Dimentions.height45, right: Dimentions.width20, left: Dimentions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                LargeText(
                  text: 'Cart History',
                  color: Colors.white,
                ),
                AppIcon(
                  icon: Icons.shopping_cart_outlined,
                  iconColor: AppColors.mainColor,
                ),
              ],
            ),
          ),
          // Main Content(Cart History)
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                top: Dimentions.height20,
                right: Dimentions.width20,
                left: Dimentions.width20,
              ),
              color: Colors.red.shade100,
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView(
                  children: [
                    for (var i = 0; i < itemsPerOrder.length; i++)
                      Container(
                        color: Colors.blue.shade100,
                        height: 120,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const LargeText(text: '05/02/2022'),
                            SizedBox(height: Dimentions.height10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Wrap(
                                  direction: Axis.horizontal,
                                  children: List.generate(itemsPerOrder[i], (index) {
                                    if (listCounter < getCartHistoryList.length) {
                                      listCounter++;
                                    }
                                    return index <= 2
                                        ? Container(
                                            width: Dimentions.width20 * 4,
                                            height: Dimentions.height20 * 4,
                                            margin: EdgeInsets.only(right: Dimentions.width10),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(Dimentions.radius15),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                    AppConstants.uploadURL + getCartHistoryList[listCounter - 1].img!,
                                                  ),
                                                  fit: BoxFit.cover),
                                            ),
                                          )
                                        : Container();
                                  }),
                                ),
                                Container(
                                  color: Colors.green.shade100,
                                  height: 80,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const SmallText(text: 'Total'),
                                      LargeText(
                                          text: itemsPerOrder[i].toString() + ' items', color: AppColors.titleColor),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: Dimentions.height10 / 2, horizontal: Dimentions.width10),
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 1, color: AppColors.mainColor),
                                          borderRadius: BorderRadius.circular(Dimentions.radius15 / 3),
                                        ),
                                        child: const SmallText(text: 'one more', color: AppColors.mainColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        margin: EdgeInsets.only(bottom: Dimentions.height20),
                      )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
