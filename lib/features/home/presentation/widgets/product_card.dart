import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketi/core/utils/app_colors.dart';


class ProductCard extends StatefulWidget {
  const ProductCard({
    Key? key,
    required this.image,
    required this.price,
    required this.name,
    required this.rate,
    required this.onTap,
  }) : super(key: key);

  final String image;
  final String price;
  final String name;
  final String rate;
  final VoidCallback onTap;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 164.w,
      height: 200.h,
      margin: EdgeInsets.only(right: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.h),
                  child: Container(
                    height: 96.h,
                    width: 167.w,
                    decoration: BoxDecoration(
                      color: AppColors.lightBlue900,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.r),
                      child: Image.network(
                        widget.image,
                        width: double.infinity,
                        height: 120.h,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(4.w),
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? AppColors.black : AppColors.darkblue900,
                          size: 20.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.price,
                    ),
                    Row(
                      children: [
                        SizedBox(width: 4.w),
                        Text(widget.rate),
                      ],
                    ),
                  ],
                ),

                Text(
                  widget.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

              ],
            ),
          ),
          GestureDetector(
            onTap: widget.onTap,
            child: Padding(
              padding:  EdgeInsets.only(left: 20.h, right: 20.h,bottom: 8.h),
              child: Container(
                height: 30.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(color: AppColors.lightBlue100),
                ),
                child: Center(
                  child:  Text(
                      "Add",
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}