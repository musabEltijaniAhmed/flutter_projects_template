import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../shared/class_shared_import.dart';

class LottieHelper extends StatefulWidget {
  final String lottiePath;
  final double? height;
  final String? message;
  const LottieHelper({
    super.key,
    required this.lottiePath,
    this.height,
    this.message,
  });

  @override
  State<LottieHelper> createState() => _LottieHelperState();
}

class _LottieHelperState extends State<LottieHelper>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this);

    ///run animation unit end without repeating
    ///then await 2 scone and open anther page
    animationController.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        ///go to page after complete animation
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          widget.lottiePath,
          height: widget.height,
          controller: animationController,
          onLoaded: (lottieComposition) {
            /// Adjust the speed factor, e.g., 2.0 for 2x speed
            const double speedFactor = 1.6;

            /// Convert the original duration to milliseconds
            final int originalDurationMs =
                lottieComposition.duration.inMilliseconds;

            /// Speed up the animation by dividing the original duration by the speed factor
            final int newDurationMs =
                (originalDurationMs / speedFactor).round();

            /// Set the new duration for the animation controller
            animationController.duration = Duration(
              milliseconds: newDurationMs,
            );

            /// Start the animation
            animationController.forward();
          },
        ),
        //=========================================================================================================
        Transform.translate(
          offset: Offset(0, -50.h),
          child: AppText(
            text: widget.message ?? AppMessage.noData,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
