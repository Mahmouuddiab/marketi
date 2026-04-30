import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:marketi/core/utils/app_colors.dart';

class BannerShow extends StatelessWidget {
  const BannerShow({super.key});

  @override
  Widget build(BuildContext context) {
    return ImageSlideshow(
        width: double.infinity,
        height: 200,
        initialPage: 0,
        indicatorColor: AppColors.primaryColor,
        indicatorBackgroundColor: AppColors.gray1,
        autoPlayInterval: 3000,
        isLoop: true,
        indicatorRadius: 5,
        disableUserScrolling: true,
        children: [
          Image.asset("assets/images/CarouselSlider1.png"),
          Image.asset("assets/images/CarouselSlider2.png"),
          Image.asset("assets/images/CarouselSlider3.png")
        ]
    );
  }
}
