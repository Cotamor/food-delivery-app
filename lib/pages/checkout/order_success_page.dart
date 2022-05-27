import 'package:flutter/material.dart';
import 'package:food_deli/Utils/dimensions.dart';
import 'package:food_deli/base/custom_button.dart';
import 'package:food_deli/routes/route_helper.dart';
import 'package:get/get.dart';

class OrderSuccessPage extends StatelessWidget {
  final String orderId;
  final int status;
  const OrderSuccessPage({
    Key? key,
    required this.orderId,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (status == 0) {
      Future.delayed(const Duration(seconds: 1), () {
        // Get.dialog(PaymentFailedDialog(orderID: orderID), barrierDismissible: false);
      });
    }
    return Scaffold(
      body: Center(
          child: SizedBox(
              width: Dimensions.screenWidth,
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset(status == 1 ? "assets/image/checked.png" : "assets/image/warning.png",
                    width: 100, height: 100),
                SizedBox(height: Dimensions.height45),
                Text(
                  status == 1 ? 'You placed the order successfully' : 'Your order failed',
                  style: TextStyle(fontSize: Dimensions.font26),
                ),
                SizedBox(height: Dimensions.height20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.height20, vertical: Dimensions.height10),
                  child: Text(
                    status == 1 ? 'Successful order' : 'Failed order',
                    style: TextStyle(fontSize: Dimensions.font20, color: Theme.of(context).disabledColor),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: Dimensions.height15),
                Padding(
                  padding: EdgeInsets.all(Dimensions.width20),
                  child: CustomButton(
                      buttonText: 'Back to Home', onPressed: () => Get.offAllNamed(RouteHelper.getInitial())),
                ),
              ]))),
    );
  }
}
