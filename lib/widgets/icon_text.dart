import 'package:flutter/material.dart';
import 'package:food_deli/Utils/colors.dart';
import 'package:food_deli/Utils/dimensions.dart';
import 'package:food_deli/widgets/small_text.dart';

class IconTextWidget extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String text;
  const IconTextWidget({
    Key? key,
    required this.icon,
    this.iconColor = const Color(0xFFffd28d),
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: Dimensions.iconSize24,
        ),
        const SizedBox(width: 5),
        SmallText(text: text, color: AppColors.paraColor),
      ],
    );
  }
}
