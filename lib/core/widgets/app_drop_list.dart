import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:matryal_seller/core/shared/class_shared_import.dart';

class AppDropList<T> extends StatelessWidget {
  final List<T> items;
  final String? Function(T?)? validator;
  final String hintText;
  final bool? friezeText;
  final Color? fillColor;
  final Widget? prefixIcon;
  final Widget? icon;
  final List<DropdownMenuItem<T>>? customItem;
  final void Function(T?)? onChanged;
  final T? value;

  const AppDropList({
    super.key,
    this.items=const [],
    this.validator,
    required this.hintText,
    required this.onChanged,
    this.friezeText,
    this.fillColor,
    this.prefixIcon,
    this.icon,
    this.customItem,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<T>(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      value: value,
      validator: validator ?? AppValidator.validatorEmpty,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor ?? AppColor.white,
        hintText: hintText,
        hintStyle: AppHelpers.styleText(
          color: AppColor.textColor,
          fontSize: AppSize.captionText,
        ),
        errorStyle: TextStyle(color: AppColor.red, fontSize: AppSize.smallText),
        errorMaxLines: 4,
        focusedErrorBorder: border(color: AppColor.red, width: 0.7),
        contentPadding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 8.h),
        border: border(),
        enabledBorder: border(),
        disabledBorder: border(),
        focusedBorder: border(color: AppColor.mainColor, width: 1.5),
        errorBorder: border(color: AppColor.red, width: 0.7),
      ),
      buttonStyleData: ButtonStyleData(
        height: 35.h,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
      ),
      dropdownStyleData: DropdownStyleData(
        maxHeight: 200.h,
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.all(Radius.circular(4.r)),
        ),
      ),
      menuItemStyleData: MenuItemStyleData(
        padding: EdgeInsets.only(right: 10.w),
      ),
      hint: AppText(
        fontSize: AppSize.captionText,
        text: hintText,
        color: AppColor.textColor,
      ),
      onChanged: onChanged,
      items:
          customItem ??
          items
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: AppText(
                    fontSize: AppSize.captionText,
                    text: '$e',
                    color: AppColor.textColor,
                  ),
                ),
              )
              .toList(),
    );
  }
}
