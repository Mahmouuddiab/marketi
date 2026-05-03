import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketi/core/utils/app_colors.dart';

class CustomRow extends StatelessWidget {
  String text1, text2;
  void Function()? onTap;
  CustomRow({super.key, required this.text1, required this.text2,this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text1,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.darkblue700,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            text2,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
