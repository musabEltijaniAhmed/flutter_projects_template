import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_project_template/core/constants/app_color.dart';
import 'package:flutter_project_template/core/extensions/color_extensions.dart';
import 'package:flutter_project_template/core/extensions/context_extensions.dart';
import 'package:flutter_project_template/core/widgets/dialogs/quickalert_container.dart';

import '../../constants/app_string.dart';
import '../../domain/entity/alert_model.dart';
import 'Animate.dart';

/// QuickAlert
class Alert {
  /// Instantly display animated alert dialogs such as success, error, warning, confirm, loading or even a custom dialog.
  static Future<T?> show<T>({
    /// BuildContext
    required BuildContext context,

    /// Title of the dialog
    String? title,

    /// Text of the dialog
    String? message,

    /// TitleAlignment of the dialog
    TextAlign? titleAlignment,

    /// TextAlignment of the dialog
    TextAlign? textAlignment,

    /// Custom Widget of the dialog
    Widget? widget,

    /// Alert type [success, error, warning, confirm, info, loading, custom]
    required AlertType type,

    /// Animation type  [scale, rotate, slideInDown, slideInUp, slideInLeft, slideInRight]
    AnimType animType = AnimType.scale,

    /// Barrier Dismissible
    bool barrierDismissible = true,

    /// Triggered when confirm button is tapped
    VoidCallback? onConfirmBtnTap,

    /// Triggered when cancel button is tapped
    VoidCallback? onCancelBtnTap,

    /// Confirmation button text
    String? confirmBtnText,

    /// Cancel button text
    String? cancelBtnText,

    /// Color for confirm button
    Color confirmBtnColor = Colors.blue,

    /// TextStyle for confirm button
    TextStyle? confirmBtnTextStyle,

    /// TextStyle for cancel button
    TextStyle? cancelBtnTextStyle,

    /// Background Color for dialog
    Color backgroundColor = Colors.white,

    /// Header Background Color for dialog
    Color headerBackgroundColor = Colors.white,

    /// Color of title
    Color titleColor = Colors.black,

    /// Color of text
    Color textColor = Colors.black,

    /// Barrier Color of dialog
    Color? barrierColor,

    /// Determines if cancel button is shown or not
    bool showCancelBtn = false,

    /// Determines if confirm button is shown or not
    bool showConfirmBtn = true,

    /// Dialog Border Radius
    double borderRadius = 15.0,

    /// Asset path of your Image file
    String? customAsset,

    /// Width of the dialog
    double? width,

    /// Determines how long the dialog stays open for before closing, [default] is null. When it is null, it won't auto close
    Duration? autoCloseDuration,

    /// Disable Back Button
    bool disableBackBtn = false,
  }) {
    Timer? timer;
    if (autoCloseDuration != null) {
      timer = Timer(autoCloseDuration, () {
        Navigator.of(context, rootNavigator: true).pop();
      });
    }

    final options = AlertOptions(
      timer: timer,
      title: title,
      message: message,
      titleAlignment: titleAlignment,
      textAlignment: textAlignment,
      child: widget,
      type: type,
      animType: animType,
      barrierDismissible: barrierDismissible,
      onConfirmBtnTap: onConfirmBtnTap,
      onCancelBtnTap: onCancelBtnTap,
      confirmBtnText: confirmBtnText ?? AppMessage.okay,
      cancelBtnText: cancelBtnText ?? AppMessage.cancel,
      confirmBtnColor: confirmBtnColor,
      confirmBtnTextStyle: confirmBtnTextStyle,
      cancelBtnTextStyle: cancelBtnTextStyle,
      backgroundColor: backgroundColor,
      headerBackgroundColor: headerBackgroundColor,
      titleColor: titleColor,
      textColor: textColor,
      showCancelBtn: showCancelBtn,
      showConfirmBtn: showConfirmBtn,
      borderRadius: borderRadius,
      customAsset: customAsset,
      width: width,
    );

    Widget child = WillPopScope(
      onWillPop: () async {
        options.timer?.cancel();
        if (options.type == AlertType.loading &&
            !disableBackBtn &&
            showCancelBtn) {
          if (options.onCancelBtnTap != null) {
            options.onCancelBtnTap!();
            return false;
          }
        }
        return !disableBackBtn;
      },
      child: AlertDialog(
        backgroundColor: AppColor.noColor,
        contentPadding:
            context.isLargeScreen
                ? EdgeInsets.symmetric(horizontal: 80.w)
                : EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        content: QuickAlertContainer(options: options),
      ),
    );

    if (options.type != AlertType.loading) {
      child = RawKeyboardListener(
        focusNode: FocusNode(),
        autofocus: true,
        onKey: (event) {
          if (event is RawKeyUpEvent &&
              event.logicalKey == LogicalKeyboardKey.enter) {
            options.timer?.cancel();
            options.onConfirmBtnTap != null
                ? options.onConfirmBtnTap!()
                : Navigator.pop(context);
          }
        },
        child: child,
      );
    }

    return showGeneralDialog<T>(
      barrierColor: barrierColor ?? Colors.black.resolveOpacity(0.5),
      transitionBuilder: (context, anim1, __, widget) {
        switch (animType) {
          case AnimType.scale:
            return Animate.scale(child: child, animation: anim1);

          case AnimType.rotate:
            return Animate.rotate(child: child, animation: anim1);

          case AnimType.slideInDown:
            return Animate.slideInDown(child: child, animation: anim1);

          case AnimType.slideInUp:
            return Animate.slideInUp(child: child, animation: anim1);

          case AnimType.slideInLeft:
            return Animate.slideInLeft(child: child, animation: anim1);

          case AnimType.slideInRight:
            return Animate.slideInRight(child: child, animation: anim1);
        }
      },
      barrierDismissible:
          autoCloseDuration != null ? false : barrierDismissible,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, _, __) => Container(),
    );
  }

  static bool _isCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  static void dismissDialog(BuildContext context) {
    if (_isCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }
}
