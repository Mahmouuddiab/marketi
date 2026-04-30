import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketi/features/home/domain/entity/product_entity.dart';

class ProductItem extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback? onAdd;
  final VoidCallback? onFavorite;

  const ProductItem({
    super.key,
    required this.product,
    this.onAdd,
    this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 164.w,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.grey.shade300, width: 1),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// IMAGE SECTION
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.network(
                  product.thumbnail ?? '',
                  height: 140.h,
                  width: double.infinity,
                  fit: BoxFit.contain, // Changed to contain to see the full product like the image
                  errorBuilder: (_, __, ___) =>
                      Container(height: 140.h, color: Colors.grey.shade100),
                ),
              ),

              /// DISCOUNT TAG
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFABC4FF), // Light blue shade from image
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(
                    "${(product.discountPercentage ?? 0).toStringAsFixed(0)}%",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              /// FAVORITE BUTTON WITH SHADOW
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: onFavorite,
                  child: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.favorite_border,
                      size: 22.sp,
                      color: const Color(0xFF001F3F), // Darker blue/black
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          /// PRICE + RATING
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$${product.price ?? 0}",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.star_outline, size: 20.sp, color: const Color(0xFF2B3D5B)),
                  SizedBox(width: 4.w),
                  Text(
                    product.rating?.toString() ?? "0",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF2B3D5B),
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 6.h),

          /// TITLE
          Text(
            product.title ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1A1A1A),
            ),
          ),

          SizedBox(height: 12.h),

          /// ADD BUTTON (Pill shape)
          SizedBox(
            width: double.infinity,
            height: 40.h,
            child: OutlinedButton(
              onPressed: onAdd,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF2176FF), width: 1.5),
                shape: StadiumBorder(), // Makes it perfectly pill-shaped
                foregroundColor: const Color(0xFF2176FF),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_shopping_cart_outlined, size: 20.sp),
                  SizedBox(width: 8.w),
                  Text(
                    "Add",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}