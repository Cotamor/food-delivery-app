import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_deli/Utils/app_constants.dart';
import 'package:food_deli/Utils/colors.dart';
import 'package:food_deli/Utils/dimentions.dart';
import 'package:food_deli/base/no_data_page.dart';
import 'package:food_deli/controllers/cart_controller.dart';
import 'package:food_deli/controllers/popular_product_controller.dart';
import 'package:food_deli/models/cart_model.dart';
import 'package:food_deli/routes/route_helper.dart';
import 'package:food_deli/widgets/app_icon.dart';
import 'package:food_deli/widgets/large_text.dart';
import 'package:food_deli/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cartHistoryList = Get.find<CartController>().getCartHistoryList().reversed.toList();

    Map<String, int> dateAndNumItemsPerOrder = <String, int>{};

    for (int i = 0; i < cartHistoryList.length; i++) {
      if (dateAndNumItemsPerOrder.containsKey(cartHistoryList[i].time)) {
        dateAndNumItemsPerOrder.update(cartHistoryList[i].time!, (value) => ++value);
      } else {
        dateAndNumItemsPerOrder.putIfAbsent(cartHistoryList[i].time!, () => 1);
      }
    }
    // print(cartHistoryList);
    // print('timeAndNumItemsPerOrder: $timeAndNumItemsPerOrder');

    List<int> orderNumItemsToList() {
      return dateAndNumItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> orderDateToList() {
      return dateAndNumItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> orderTimesList = orderNumItemsToList(); // 3, 2, 3
    // List<String> orderDate = orderDateList();
    // print(orderTimesList);
    var listCounter = 0;

    Widget timeWidget(int index) {
      var outputDate = DateTime.now().toString();
      if (index < cartHistoryList.length) {
        DateTime parseDate = DateFormat('yyyy-MM-dd HH:mm:ss').parse(cartHistoryList[index].time!);
        // var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
        outputDate = outputFormat.format(parseDate);
      }
      return LargeText(text: outputDate);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Top title bar and Navigation
          Container(
            height: Dimentions.height100,
            color: AppColors.mainColor,
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
          Get.find<CartController>().getCartHistoryList().isEmpty
              ? const Expanded(
                  child: NoDataPage(
                    text: 'You did not buy anything so far.',
                    imgPath: 'assets/image/empty_box.png',
                  ),
                )
              : Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      top: Dimentions.height20,
                      right: Dimentions.width20,
                      left: Dimentions.width20,
                    ),
                    // color: Colors.red.shade100,
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView(
                        children: [
                          for (var i = 0; i < dateAndNumItemsPerOrder.length; i++)
                            Container(
                              // color: Colors.blue.shade100,
                              height: Dimentions.height30 * 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  timeWidget(listCounter),
                                  // LargeText(text: cartHistoryList[listCounter].time!),
                                  SizedBox(height: Dimentions.height10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Wrap(
                                        direction: Axis.horizontal,
                                        children: List.generate(orderTimesList[i], (index) {
                                          if (listCounter < cartHistoryList.length) {
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
                                                          AppConstants.uploadURL +
                                                              cartHistoryList[listCounter - 1].img!,
                                                        ),
                                                        fit: BoxFit.cover),
                                                  ),
                                                )
                                              : Container();
                                        }),
                                      ),
                                      SizedBox(
                                        // color: Colors.green.shade100,
                                        height: Dimentions.height40 * 2,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            const SmallText(text: 'Total'),
                                            LargeText(
                                                text: orderTimesList[i].toString() + ' items',
                                                color: AppColors.titleColor),
                                            GestureDetector(
                                              onTap: () {
                                                var orderDate = orderDateToList();
                                                Map<int, CartModel> moreOrder = {};

                                                for (var j = 0; j < cartHistoryList.length; j++) {
                                                  if (cartHistoryList[j].time == orderDate[i]) {
                                                    moreOrder.putIfAbsent(
                                                      cartHistoryList[j].id!,
                                                      () => cartHistoryList[j],
                                                      // CartModel.fromJson(jsonDecode(jsonEncode(cartHistoryList[j]))),
                                                    );
                                                    // print('Simple: ${jsonEncode(cartHistoryList[j])})');
                                                    // print(
                                                    //     'Complex: ${jsonEncode(CartModel.fromJson(jsonDecode(jsonEncode(cartHistoryList[j]))))}');
                                                  }
                                                }
                                                Get.find<CartController>().setItems = moreOrder;
                                                Get.find<CartController>().addToCartList();
                                                Get.toNamed(RouteHelper.getCartPage());
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: Dimentions.height10 / 2, horizontal: Dimentions.width10),
                                                decoration: BoxDecoration(
                                                  border: Border.all(width: 1, color: AppColors.mainColor),
                                                  borderRadius: BorderRadius.circular(Dimentions.radius15 / 3),
                                                ),
                                                child: const SmallText(text: 'one more', color: AppColors.mainColor),
                                              ),
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
