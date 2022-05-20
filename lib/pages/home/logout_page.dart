import 'package:flutter/material.dart';
import 'package:food_deli/base/show_custom_snackbar.dart';
import 'package:food_deli/controllers/auth_controller.dart';
import 'package:food_deli/controllers/cart_controller.dart';
import 'package:food_deli/routes/route_helper.dart';
import 'package:food_deli/widgets/account_widget.dart';
import 'package:get/get.dart';

class LogoutPage extends StatelessWidget {
  const LogoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          if (Get.find<AuthController>().userLoggedIn()) {
            Get.find<AuthController>().clearShearedData();
            Get.find<CartController>().clear();
            Get.find<CartController>().clearCartHistory();
            // Get.toNamed(RouteHelper.getSignInPage());
          } else {
            //
            showCustomSnackBar('You logged out', color: Colors.green, title: 'Log Out');
          }
        },
        child: const AccountWidget(
          iconBgColor: Colors.red,
          icon: Icons.logout,
          text: 'Log Out',
        ),
      ),
    );
  }
}
