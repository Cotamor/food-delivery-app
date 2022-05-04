import 'package:flutter/material.dart';
import 'package:food_deli/Utils/colors.dart';
import 'package:food_deli/Utils/dimentions.dart';
import 'package:food_deli/widgets/app_column.dart';
import 'package:food_deli/widgets/app_icon.dart';
import 'package:food_deli/widgets/expandable_text_widget.dart';
import 'package:food_deli/widgets/icon_text.dart';
import 'package:food_deli/widgets/large_text.dart';
import 'package:food_deli/widgets/small_text.dart';

class PopularFoodDetail extends StatelessWidget {
  const PopularFoodDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimentions.popularFoodImgSize,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/image/food0.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Navigations Top
          Positioned(
            left: Dimentions.width20,
            right: Dimentions.width20,
            top: Dimentions.height45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                AppIcon(icon: Icons.arrow_back_ios),
                AppIcon(icon: Icons.shopping_cart),
              ],
            ),
          ),
          // Title Section
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimentions.popularFoodImgSize - 20,
            child: Container(
              padding: EdgeInsets.only(
                left: Dimentions.width20,
                right: Dimentions.width20,
                top: Dimentions.height20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimentions.radius20),
                  topRight: Radius.circular(Dimentions.radius20),
                ),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppColumn(title: 'Bitter Orange Marinade'),
                  SizedBox(height: Dimentions.height20),
                  const LargeText(text: 'Introduce'),
                  SizedBox(height: Dimentions.height20),
                  // Description Section(ExpandableTextWidget)
                  const Expanded(
                    child: SingleChildScrollView(
                      child: ExpandableTextWidget(
                          text:
                              'Brisket venison hamburger leberkas. Meatball t-bone cupim ham flank boudin brisket porchetta pork belly alcatra ground round jowl capicola. Hamburger corned beef alcatra rump frankfurter tongue kevin burgdoggen. T-bone rump jowl chislic pig leberkas tenderloin drumstick doner salami turducken ham pork loin burgdoggen meatloaf. Cupim pork chop shank filet mignon. Shankle pork belly tongue jerky, kevin chicken hamburger turducken rump. Rump ham short ribs venison kielbasa.'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: Dimentions.bottomHeightBar120,
        padding: EdgeInsets.only(
          top: Dimentions.height30,
          bottom: Dimentions.height30,
          left: Dimentions.width20,
          right: Dimentions.width20,
        ),
        decoration: BoxDecoration(
          color: Colors.pink.shade100,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimentions.radius20),
            topRight: Radius.circular(Dimentions.radius20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimentions.width20,
                  vertical: Dimentions.height20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimentions.radius20),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.remove,
                    color: AppColors.signColor,
                  ),
                  SizedBox(width: Dimentions.width10 / 2),
                  const LargeText(text: '0'),
                  SizedBox(width: Dimentions.width10 / 2),
                  const Icon(
                    Icons.add,
                    color: AppColors.signColor,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimentions.width20,
                  vertical: Dimentions.height20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimentions.radius20),
                color: AppColors.mainColor,
              ),
              child: const LargeText(
                text: '\$10 | Add to cart',
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
