import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../model/on_boarding_model.dart';

class OnBoardingBody extends StatelessWidget {
  final OnBoardingModel model;

  const OnBoardingBody({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(model.image, height: 260.h),
          SizedBox(height: 40.h),
          Image.asset(model.titleImage, height: 40.h),
          SizedBox(height: 30.h),// Title as Image
          Image.asset(model.descImage, height: 90.h),  // Description as Image
        ],
      ),
    );
  }
}