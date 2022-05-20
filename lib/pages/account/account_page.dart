import 'package:flutter/material.dart';
import 'package:food_deli/Utils/colors.dart';
import 'package:food_deli/Utils/dimentions.dart';
import 'package:food_deli/base/show_custom_snackbar.dart';
import 'package:food_deli/controllers/auth_controller.dart';
import 'package:food_deli/controllers/cart_controller.dart';
import 'package:food_deli/controllers/user_controller.dart';
import 'package:food_deli/routes/route_helper.dart';
import 'package:food_deli/widgets/account_widget.dart';
import 'package:food_deli/widgets/app_icon.dart';
import 'package:food_deli/widgets/large_text.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      print('user has logged in');
      Get.find<UserController>().getUserInfo();
    }
    return Scaffold(
      appBar: AppBar(
        title: const LargeText(
          text: 'Profile',
          size: 24,
          color: Colors.white,
        ),
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
      ),
      body: !_userLoggedIn
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: Dimentions.height20 * 10,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/image/signintocontinue.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getSignInPage());
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: Dimentions.height15),
                    width: Dimentions.screenWidth / 2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimentions.radius20),
                      color: AppColors.mainColor,
                    ),
                    child: Center(
                      child: LargeText(
                        text: 'Sign In',
                        color: Colors.white,
                        size: Dimentions.font26,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : GetBuilder<UserController>(
              builder: (userController) {
                return !userController.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        margin: EdgeInsets.only(top: Dimentions.height20),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Profile icon
                            AppIcon(
                              icon: Icons.person,
                              bgColor: AppColors.mainColor,
                              iconColor: Colors.white,
                              size: Dimentions.height15 * 10,
                              iconSize: Dimentions.height45 + Dimentions.height30,
                            ),
                            SizedBox(height: Dimentions.height20),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    // Name
                                    AccountWidget(
                                      iconBgColor: AppColors.mainColor,
                                      icon: Icons.person,
                                      text: userController.userModel.name,
                                    ),
                                    SizedBox(height: Dimentions.height20),
                                    // Phone
                                    AccountWidget(
                                      iconBgColor: AppColors.yellowColor,
                                      icon: Icons.phone,
                                      text: userController.userModel.phone,
                                    ),
                                    SizedBox(height: Dimentions.height20),
                                    // Email
                                    AccountWidget(
                                      iconBgColor: AppColors.yellowColor,
                                      icon: Icons.email,
                                      text: userController.userModel.email,
                                    ),
                                    SizedBox(height: Dimentions.height20),
                                    // Address
                                    const AccountWidget(
                                      iconBgColor: AppColors.yellowColor,
                                      icon: Icons.location_on,
                                      text: 'Chiyoda Tokyo Japan',
                                    ),
                                    SizedBox(height: Dimentions.height20),
                                    // Messages
                                    const AccountWidget(
                                      iconBgColor: Colors.red,
                                      icon: Icons.message,
                                      text: 'Messages',
                                    ),
                                    SizedBox(height: Dimentions.height20),
                                    // LogOut
                                    GestureDetector(
                                      onTap: () {
                                        if (Get.find<AuthController>().userLoggedIn()) {
                                          Get.find<AuthController>().clearShearedData();
                                          Get.find<CartController>().clear();
                                          Get.find<CartController>().clearCartHistory();
                                          Get.toNamed(RouteHelper.getSignInPage());
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
                                    SizedBox(height: Dimentions.height20),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
              },
            ),
    );
  }
}
