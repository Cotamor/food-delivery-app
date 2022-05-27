import 'package:flutter/material.dart';
import 'package:food_deli/Utils/colors.dart';
import 'package:food_deli/Utils/dimensions.dart';
import 'package:food_deli/base/show_custom_snackbar.dart';
import 'package:food_deli/controllers/auth_controller.dart';
import 'package:food_deli/controllers/cart_controller.dart';
import 'package:food_deli/controllers/location_controller.dart';
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
      Get.find<UserController>().getUserInfo();
      Get.find<LocationController>().getAddressList();
      print('user has logged in');
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
                  height: Dimensions.height20 * 10,
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
                    padding: EdgeInsets.symmetric(vertical: Dimensions.height15),
                    width: Dimensions.screenWidth / 2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor,
                    ),
                    child: Center(
                      child: LargeText(
                        text: 'Sign In',
                        color: Colors.white,
                        size: Dimensions.font26,
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
                        margin: EdgeInsets.only(top: Dimensions.height20),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Profile icon
                            AppIcon(
                              icon: Icons.person,
                              bgColor: AppColors.mainColor,
                              iconColor: Colors.white,
                              size: Dimensions.height15 * 10,
                              iconSize: Dimensions.height45 + Dimensions.height30,
                            ),
                            SizedBox(height: Dimensions.height20),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    // Name
                                    AccountWidget(
                                      iconBgColor: AppColors.mainColor,
                                      icon: Icons.person,
                                      text: userController.userModel!.name,
                                    ),
                                    SizedBox(height: Dimensions.height20),
                                    // Phone
                                    AccountWidget(
                                      iconBgColor: AppColors.yellowColor,
                                      icon: Icons.phone,
                                      text: userController.userModel!.phone,
                                    ),
                                    SizedBox(height: Dimensions.height20),
                                    // Email
                                    AccountWidget(
                                      iconBgColor: AppColors.yellowColor,
                                      icon: Icons.email,
                                      text: userController.userModel!.email,
                                    ),
                                    SizedBox(height: Dimensions.height20),
                                    // Address
                                    GetBuilder<LocationController>(builder: (locationController) {
                                      if (_userLoggedIn && locationController.addressList.isEmpty) {
                                        return GestureDetector(
                                          onTap: () => Get.toNamed(RouteHelper.getAddAddressPage()),
                                          child: const AccountWidget(
                                            iconBgColor: AppColors.yellowColor,
                                            icon: Icons.location_on,
                                            text: 'Fill in your address',
                                          ),
                                        );
                                      } else {
                                        return GestureDetector(
                                          onTap: () => Get.toNamed(RouteHelper.getAddAddressPage()),
                                          child: const AccountWidget(
                                            iconBgColor: AppColors.yellowColor,
                                            icon: Icons.location_on,
                                            text: 'Your address',
                                          ),
                                        );
                                      }
                                    }),

                                    SizedBox(height: Dimensions.height20),
                                    // Messages
                                    const AccountWidget(
                                      iconBgColor: Colors.red,
                                      icon: Icons.message,
                                      text: 'Messages',
                                    ),
                                    SizedBox(height: Dimensions.height20),
                                    // LogOut
                                    GestureDetector(
                                      onTap: () {
                                        if (Get.find<AuthController>().userLoggedIn()) {
                                          Get.find<AuthController>().clearShearedData();
                                          Get.find<CartController>().clear();
                                          Get.find<CartController>().clearCartHistory();
                                          Get.find<LocationController>().clearAddressList();
                                          Get.offNamed(RouteHelper.getSignInPage());
                                        } else {
                                          Get.offNamed(RouteHelper.getSignInPage());
                                          showCustomSnackBar('You logged out', color: Colors.green, title: 'Log Out');
                                        }
                                      },
                                      child: const AccountWidget(
                                        iconBgColor: Colors.red,
                                        icon: Icons.logout,
                                        text: 'Log Out',
                                      ),
                                    ),
                                    SizedBox(height: Dimensions.height20),
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
