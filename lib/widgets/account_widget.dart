import 'package:flutter/material.dart';
import 'package:food_deli/Utils/dimensions.dart';
import 'package:food_deli/widgets/app_icon.dart';
import 'package:food_deli/widgets/large_text.dart';

class AccountWidget extends StatelessWidget {
  final Color iconBgColor;
  final IconData icon;
  final String text;
  // final AppIcon appIcon;
  // final LargeText largeText;
  const AccountWidget({
    Key? key,
    // required this.appIcon,
    // required this.largeText,
    required this.iconBgColor,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: Dimensions.width20, vertical: Dimensions.height10),
      child: Row(
        children: [
          AppIcon(
            icon: icon,
            bgColor: iconBgColor,
            iconColor: Colors.white,
            size: Dimensions.height10 * 5,
            iconSize: Dimensions.height10 * 5 / 2,
          ),
          SizedBox(
            width: Dimensions.width20,
          ),
          LargeText(
            text: text,
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.radius15),
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            offset: const Offset(0, 2),
            color: Colors.grey.withOpacity(0.2),
          ),
        ],
      ),
    );
  }
}
