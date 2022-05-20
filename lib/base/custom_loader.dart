import 'package:flutter/material.dart';
import 'package:food_deli/Utils/colors.dart';
import 'package:food_deli/Utils/dimentions.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: Dimentions.height20 * 5,
        width: Dimentions.height20 * 5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimentions.height20 * 5 / 2),
          color: AppColors.mainColor,
        ),
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
