import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_project_template/core/constants/app_color.dart';
import 'package:flutter_project_template/core/extensions/color_extensions.dart';
import 'package:flutter_project_template/core/widgets/app_decoration.dart';

extension GlassEffect on Widget {
  Widget withGlass({
    double sigmaX = 6,
    double sigmaY = 6,
    double opacity = 0.15,
    BorderRadius? borderRadius,
    Color? color,
    EdgeInsets? padding,
  }) {
    return ClipRRect(
      borderRadius:
          borderRadius ??
          BorderRadius.only(
            topLeft: Radius.circular(25.r),
            topRight: Radius.circular(25.r),
          ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
        child: Container(
          padding: padding,
          decoration: AppDecoration.decoration(
            shadow: false,
            color: color ?? AppColor.white.resolveOpacity(opacity),
            borderRadius: borderRadius ?? BorderRadius.circular(20.r),
            showBorder: true,
            borderColor: Colors.white.resolveOpacity(0.3),
          ),
          child: this,
        ),
      ),
    );
  }
}

extension WidgetPaddingExtension on Widget {
  Padding paddingOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: left.w,
        top: top.h,
        right: right.w,
        bottom: bottom.h,
      ),
      child: this,
    );
  }
}
