import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_deli/Utils/colors.dart';
import 'package:food_deli/Utils/dimentions.dart';
import 'package:food_deli/pages/auth/sign_up_page.dart';
import 'package:food_deli/widgets/app_text_field.dart';
import 'package:food_deli/widgets/large_text.dart';
import 'package:get/get.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
            Container(
              padding: EdgeInsets.symmetric(vertical: Dimentions.height15),
              width: Dimentions.screenWidth / 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimentions.radius20),
                color: AppColors.mainColor,
              ),
              child: Center(
                child: LargeText(
                  text: 'Sign Up',
                  color: Colors.white,
                  size: Dimentions.font26,
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
      ),
    );
  }
}
