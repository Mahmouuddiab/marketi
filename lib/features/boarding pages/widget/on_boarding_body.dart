import 'package:flutter/material.dart';
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
          Image.asset(model.image, height: 260),
          const SizedBox(height: 40),
          Image.asset(model.titleImage, height: 40),
          const SizedBox(height: 30),// Title as Image
          Image.asset(model.descImage, height: 90),  // Description as Image
        ],
      ),
    );
  }
}