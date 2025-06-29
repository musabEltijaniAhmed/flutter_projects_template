import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:matryal_seller/core/shared/class_shared_import.dart';

class CustomPageIndicator extends StatelessWidget {
  final PageController pageController;
  final void Function(int)? onDotClicked;
  final int itemCount;

  const CustomPageIndicator({
    super.key,
    required this.pageController,
    required this.itemCount,
    this.onDotClicked,
  });

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: pageController,
      count: itemCount,
      onDotClicked: onDotClicked,
      effect: WormEffect(
        spacing: 8.spMin,
        radius: 25.0.r, // Using ScreenUtil for responsive size
        dotWidth: 10.0.spMin,
        dotHeight: 10.0.spMin,
        dotColor: AppColor.white, // Inactive dot color
        activeDotColor: AppColor.subtextColor, // Active dot color
      ),
    );
  }
}
