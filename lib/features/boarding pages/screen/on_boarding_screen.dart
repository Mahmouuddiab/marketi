import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketi/core/router/app_routes.dart';
import 'package:marketi/core/utils/app_colors.dart';
import 'package:marketi/core/utils/app_images.dart';
import '../model/on_boarding_model.dart';
import '../widget/on_boarding_body.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;
  final List<OnBoardingModel> _pages = [
    OnBoardingModel(
      image: AppImages.onboarding1,
      titleImage: AppImages.onboardingTitle1,
      descImage: AppImages.onboardingSubTitle1,
    ),
    OnBoardingModel(
      image: AppImages.onboarding2,
      titleImage: AppImages.onboardingTitle2,
      descImage: AppImages.onboardingSubTitle2,
    ),
    OnBoardingModel(
      image: AppImages.onboarding3,
      titleImage: AppImages.onboardingTitle3,
      descImage: AppImages.onboardingSubTitle3,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (index) => setState(() => _currentIndex = index),
                itemBuilder: (context, index) => OnBoardingBody(model: _pages[index]),
              ),
            ),

            _buildIndicator(),

            const SizedBox(height: 40),

            _buildActionButton(),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_pages.length, (index) {
        bool isActive = _currentIndex == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 10,
          width: isActive ? 24 : 10,
          decoration: BoxDecoration(
            color: isActive ? AppColors.darkblue900 : AppColors.lightBlue100,
            borderRadius: BorderRadius.circular(20),
          ),
        );
      }),
    );
  }

  Widget _buildActionButton() {
    bool isLastPage = _currentIndex == _pages.length - 1;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        width: double.infinity,
        height: 55.h,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          onPressed: () {
            if (isLastPage) {
              Navigator.pushReplacementNamed(context, AppRoutes.register);
            } else {
              _controller.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          },
          child: Text(
            isLastPage ? "Get Started" : "Next",
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}