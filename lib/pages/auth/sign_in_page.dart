import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_deli/Utils/colors.dart';
import 'package:food_deli/Utils/dimensions.dart';
import 'package:food_deli/base/custom_loader.dart';
import 'package:food_deli/base/show_custom_snackbar.dart';
import 'package:food_deli/controllers/auth_controller.dart';
import 'package:food_deli/pages/auth/sign_up_page.dart';
import 'package:food_deli/routes/route_helper.dart';
import 'package:food_deli/widgets/app_text_field.dart';
import 'package:food_deli/widgets/large_text.dart';
import 'package:get/get.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController) {
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();

      if (phone.isEmpty) {
        showCustomSnackBar('Fill in your phone', title: 'Phone');
      } else if (password.isEmpty) {
        showCustomSnackBar('Password can not be empty', title: 'Empty Password');
      } else if (password.length < 6) {
        showCustomSnackBar('Password should be at least 6 characters long', title: 'Invalid Password');
      } else {
        showCustomSnackBar('All went well', title: 'Login', color: Colors.green.shade200);

        authController.login(phone, password).then((status) {
          if (status.isSuccess) {
            showCustomSnackBar('Success Login', color: Colors.green, title: 'Login');
            Get.offNamed(RouteHelper.getInitial());
          } else {
            showCustomSnackBar('Fail Login');
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController) {
        return authController.isLoading
            ? const CustomLoader()
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: Dimensions.screenHeight * 0.05,
                    ),
                    // App Logo
                    SizedBox(
                      height: Dimensions.screenHeight * 0.25,
                      width: double.maxFinite,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: Dimensions.height40 * 2,
                        // backgroundImage: const AssetImage('assets/image/logo part 1.png'),
                        child: const Image(image: AssetImage('assets/image/logo part 1.png')),
                      ),
                    ),
                    SizedBox(height: Dimensions.height20),
                    // Welcome
                    Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.only(left: Dimensions.width20),
                      child: Text(
                        'Hello',
                        style: TextStyle(
                          fontSize: Dimensions.font20 * 3 + Dimensions.font20 / 2,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(height: Dimensions.height20),

                    // Your phone
                    AppTextField(
                      controller: phoneController,
                      hintText: 'Phone',
                      icon: Icons.phone,
                    ),
                    SizedBox(height: Dimensions.height20),

                    //Your password
                    AppTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      icon: Icons.password,
                      isObscure: true,
                    ),
                    SizedBox(height: Dimensions.height20),
                    // Login Option
                    Container(
                      margin: EdgeInsets.only(right: Dimensions.width20),
                      width: double.maxFinite,
                      child: RichText(
                        text: TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print('Sign up clicked');
                            },
                          text: 'Sign into your account',
                          style: TextStyle(color: Colors.black54, fontSize: Dimensions.font18),
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SizedBox(height: Dimensions.screenHeight * 0.05),
                    // Sign up Button
                    GestureDetector(
                      onTap: () {
                        _login(authController);
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
                    SizedBox(height: Dimensions.screenHeight * 0.05),
                    // Login Option
                    RichText(
                      text: TextSpan(
                        text: 'Don\'t have an account? ',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: Dimensions.font16,
                        ),
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.to(
                                    () => const SignUpPage(),
                                  ),
                            text: 'Create ',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: Dimensions.font16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Other methods
                  ],
                ),
              );
      }),
    );
  }
}
