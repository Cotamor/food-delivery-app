import 'package:flutter/material.dart';
import 'package:food_deli/Utils/colors.dart';
import 'package:food_deli/Utils/dimentions.dart';
import 'package:food_deli/pages/home/food_page_body.dart';
import 'package:food_deli/widgets/large_text.dart';
import 'package:food_deli/widgets/small_text.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header Section
        Container(
          // Scrolling Feature implement tbd
          color: Colors.grey.shade200,
          margin: EdgeInsets.only(
              top: Dimentions.height45, bottom: Dimentions.height15),
          padding: EdgeInsets.only(
              left: Dimentions.width20, right: Dimentions.width20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  const LargeText(
                    text: 'Japan',
                    color: AppColors.mainColor,
                  ),
                  Row(
                    children: const [
                      SmallText(text: 'Yokohama'),
                      Icon(
                        Icons.arrow_drop_down_rounded,
                        color: AppColors.mainBlackColor,
                      )
                    ],
                  ),
                ],
              ),
              Container(
                width: Dimentions.height45,
                height: Dimentions.height45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimentions.radius15),
                  color: AppColors.mainColor,
                ),
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: Dimentions.iconSize24,
                ),
              )
            ],
          ),
        ),
        // FoodPageBody
        const Expanded(
          child: SingleChildScrollView(
            child: FoodPageBody(),
          ),
        ),
      ],
    );
  }
}