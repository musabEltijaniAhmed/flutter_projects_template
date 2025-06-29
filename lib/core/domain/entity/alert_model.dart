import 'dart:async';

import 'package:flutter/cupertino.dart';

/// Animation Type
enum AnimType {
  scale,
  rotate,
  slideInDown,
  slideInUp,
  slideInLeft,
  slideInRight,
}

/// Alert Type
enum AlertType {
  success,
  error,
  warning,
  confirm,
  info,
  loading,
  custom,
}

/// Alert Options
class AlertOptions {
  String? title;
  String? message;
  TextAlign? titleAlignment;
  TextAlign? textAlignment;
  Widget? child;
  AlertType type;
  AnimType? animType;
  bool? barrierDismissible = false;
  VoidCallback? onConfirmBtnTap;
  VoidCallback? onCancelBtnTap;
  String? confirmBtnText;
  String? cancelBtnText;
  Color? confirmBtnColor;
  TextStyle? confirmBtnTextStyle;
  TextStyle? cancelBtnTextStyle;
  Color? backgroundColor;
  Color? headerBackgroundColor;
  Color? titleColor;
  Color? textColor;
  bool? showCancelBtn;
  bool? showConfirmBtn;
  double? borderRadius;
  String? customAsset;
  double? width;
  Timer? timer;
  AlertOptions({
    this.title,
    this.message,
    this.titleAlignment,
    this.textAlignment,
    this.child,
    required this.type,
    this.animType,
    this.barrierDismissible,
    this.onConfirmBtnTap,
    this.onCancelBtnTap,
    this.confirmBtnText,
    this.cancelBtnText,
    this.confirmBtnColor,
    this.confirmBtnTextStyle,
    this.cancelBtnTextStyle,
    this.backgroundColor,
    this.headerBackgroundColor,
    this.titleColor,
    this.textColor,
    this.showCancelBtn,
    this.showConfirmBtn,
    this.borderRadius,
    this.customAsset,
    this.width,
    this.timer,
  });
}