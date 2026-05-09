import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final double height;
  final double thickness;
  final Color? color;
  final double horizontalPadding;

  const CustomDivider({
    super.key,
    this.height = 1,
    this.thickness = 1,
    this.color,
    this.horizontalPadding = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Divider(
        height: height,
        thickness: thickness,
        // Using a very light grey (0xFFF1F1F1) to match the screenshot
        color: color ?? const Color(0xFFF1F1F1),
      ),
    );
  }
}