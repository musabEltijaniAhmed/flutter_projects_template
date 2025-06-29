import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_template/app/app.dart';

import '../constants/app_color.dart';
import '../constants/app_constants.dart';

class AppThem {
  ///singleton class for app theme
  static final AppThem _instance = AppThem._internal();
  factory AppThem() => _instance;
  AppThem._internal();
  getAppThem() {
    return ThemeData(
      dividerTheme: const DividerThemeData(
        color: AppColor.lightGray,
        thickness: 0.8,
      ),

      primaryColor: AppColor.mainColor,
      scaffoldBackgroundColor: AppColor.scaffoldColor,
      useMaterial3: true,
      fontFamily:
          myNavigatorKey.currentContext?.locale.toString() == 'ar'
              ? AppConstants.arabicFont
              : AppConstants.englishFont,
    );
  }
}
