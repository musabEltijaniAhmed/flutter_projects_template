import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:matryal_seller/core/shared/class_shared_import.dart';
import 'package:matryal_seller/core/widgets/app_decoration.dart';

class AppDialog {
  static showLoading({required context}) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          titlePadding: EdgeInsets.zero,
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: Container(
            alignment: AlignmentDirectional.center,
            child: Lottie.asset(Assets.lottieLoading, height: 90.h),
          ),
        );
      },
    );
  }

  ///=================================================================================
  static Future<T?> viewDialog<T>({
    required BuildContext context,
    required Widget child,
    bool? showCloseBar,
    required String title,
    double? height,
    EdgeInsets? dialogPadding,
    double? width,
    bool barrierDismissible = true,
    final Widget? gestureDetectorChild,
    CrossAxisAlignment? crossAxisAlignment,
  }) {
    return showDialog<T>(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: dialogPadding ?? const EdgeInsets.all(20),
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: width ?? MediaQuery.of(context).size.width * (context.isLargeScreen?0.7:0.9),
              maxHeight: height ?? MediaQuery.of(context).size.height * 0.8,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
                  crossAxisAlignment ?? CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.w,
                    horizontal: 10.w,
                  ),
                  decoration: AppDecoration.decoration(
                    shadow: false,
                    color: AppColor.lightGray,
                    radiusOnlyTop: true,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        text: title,
                        fontSize: AppSize.captionText,
                        fontWeight: FontWeight.bold,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child:
                            gestureDetectorChild ?? Icon(AppIcons.closeSquare,size: AppSize.appBarIconSize,),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(AppSize.defaultPadding),
                    child: child,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
