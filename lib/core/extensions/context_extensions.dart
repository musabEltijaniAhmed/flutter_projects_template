import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matryal_seller/core/services/language_service.dart';

extension BuildContextValue on BuildContext {
  // media query from presentation edges

  // presentation insets from presentation edges
  double get top => MediaQuery.of(this).padding.top;
  double get bottom => MediaQuery.of(this).padding.bottom;

  // orientation
  Orientation get orientation => MediaQuery.orientationOf(this);
  bool get isLandscape => orientation == Orientation.landscape;
  bool get isPortrait => orientation == Orientation.portrait;
  bool get isLargeScreen => 1.sw > 600;

  double get width =>
      isLandscape
          ? MediaQuery.sizeOf(this).height
          : MediaQuery.sizeOf(this).width;
  get unfocused => FocusManager.instance.primaryFocus?.unfocus();
  double get height =>
      isLandscape
          ? MediaQuery.sizeOf(this).width
          : MediaQuery.sizeOf(this).height;

  // platform
  bool get isAndroid => Platform.isAndroid;
  bool get isIOS => Platform.isIOS;
  bool get isFuchsia => Platform.isFuchsia;

  // is English local
  bool get isEnglish => LanguageService.getLang() == "en";
  bool get isArabic => LanguageService.getLang() == "ar";

  void unFocusOnTapOutSite(final PointerDownEvent event) {
    if (!FocusScope.of(this).hasPrimaryFocus && FocusScope.of(this).hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
