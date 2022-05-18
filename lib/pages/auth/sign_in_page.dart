import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_deli/Utils/colors.dart';
import 'package:food_deli/Utils/dimentions.dart';
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
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (email.isEmpty) {
        showCustomSnackBar('Fill in your email', title: 'Email');
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar('Email is invalid', title: 'Invalid Email');
      } else if (password.isEmpty) {
        showCustomSnackBar('Password can not be empty', title: 'Empty Password');
      } else if (password.length < 6) {
        showCustomSnackBar('Password should be at least 6 characters long', title: 'Invalid Password');
      } else {
        showCustomSnackBar('All went well', title: 'Login', color: Colors.green.shade200);

        authController.login(email, password).then((status) {
          if (status.isSuccess) {
            showCustomSnackBar('Success Login', color: Colors.green, title: 'Login');
            Get.toNamed(RouteHelper.getInitial());
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
                      height: Dimentions.screenHeight * 0.05,
                    ),
                    // App Logo
                    SizedBox(
                      height: Dimentions.screenHeight * 0.25,
                      width: double.maxFinite,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: Dimentions.height40 * 2,
                        // backgroundImage: const AssetImage('assets/image/logo part 1.png'),
                        child: const Image(image: AssetImage('assets/image/logo part 1.png')),
                      ),
                    ),
                    SizedBox(height: Dimentions.height20),
                    // Welcome
                    Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.only(left: Dimentions.width20),
                      child: Text(
                        'Hello',
                        style: TextStyle(
                          fontSize: Dimentions.font20 * 3 + Dimentions.font20 / 2,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(height: Dimentions.height20),

                    // Your email
                    AppTextField(
                      controller: emailController,
                      hintText: 'Email',
                      icon: Icons.mail,
                    ),
                    SizedBox(height: Dimentions.height20),

                    //Your password
                    AppTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      icon: Icons.password,
                      isObscure: true,
                    ),
                    SizedBox(height: Dimentions.height20),
                    // Login Option
                    Container(
                      margin: EdgeInsets.only(right: Dimentions.width20),
                      width: double.maxFinite,
                      child: RichText(
                        text: TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print('Sign up clicked');
                            },
                          text: 'Sign into your account',
                          style: TextStyle(color: Colors.black54, fontSize: Dimentions.font18),
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SizedBox(height: Dimentions.screenHeight * 0.05),
                    // Sign up Button
                    GestureDetector(
                      onTap: () {
                        _login(authController);
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
                    SizedBox(height: Dimentions.screenHeight * 0.05),
                    // Login Option
                    RichText(
                      text: TextSpan(
                        text: 'Don\'t have an account? ',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: Dimentions.font16,
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
                              fontSize: Dimentions.font16,
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
