import 'package:flutter/material.dart';
import 'package:food_deli/Utils/dimentions.dart';

class LargeText extends StatelessWidget {
  final String text;
  final Color? color;
  final double size;
  final TextOverflow overflow;
  const LargeText({
    Key? key,
    required this.text,
    this.color = Colors.black87,
    this.size = 0,
    this.overflow = TextOverflow.ellipsis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
        color: color,
        fontSize: size == 0 ? Dimentions.font20 : 0,
        fontWeight: FontWeight.w500,
        fontFamily: 'Roboto',
      ),
    );
  }
}
