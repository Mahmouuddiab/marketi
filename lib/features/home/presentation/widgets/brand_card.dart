import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketi/core/utils/app_colors.dart';
import 'package:marketi/features/home/domain/entity/brand_entity.dart';

class BrandCard extends StatelessWidget {
  BrandCard({super.key, required this.brand,this.onTap});
  final BrandEntity brand;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 120,
            width: 100,
            margin: EdgeInsets.symmetric(horizontal: 5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.lightBlue700),
            ),
            child: Text(brand.emoji,style: TextStyle(fontSize: 40),),
          ),
          SizedBox(height: 4.h),
          Text(
            brand.name,
            style: GoogleFonts.poppins(
                color: AppColors.darkblue700
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
