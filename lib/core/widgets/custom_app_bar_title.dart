import 'package:flutter/material.dart';
import 'package:flutter_project_template/core/shared/class_shared_import.dart';

import 'app_decoration.dart';

class CustomAppBarTitle extends StatelessWidget {
  final String title;
  final String? searchTitle;
  final Color? textColor;
  final double? fontSize;
  final bool isAddBottom;
  final Function()? onClickBottom;
  final bool showBackArrow;

  const CustomAppBarTitle({
    super.key,
    required this.title,
    this.searchTitle,
    this.textColor,
    this.fontSize,
    this.isAddBottom = true,
    this.onClickBottom,
    this.showBackArrow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h, bottom: 10.h, left: 0.w, right: 0.w),
      child: Column(
        spacing: 10.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          //title================================================================================================================================================================================
          SizedBox(height: 10.h),
          Row(
            spacing: 10.w,
            children: [
              if (showBackArrow)
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(AppIcons.back, color: AppColor.white),
                ),
              AppText(
                text: title,
                fontSize: fontSize ?? AppSize.appBarTitleSize,
                color: textColor ?? AppColor.white,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),

          //search=====================================================================================================================================================================================
          Padding(
            padding: EdgeInsets.only(bottom: 10.h, top: 2.h),
            child: Row(
              spacing: 10.w,
              children: [
                Flexible(
                  flex: 7,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    height: 45.h,

                    decoration: AppDecoration.decoration(radius: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          text: searchTitle ?? AppMessage.search,
                          fontSize: AppSize.smallText,
                          color: AppColor.iconColor,
                        ),
                        Icon(AppIcons.search, color: AppColor.iconColor),
                      ],
                    ),
                  ),
                ),

                //add bottom- list data================================================================================================================================================================================
                Flexible(
                  child: InkWell(
                    onTap: onClickBottom,
                    child: Container(
                      width: 45.w,
                      height: AppSize.isLargeScreen ? 45.h : 45.w,
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSize.scale(8.spMin),
                        vertical: AppSize.scale(8),
                      ),
                      decoration: AppDecoration.decoration(
                        radius: 5,
                        color: AppColor.mainColor,
                      ),
                      child: UnconstrainedBox(
                        child: SvgPicture.asset(
                          isAddBottom ? Assets.svgAdd : Assets.svgFilter,
                          colorFilter: const ColorFilter.mode(
                            AppColor.white,
                            BlendMode.srcIn,
                          ),
                          height: AppSize.scale(25.spMin),
                          width: AppSize.scale(25.spMin),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
