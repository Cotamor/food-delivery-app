import 'package:flutter/material.dart';
import 'package:food_deli/Utils/colors.dart';
import 'package:food_deli/Utils/dimentions.dart';
import 'package:food_deli/widgets/account_widget.dart';
import 'package:food_deli/widgets/app_icon.dart';
import 'package:food_deli/widgets/large_text.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      body: Container(
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
                    const AccountWidget(
                      iconBgColor: AppColors.mainColor,
                      icon: Icons.person,
                      text: 'Kota',
                    ),
                    SizedBox(height: Dimentions.height20),
                    // Phone
                    const AccountWidget(
                      iconBgColor: AppColors.yellowColor,
                      icon: Icons.phone,
                      text: '+81-70-2222-2222',
                    ),
                    SizedBox(height: Dimentions.height20),
                    // Email
                    const AccountWidget(
                      iconBgColor: AppColors.yellowColor,
                      icon: Icons.email,
                      text: 'example@gmail.com',
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
                      text: 'Some message',
                    ),
                    SizedBox(height: Dimentions.height20),
                    // Messages
                    const AccountWidget(
                      iconBgColor: Colors.red,
                      icon: Icons.message,
                      text: 'Some message',
                    ),
                    SizedBox(height: Dimentions.height20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
