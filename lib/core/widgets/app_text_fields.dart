import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_project_template/core/constants/app_color.dart';
import 'package:flutter_project_template/core/constants/app_size.dart';
import 'package:flutter_project_template/core/themes/custom_widgets_theme.dart';

import 'helpers.dart';

class AppTextFields extends StatelessWidget {
  final bool? obscureText;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? hintText;
  final int? minLines;
  final int? maxLines;
  final bool? enable;
  final FontWeight? fontWeight;
  final void Function()? onTap;
  final bool? customDesign;
  final Color? fillColor;
  final Color? labelColor;
  final Color? textColor;
  final Widget? suffix;
  final Widget? prefix;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final void Function(String)? onChanged;
  final TextAlign? textAlignment;
  final Function(String)? onSubmit;
  final String? helperText;
  final TextDirection? textDirection;
  final double? radius;
  final Color? borderColor;
  final Color? focusedColor;
  final Color? hintColor;
  final double? labelSize;
  final double? borderThickness;
  final double? width;
  final EdgeInsetsGeometry? contentPadding;
  final double? hintStyleHeight;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final void Function(PointerDownEvent)? onTapOutside;
  final bool? readOnly;
  final String? labelText;
  final double? textSize;
  final bool? isFocus;
  final BoxConstraints? prefixIconConstraints;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final bool? ltr;
  final String? initialValue;

  const AppTextFields({
    super.key,
    this.validator,
    this.onTap,
    this.inputFormatters,
    this.keyboardType,
    this.hintColor,
    this.controller,
    this.hintText,
    this.fontWeight,
    this.obscureText,
    this.minLines,
    this.maxLines,
    this.enable,
    this.customDesign,
    this.fillColor,
    this.suffix,
    this.prefix,
    this.onChanged,
    this.textAlignment,
    this.onSubmit,
    this.helperText,
    this.textDirection,
    this.radius,
    this.borderColor,
    this.labelSize,
    this.focusedColor,
    this.borderThickness,
    this.width,
    this.contentPadding,
    this.hintStyleHeight,
    this.focusNode,
    this.textInputAction,
    this.labelColor,
    this.textColor,
    this.readOnly,
    this.labelText,
    this.onTapOutside,
    this.textSize,
    this.isFocus,
    this.ltr,
    this.prefixIconConstraints,
    this.floatingLabelBehavior,
    this.suffixIcon,
    this.prefixIcon,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      onTapOutside: onTapOutside,
      readOnly: readOnly ?? false,
      enabled: enable ?? true,
      minLines: minLines ?? 1,
      maxLines: maxLines ?? 1,
      onTap: onTap,
      textDirection: ltr == true ? TextDirection.ltr : textDirection,
      onChanged: onChanged,
      autocorrect: false,
      enableSuggestions: false,
      obscureText: obscureText ?? false,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textAlign: textAlignment ?? TextAlign.start,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      controller: controller,
      cursorRadius: Radius.circular(20.r),
      cursorColor: AppColor.mainColor,
      textInputAction: textInputAction,
      onFieldSubmitted: onSubmit,
      focusNode: focusNode,
      style: AppHelpers.styleText(
        color: AppColor.textFormFieldColor,
        fontSize: AppSize.captionText,
      ),
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        suffix: suffix,
        prefix: prefix,
        prefixIconConstraints: prefixIconConstraints,
        filled: true,
        fillColor: fillColor ?? AppColor.white,
        hintText: hintText,
        labelText: labelText,
        floatingLabelBehavior: floatingLabelBehavior,
        hintStyle: AppHelpers.styleText(
          color: hintColor ?? AppColor.textColor,
          fontSize: AppSize.captionText,
        ),
        labelStyle: AppHelpers.styleText(
          color: AppColor.textFormFieldColor,
          fontSize: AppSize.captionText,
        ),
        errorStyle: TextStyle(color: AppColor.red, fontSize: AppSize.smallText),
        errorMaxLines: 4,
        focusedErrorBorder: border(color: AppColor.red, width: 0.7),
        contentPadding:
            contentPadding ??
            EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
        border: border(),
        enabledBorder: border(color: borderColor),
        disabledBorder: border(color: borderColor),
        focusedBorder: border(color: AppColor.mainColor, width: 1.5),
        errorBorder: border(color: AppColor.red, width: 0.7),
      ),
    );
  }
}
