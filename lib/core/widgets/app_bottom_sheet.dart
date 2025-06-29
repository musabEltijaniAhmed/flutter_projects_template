import 'package:flutter/material.dart';
import 'package:flutter_project_template/core/shared/class_shared_import.dart';
import 'package:flutter_project_template/core/widgets/app_decoration.dart';

class AppBottomSheet {
  static Future<T?> showBottomSheet<T>({
    required BuildContext context,
    required Widget child,
    bool? showCloseBar,
    required String title,
    bool enableDrag = false,
    bool isDismissible = false,
    bool showDragHandle = false,
    bool isScrollControlled = true,
    bool? showCloseBottom,
    String hint = '',
  }) {
    return showModalBottomSheet<T>(
      isScrollControlled: isScrollControlled,
      context: context,
      enableDrag: enableDrag,
      isDismissible: isDismissible,
      showDragHandle: showDragHandle,
      backgroundColor: AppColor.noColor,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      builder:
          (context) => WillPopScope(
            onWillPop: () async => false,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                decoration: AppDecoration.decoration(
                  radius: AppSize.cardRadius,
                ),
                width: double.infinity,
                padding: EdgeInsets.all(AppSize.defaultPadding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (showCloseBar == true) SizedBox(height: 25.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          text: title,
                          fontSize: AppSize.bodyText,
                          fontWeight: FontWeight.bold,
                        ),
                        //if (showCloseBottom == true)
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            AppIcons.closeSquare,
                            size: AppSize.iconSize,
                          ),
                        ),
                      ],
                    ),
                    if (hint.isNotEmpty) SizedBox(height: 10.h),
                    if (hint.isNotEmpty)
                      AppText(
                        text: hint,
                        fontSize: AppSize.smallText,
                        color: AppColor.mediumGray,
                      ),
                    SizedBox(height: 10.h),
                    child,
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
