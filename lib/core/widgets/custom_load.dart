import 'package:flutter/material.dart';
import 'package:flutter_project_template/core/shared/class_shared_import.dart';
import 'package:flutter_project_template/core/widgets/app_decoration.dart';

import 'app_shimmer.dart';

class CustomLoad {
  /// 1. Private static instance
  static final CustomLoad _instance = CustomLoad._internal();

  /// 2. Private constructor
  CustomLoad._internal();

  /// 3. Public factory constructor
  factory CustomLoad() => _instance;

  ///CircularProgressIndicator load
  Widget circularLoad({Color? color}) {
    return SizedBox(
      height: 30.spMin,
      width: 30.spMin,
      child: CircularProgressIndicator(
        color: color ?? AppColor.white,
        strokeWidth: 1.9.r,
      ),
    );
  }

  Widget projectShimmer(BuildContext context, {int length = 4}) {
    return AppShimmerWidget(
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 10.h, left: 10.w, right: 10.w),
        itemCount: length,

        itemBuilder: (_, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: const ProjectWidget(),
          );
        },
      ),
    );
  }

  ///box load
  Widget boxLoad({double? width, double? height}) {
    return Container(
      width: width ?? AppSize.screenWidth,
      height: height ?? 200.h,
      decoration: AppDecoration.decoration(
        radius: 5.r,
        color: AppColor.lightGray,
      ),
    );
  }

  Widget loadVerticalList({required BuildContext context, int length = 10}) {
    return SizedBox(
      child: AppShimmerWidget(
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: length,
          itemBuilder:
              (context, index) => Padding(
                padding: EdgeInsets.all(AppSize.defaultPadding),
                child: Container(
                  height: 120.h,
                  width: context.width,
                  decoration: AppDecoration.decoration(shadow: false),
                ),
              ),
        ),
      ),
    );
  }

  Widget loadGridList({required BuildContext context, int length = 10}) {
    return SizedBox(
      child: AppShimmerWidget(
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 15.h,
            crossAxisSpacing: 15.w,
            childAspectRatio: 3.1,
          ),
          itemCount: length,
          itemBuilder:
              (context, index) => Container(
                decoration: AppDecoration.decoration(shadow: false),
              ),
        ),
      ),
    );
  }
}
