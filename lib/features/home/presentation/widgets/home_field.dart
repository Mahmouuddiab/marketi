import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/utils/app_colors.dart';

class HomeField extends StatelessWidget {
  String hintTxt;
  TextEditingController? controller;
  String? Function(String?)? validator;
  bool obscureText;
  Widget? suffixIcon;
  bool? isDense;
  void Function(String)? onChanged;
  TextInputType? keyboardType;
  Widget? prefixIcon;
   HomeField({
     super.key,
     required this.hintTxt,
     this.controller,
     this.validator,
     this.obscureText= false,
     this.suffixIcon,
     this.isDense,
     this.onChanged,
     this.keyboardType,
     this.prefixIcon
   });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      onChanged: onChanged,
      keyboardType: keyboardType,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
        hintText: hintTxt,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        isDense: isDense,
        hintStyle: GoogleFonts.poppins(
            fontSize: 15,
            color: AppColors.gray1
        ),
        labelStyle: GoogleFonts.poppins(
            fontSize: 15,
            color: AppColors.gray1
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: AppColors.gray1)
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: AppColors.primaryColor)
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: AppColors.darkred500)
        ),
      ),
    );
  }
}
