import 'package:flutter/material.dart';
import 'package:food_deli/Utils/colors.dart';
import 'package:food_deli/Utils/dimensions.dart';
import 'package:food_deli/widgets/icon_text.dart';
import 'package:food_deli/widgets/large_text.dart';
import 'package:food_deli/widgets/small_text.dart';

class AppColumn extends StatelessWidget {
  final String title;
  const AppColumn({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title Section
        LargeText(
          text: title,
          size: Dimensions.font20,
        ),
        // Rating Star Section
        SizedBox(height: Dimensions.height10),
        Row(
          children: [
            Wrap(
              children: List.generate(
                5,
                (index) => const Icon(
                  Icons.star,
                  size: 16,
                  color: AppColors.yellowColor,
                ),
              ),
            ),
            const SizedBox(width: 10),
            const SmallText(
              text: '4.5',
              color: AppColors.paraColor,
            ),
            const SizedBox(width: 10),
            const SmallText(
              text: '1285 comments',
              color: AppColors.paraColor,
            ),
          ],
        ),
        // Info Section
        SizedBox(height: Dimensions.height20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            IconTextWidget(
              icon: Icons.circle_sharp,
              text: 'Normal',
              iconColor: AppColors.iconColor1,
            ),
            IconTextWidget(
              icon: Icons.location_on,
              text: '1.7km',
              iconColor: AppColors.mainColor,
            ),
            IconTextWidget(
              icon: Icons.access_time_rounded,
              text: '32mins',
              iconColor: AppColors.iconColor2,
            ),
          ],
        )
      ],
    );
  }
}
