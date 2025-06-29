import 'package:flutter/material.dart';
import 'package:flutter_project_template/core/constants/app_color.dart';
import 'package:flutter_project_template/core/constants/app_size.dart';
import 'package:flutter_project_template/core/error/app_error_message.dart';
import 'package:flutter_project_template/core/shared/class_shared_import.dart';
import 'package:flutter_project_template/core/widgets/app_text.dart';
import 'package:flutter_project_template/core/widgets/helpers.dart';
import 'package:flutter_svg/svg.dart';

class HandleApiExceptions extends StatelessWidget {
  final String message;
  final Widget? child;
  final bool showAppBar;
  final Decoration? decoration;
  final Color? scaffoldColor;
  final double? errorImageHeight;
  final VoidCallback? onRefresh;
  final bool isSmallError;
  const HandleApiExceptions({
    super.key,
    required this.message,
    this.child,
    this.showAppBar = false,
    this.decoration,
    this.scaffoldColor,
    this.errorImageHeight,
    this.isSmallError = false,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return isSmallError
        ? Container(
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(15.w),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 25.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: AppText(text: message)),
                SizedBox(width: 5.w),
                DecoratedBox(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.mediumGray,
                  ),
                  child: IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: onRefresh,
                    icon: Icon(
                      color: AppColor.iconColor,
                      Icons.refresh_rounded,
                      size: 20.w,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
        : Container(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          decoration: decoration,
          height: AppSize.screenHeight,
          width: AppSize.screenWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              _errorImage(height: errorImageHeight ?? 0.35, context: context),
              SizedBox(height: 10.h),
              _errorMessage(message),
              _childWidget(child),
            ],
          ),
        );
  }

  ///===========================================================================================================================================
  _errorImage({required double height, required BuildContext context}) {
    return SvgPicture.asset(
      Assets.svgApiError,
      height: AppHelpers.height(context) * height,
    );
  }

  ///===========================================================================================================================================
  _errorMessage(String message) {
    return Transform.translate(
      offset: Offset(0, -15.h),
      child: AppText(
        text: AppErrorMessage.getMessage(message),
        fontSize: AppSize.captionText,
        align: TextAlign.center,
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.visible,
      ),
    );
  }

  ///===========================================================================================================================================
  _childWidget(Widget? child) {
    if (child == null) {
      return const SizedBox.shrink(); // If no child is passed, return an empty space
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 65.w),
      child: ClipRRect(borderRadius: BorderRadius.circular(30.r), child: child),
    );
  }
}
