import 'package:flutter/material.dart';
import 'package:food_deli/Utils/colors.dart';
import 'package:food_deli/Utils/dimensions.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final bool transparent;
  final EdgeInsets? margin;
  final double? height;
  final double? width;
  final double? fontSize;
  final double radius;
  final IconData? icon;

  const CustomButton({
    Key? key,
    this.onPressed,
    required this.buttonText,
    this.transparent = false,
    this.margin,
    this.height,
    this.width,
    this.fontSize,
    this.radius = 5,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle _flatButton = TextButton.styleFrom(
      backgroundColor: onPressed == null
          ? Theme.of(context).disabledColor
          : transparent
              ? Colors.transparent
              : AppColors.mainColor,
      minimumSize: Size(
        width != null ? width! : Dimensions.screenWidth,
        height != null ? height! : Dimensions.height100 / 2,
      ),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
    );
    return Center(
      child: SizedBox(
        width: width ?? Dimensions.screenWidth,
        height: height ?? Dimensions.height100 / 2,
        child: TextButton(
          onPressed: onPressed,
          style: _flatButton,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon != null
                  ? Padding(
                      padding: EdgeInsets.only(right: Dimensions.width10),
                      child: Icon(
                        icon,
                        color: transparent ? AppColors.mainColor : Theme.of(context).cardColor,
                      ),
                    )
                  : const SizedBox(),
              Text(
                buttonText,
                style: TextStyle(
                  fontSize: fontSize ?? Dimensions.font16,
                  color: transparent ? AppColors.mainColor : Theme.of(context).cardColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
