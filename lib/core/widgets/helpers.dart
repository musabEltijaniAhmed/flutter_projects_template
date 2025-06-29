import 'package:flutter/material.dart';
import 'package:flutter_project_template/core/shared/class_shared_import.dart';
import 'package:flutter_project_template/core/widgets/app_decoration.dart';
import 'package:flutter_project_template/core/widgets/lottie_helper.dart';

import '../domain/entity/alert_model.dart';
import 'dialogs/quickalert_dialog.dart';

class AppHelpers {
  ///get core height===========================================================================================================================
  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height;

  ///get core width===================================================================================================================================
  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;

  ///return borderStyle==================================================================================================================================================
  static outlineInBorderStyle({
    bool? isFocus,
    Color? borderColor,
    double? borderThickness,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.r),
      borderSide: BorderSide(
        color: (borderColor ?? AppColor.textColor),
        width: borderThickness ?? 0.3,
      ),
    );
  }

  /// return TextStyle==================================================================================================================================================
  static TextStyle styleText({
    Color? color,
    TextOverflow? overflow,
    double? fontSize,
    FontWeight? fontWeight,
    TextDecoration? textDecoration,
    double? textHeight,
    List<Shadow>? shadow,
  }) {
    return TextStyle(
      color: color,
      overflow: overflow ?? TextOverflow.ellipsis,
      fontSize: fontSize,
      fontWeight: fontWeight,
      decoration: textDecoration,
      decorationColor: color,
      height: textHeight,
      shadows: shadow,
    );
  }

  ///return gradient for onboarding screens====================================================
  static getGradient() {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        AppColor.mainColor,
        AppColor.mainColor.resolveOpacity(0.5),
        AppColor.mainColor.resolveOpacity(0.05),
        AppColor.mainColor.resolveOpacity(0.02),
      ],
    );
  }

  ///scroll body=====================================================================================
  static Widget scrollList({
    required List<Widget> children,
    ScrollPhysics? physics,
    bool isHorizontal = false,
    ScrollController? controller,
    SliverAppBar? appBar,
  }) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowIndicator();
        return true;
      },
      child: CustomScrollView(
        controller: controller,
        scrollDirection: isHorizontal ? Axis.horizontal : Axis.vertical,
        physics: physics ?? const BouncingScrollPhysics(),
        slivers: [
          if (appBar != null) appBar,
          SliverList(delegate: SliverChildListDelegate(children)),
        ],
      ),
    );
  }

  //===========================================================================================
  static Future<void> ensureVisibleOnTextArea({required GlobalKey key}) async {
    final keyContext = key.currentContext;
    if (keyContext != null) {
      await Future.delayed(const Duration(milliseconds: 500)).then(
        (value) => Scrollable.ensureVisible(
          keyContext,
          duration: const Duration(milliseconds: 200),
          curve: Curves.decelerate,
        ),
      );
    }
  }

  static phonePrefix({required BuildContext context}) {
    return SizedBox(
      width: 60.w,
      child: AppText(
        text: context.locale.toString() == 'en' ? '+966' : '966+',
        fontSize: AppSize.captionText,
      ),
    );
  }

  static passPrefix({icon, onPressed}) {
    return IconButton(onPressed: onPressed, icon: Icon(icon));
  }

  ///lode check box list or radio button list data shape================================================================================
  static lodeWidgetCheckBoxOrRadio({required BuildContext context, listName}) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.only(right: 2.w, top: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h),
          AppText(
            text: listName,
            fontSize: AppSize.captionText,
            color: AppColor.black,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 10.h),
          getRowLode(context),
        ],
      ),
    );
  }

  static getRowLode(context, {int itemCount = 5}) {
    final double itemHeight = 22.h;
    final double itemWidth = width(context) * 0.24;
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.w,
      children: List.generate(itemCount, (_) {
        return Container(
          height: itemHeight,
          width: itemWidth,
          decoration: AppDecoration.decoration(
            shadow: false,
            radius: 20,
            color: AppColor.lightGray,
          ),
        );
      }),
    );
  }

  static dropListHandelWidget({required String listName, bool isLode = false}) {
    return Container(
      padding: EdgeInsets.only(top: 2.h),
      alignment: AlignmentDirectional.topStart,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: AppSize.screenWidth,
            padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
            decoration: AppDecoration.decoration(
              radius: 5,
              showBorder: true,
              borderColor: isLode ? AppColor.mediumGray : AppColor.red,
              shadow: false,
              borderWidth: 1.3,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  text:
                      '$listName${isLode ? '' : " : ${AppMessage.listError}"}',
                  fontSize: AppSize.captionText,
                ),
                isLode
                    ? SizedBox(
                      width: 20.spMin,
                      height: 20.spMin,
                      child: const CircularProgressIndicator(
                        strokeWidth: 1.9,
                        color: AppColor.subtextColor,
                      ),
                    )
                    : const SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static noDataWidgetCheckBoxOrRadio({
    required BuildContext context,
    required String listName,
  }) {
    return Container(
      padding: EdgeInsets.only(right: 2.w, top: 2.h),
      alignment: AlignmentDirectional.topStart,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: listName,
            fontSize: AppSize.captionText,
            color: AppColor.black,
            fontWeight: FontWeight.bold,
          ),
          AppText(
            text: "$listName ${AppMessage.noData}",
            fontSize: AppSize.captionText,
          ),
        ],
      ),
    );
  }

  static unAuthorize(BuildContext context) {
    Future.delayed(Duration.zero, () {
      /* AppRoutes.pushAndRemoveAllPageTo(
        context,
        const LoginScreen(showSnackBar: true),
        removeProviderData: true,
      );
      */
    });
    return const SizedBox();
  }

  //login require==================================================================================================================================================
  static loginRequire({required BuildContext context}) {
    Future.delayed(Duration.zero, () {
      /* Alert.show(
        disableBackBtn: true,
        context: context,
        barrierDismissible: false,
        type: AlertType.warning,
        title: AppMessage.requiredLogin,
        onConfirmBtnTap: () {
          AppRoutes.pushTo(context, const LoginScreen(isBack: true));
        },
      );
      */
    });
    return const SizedBox();
  }

  static Widget emptyData({String? message}) {
    return LottieHelper(lottiePath: Assets.lottieEmpty, message: message);
  }

  //auto Scroll list============================================================
  static autoScrollListView({
    required ScrollController scrollController,
    required int listLength,
    required int goToIndex,
  }) {
    final contentSize =
        scrollController.position.viewportDimension +
        scrollController.position.maxScrollExtent;

    final target = contentSize * goToIndex / listLength;
    scrollController.position.animateTo(
      target,
      curve: Curves.linear,
      duration: const Duration(milliseconds: 1200),
    );
  }

  static Widget imageError() {
    return Container(width: double.infinity, color: AppColor.lightGray);
  }

  //==============================================================
  static AssetImage placeholderImage({image}) {
    return AssetImage(image);
  }

  static placeholderCashNetwork({image, fit}) {
    return Image.asset(image, fit: fit ?? BoxFit.cover);
  }

  // Title===============================================================================================================
  static Widget buildTitle({
    required IconData icon,
    required String title,
    Color? iconColor,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: 10.spMin,

      leading: Icon(icon, color: iconColor, size: AppSize.iconSize),
      title: AppText(
        text: title,
        color: AppColor.black,
        fontSize: AppSize.heading2,
      ),
    );
  }

  //Backgounded Icon===============================================================================================================
  static Widget backgoundedIcon({
    required IconData icon,
    Color? iconColor,
    Color? backgroundColor,
    double? radius,
    double? width,
    double? height,
    double? iconSize,
  }) {
    return Container(
      width: width ?? AppSize.scale(35),
      height: height ?? AppSize.scale(35),
      decoration: AppDecoration.decoration(
        color: backgroundColor,
        shadow: false,
        borderRadius: BorderRadius.circular(radius ?? AppSize.buttonRadius),
      ),
      child: Icon(icon, color: iconColor, size: iconSize ?? AppSize.iconSize),
    );
  }

  //Circle Icon with background
  static Widget circleIconWithBackground({
    required IconData icon,
    required Color iconColor,
    required Color backgroundColor,
    double? iconSize,
    double? radius,
  }) {
    return SizedBox(
      width: AppSize.scale(radius ?? 35),
      height: AppSize.scale(radius ?? 35),
      child: DecoratedBox(
        decoration: AppDecoration.decoration(
          color: backgroundColor,
          isCircle: true,
          shadow: false,
        ),
        child: Icon(icon, color: iconColor, size: iconSize ?? AppSize.iconSize),
      ),
    );
  }
}
