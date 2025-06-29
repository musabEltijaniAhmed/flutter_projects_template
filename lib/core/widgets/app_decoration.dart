import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_project_template/core/constants/app_color.dart';
import 'package:flutter_project_template/core/extensions/color_extensions.dart';

class AppDecoration {
  /// Returns a customizable [BoxDecoration] for styling a widget===============================================================================================
  static BoxDecoration decoration({
    bool shadow = true,
    Color? color,
    double radius = 10,
    double shadowOpacity = 0.5,
    bool showBorder = false,
    Color? borderColor,
    double borderWidth = 0.5,
    ImageProvider<Object>? image,
    bool cover = false,
    ColorFilter? colorFilter,
    bool isGradient = false,
    AlignmentGeometry alignment = Alignment.center,
    Gradient? gradient,
    double? blurRadius,
    BorderRadiusGeometry? borderRadius,
    bool isCircle = false,

    // Radius flags
    bool radiusOnlyTop = false,
    bool radiusOnlyBottom = false,
    bool radiusOnlyTopLeftBottomLeft = false,
    bool radiusOnlyTopRightBottomRight = false,
    bool radiusOnlyTopLeft = false,
    bool radiusOnlyTopRight = false,
    bool radiusOnlyBottomLeft = false,
    bool radiusOnlyBottomRight = false,

    // New border sides
    bool showLeftBorder = false,
    bool showRightBorder = false,
  }) {
    final Radius resolvedRadius = Radius.circular(radius.r);

    BorderRadiusGeometry resolveRadius() {
      if (borderRadius != null) return borderRadius;

      if (radiusOnlyTop) {
        return BorderRadius.only(
          topLeft: resolvedRadius,
          topRight: resolvedRadius,
        );
      } else if (radiusOnlyBottom) {
        return BorderRadius.only(
          bottomLeft: resolvedRadius,
          bottomRight: resolvedRadius,
        );
      } else if (radiusOnlyTopLeftBottomLeft) {
        return BorderRadius.only(
          topLeft: resolvedRadius,
          bottomLeft: resolvedRadius,
        );
      } else if (radiusOnlyTopRightBottomRight) {
        return BorderRadius.only(
          topRight: resolvedRadius,
          bottomRight: resolvedRadius,
        );
      } else if (radiusOnlyTopLeft) {
        return BorderRadius.only(topLeft: resolvedRadius);
      } else if (radiusOnlyTopRight) {
        return BorderRadius.only(topRight: resolvedRadius);
      } else if (radiusOnlyBottomLeft) {
        return BorderRadius.only(bottomLeft: resolvedRadius);
      } else if (radiusOnlyBottomRight) {
        return BorderRadius.only(bottomRight: resolvedRadius);
      }

      return BorderRadius.all(resolvedRadius);
    }

    Border? buildBorder() {
      if (showBorder) {
        return Border.all(
          color: borderColor ?? AppColor.lightGray,
          width: borderWidth,
        );
      }

      if (showLeftBorder || showRightBorder) {
        return Border(
          left:
              showLeftBorder
                  ? BorderSide(
                    color: borderColor ?? AppColor.lightGray,
                    width: borderWidth,
                  )
                  : BorderSide.none,
          right:
              showRightBorder
                  ? BorderSide(
                    color: borderColor ?? AppColor.lightGray,
                    width: borderWidth,
                  )
                  : BorderSide.none,
        );
      }

      return null;
    }

    return BoxDecoration(
      shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
      color: isGradient ? null : (color ?? AppColor.white),
      gradient:
          isGradient
              ? gradient ??
                  LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColor.subtextColor,
                      AppColor.subtextColor.resolveOpacity(0.99),
                      AppColor.subtextColor.resolveOpacity(0.85),
                      AppColor.subtextColor.resolveOpacity(0.62),
                    ],
                  )
              : null,
      image:
          image != null
              ? DecorationImage(
                image: image,
                fit: cover ? BoxFit.cover : BoxFit.contain,
                colorFilter: colorFilter,
                alignment: alignment,
              )
              : null,
      border: buildBorder(),
      borderRadius: isCircle ? null : resolveRadius(),
      boxShadow:
          shadow
              ? [
                BoxShadow(
                  color: Colors.grey.resolveOpacity(shadowOpacity),
                  offset: const Offset(0, 1),
                  blurRadius: blurRadius ?? 6.0,
                ),
              ]
              : null,
    );
  }
}
