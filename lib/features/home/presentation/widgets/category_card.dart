import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketi/core/utils/app_colors.dart';
import 'package:marketi/features/home/domain/entity/category_entity.dart';

class CategoryCard extends StatelessWidget {
  CategoryCard({super.key, required this.category,this.onTap});
  final CategoryEntity category;
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
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.lightBlue700),
            ),
            child: Image.network(
              category.image,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            category.name,
            style: GoogleFonts.poppins(
              color: AppColors.darkblue700
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
