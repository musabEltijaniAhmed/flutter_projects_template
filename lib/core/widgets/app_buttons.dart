import 'package:flutter/material.dart';
import 'package:matryal_seller/core/shared/class_shared_import.dart';

class AppButtons extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final Color? backgroundColor;
  final Color? textStyleColor;
  final FontWeight? textStyleWeight;
  final TextOverflow? overflow;
  final double? elevation;
  final double? width;
  final double? height;
  final Widget? icon;
  final double? textSize;
  final double? radius;
  final BorderSide? side;
  final Widget? label;
  final AlignmentGeometry? alignment;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? buttonPadding;
  final BorderRadiusGeometry? borderRadius;
  final bool isLoading;
  const AppButtons({
    super.key,
    required this.onPressed,
    required this.text,
    this.backgroundColor,
    this.overflow,
    this.textStyleColor,
    this.textStyleWeight,
    this.width,
    this.elevation,
    this.height,
    this.icon,
    this.textSize,
    this.radius,
    this.alignment,
    this.side,
    this.fontWeight,
    this.label,
    this.buttonPadding,
    this.borderRadius,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? AppSize.buttonHeight,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          alignment: alignment,
          shape: RoundedRectangleBorder(
              borderRadius: borderRadius ??
                  BorderRadius.circular((radius ?? AppSize.buttonRadius)),
              side: side ?? const BorderSide(color: AppColor.noColor, width: 0.3)),
          backgroundColor: (backgroundColor ?? AppColor.subtextColor),
          elevation: elevation ?? 0,
          padding: buttonPadding,
          textStyle: TextStyle(
            color: textStyleColor ?? Colors.white,
            fontSize: textSize ?? AppSize.buttonFontSize,
            fontWeight: fontWeight,
          ),
        ),
        onPressed: isLoading ? null : onPressed,
        icon: isLoading ? const SizedBox.shrink() : icon ?? const SizedBox(),
        label:
            isLoading
                ? CustomLoad().circularLoad()
                : label ??
                    AppText(
                      color: textStyleColor ?? Colors.white,
                      fontSize: textSize ?? AppSize.buttonFontSize,
                      fontWeight: fontWeight,
                      text: text,
                    ),
      ),
    );
  }
}
