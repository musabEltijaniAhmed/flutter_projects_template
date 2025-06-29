import 'package:flutter/material.dart';
import 'package:matryal_seller/core/shared/class_shared_import.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? text;
  final List<Widget>? actions;
  final bool? showActions;
  final bool? centerTitle;
  final Color? backgroundColor;
  final Color? textColor;
  final Widget? leading;
  final Color? actionColor;
  final double? leadingWidth;
  final double? fontSize;
  final double? elevation;
  final bool showBackArrow;
  final Widget? customTitle;
  const AppBarWidget({
    super.key,
    this.text,
    this.actions,
    this.showActions,
    this.backgroundColor,
    this.textColor,
    this.centerTitle = true,
    this.leading,
    this.actionColor,
    this.leadingWidth,
    this.fontSize,
    this.elevation,
    this.showBackArrow = false,
    this.customTitle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(15.r)),
      ),
      automaticallyImplyLeading: false,
      centerTitle: centerTitle ?? false,
      surfaceTintColor: AppColor.white,
      backgroundColor: (backgroundColor ?? AppColor.subtextColor),
      toolbarHeight:
          customTitle == null
              ? AppSize.appBarSmallHeight
              : AppSize.appBarHeight,
      title:
          customTitle ??
          AppText(
            text: text ?? '',
            fontSize: fontSize ?? AppSize.appBarTitleSize,
            color: textColor ?? AppColor.white,
            fontWeight: FontWeight.bold,
          ),
      leading: leading,
      leadingWidth: leadingWidth,
      actions:
          showBackArrow
              ? (actions ??
                  [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: actionColor ?? AppColor.white,
                        size: AppSize.appBarIconSize,
                      ),
                    ),
                  ])
              : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
    customTitle == null ? AppSize.appBarSmallHeight : AppSize.appBarHeight,
    //kToolbarHeight
  );
}
