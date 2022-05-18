import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_deli/Utils/colors.dart';
import 'package:food_deli/Utils/dimentions.dart';
import 'package:food_deli/base/custom_loader.dart';
import 'package:food_deli/base/show_custom_snackbar.dart';
import 'package:food_deli/controllers/auth_controller.dart';
import 'package:food_deli/models/sign_up_body_model.dart';
import 'package:food_deli/widgets/app_text_field.dart';
import 'package:food_deli/widgets/large_text.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImages = [
      't.png',
      'f.png',
      'g.png',
    ];

    void _registration(AuthController authController) {
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (name.isEmpty) {
        showCustomSnackBar('Fill in your name', title: 'Name');
      } else if (phone.isEmpty) {
        showCustomSnackBar('Fill in your phone number', title: 'Phone Number');
      } else if (email.isEmpty) {
        showCustomSnackBar('Fill in your email', title: 'Email');
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar('Email is invalid', title: 'Invalid Email');
      } else if (password.isEmpty) {
        showCustomSnackBar('Password can not be empty', title: 'Empty Password');
      } else if (password.length < 6) {
        showCustomSnackBar('Password should be at least 6 characters long', title: 'Invalid Password');
      } else {
        showCustomSnackBar('All went well', title: 'Perfect', color: Colors.green.shade200);
        SignUpBody signUpBody = SignUpBody(
          name: name,
          phone: phone,
          email: email,
          password: password,
        );
        authController.registration(signUpBody).then((status) {
          if (status.isSuccess) {
            showCustomSnackBar('Success Registration', color: Colors.green, title: 'Registration');
          } else {
            showCustomSnackBar('Fail Registration');
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(builder: (_authController) {
          return _authController.isLoading
              ? const CustomLoader()
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: Dimentions.screenHeight * 0.05,
                      ),
                      // Avatar Image
                      SizedBox(
                        height: Dimentions.screenHeight * 0.25,
                        width: double.maxFinite,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: Dimentions.height40 * 2,
                          child: const Image(image: AssetImage('assets/image/logo part 1.png')),
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
                      // Your password
                      AppTextField(
                        controller: passwordController,
                        hintText: 'Password',
                        icon: Icons.password,
                        isObscure: true,
                      ),
                      SizedBox(height: Dimentions.height20),
                      //Your name
                      AppTextField(
                        controller: nameController,
                        hintText: 'Name',
                        icon: Icons.edit,
                      ),
                      SizedBox(height: Dimentions.height20),
                      // Your phone
                      AppTextField(
                        controller: phoneController,
                        hintText: 'Phone',
                        icon: Icons.phone,
                      ),
                      SizedBox(height: Dimentions.height20),
                      // Sign up Button
                      GestureDetector(
                        onTap: () {
                          _registration(_authController);
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
                              text: 'Sign Up',
                              color: Colors.white,
                              size: Dimentions.font26,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Dimentions.height10),
                      // Login Option
                      RichText(
                        text: TextSpan(
                          recognizer: TapGestureRecognizer()..onTap = () => Get.back(),
                          text: 'Already have an account?',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: Dimentions.font16,
                          ),
                        ),
                      ),
                      SizedBox(height: Dimentions.screenHeight * 0.03),
                      // Other methods
                      RichText(
                        text: TextSpan(
                          text: 'Sign up using one of the following methods',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: Dimentions.font16,
                          ),
                        ),
                      ),
                      Wrap(
                        children: List.generate(
                          3,
                          (index) => Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: CircleAvatar(
                              radius: Dimentions.radius20,
                              backgroundImage: AssetImage('assets/image/${signUpImages[index]}'),
                              // child: Image.asset(
                              //   'assets/image/${signUpImages[index]}',
                              //   fit: BoxFit.cover,
                              // ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
        }));
  }
}
