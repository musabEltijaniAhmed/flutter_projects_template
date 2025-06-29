import 'package:flutter/material.dart';
import 'package:matryal_seller/core/shared/class_shared_import.dart';
import 'package:matryal_seller/core/util/url_util.dart';
import 'package:matryal_seller/core/widgets/app_decoration.dart';

import '../../../../core/widgets/app_image.dart';
import '../../providers/project_notifier.dart';


class ProjectWidget extends StatelessWidget {
  final Object? tag;
  final ProjectModelData? data;
  final double? width;
  final bool? isScale;
  const ProjectWidget({
    super.key,
    this.tag,
    this.data,
    this.width,
    this.isScale,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: context.height * 0.25,
      alignment: Alignment.bottomCenter,
      decoration: AppDecoration.decoration(
        color: AppColor.lightGray,
        shadow: true,
        cover: true,
        image:
            data == null
                ? null
                : AppCashImage.background(
                  imageUrl: UrlUtils().getImageUrl(data!.imageUrl),
                ).backgroundProvider,
      ),
      child: Container(
        alignment: Alignment.center,
        height: 60.h,
        child: AppText(
          text: data == null ? "" : data!.name ?? '',
          fontWeight: FontWeight.bold,
          fontSize: AppSize.bodyText,
          color: AppColor.white,
        ),
      ).withGlass(
        color: AppColor.mainColor.resolveOpacity(0.25),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10.r),
          bottomRight: Radius.circular(10.r),
        ),
      ),
    );
  }
}
