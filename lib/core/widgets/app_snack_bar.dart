import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/app.dart';

class AppSnackBar {
  AppSnackBar._(); // Private constructor to prevent instantiation

  static void show({
    required String message,
    required bool isSuccessful,
    Duration duration = const Duration(seconds: 2),
    double bottomPadding = 20.0,
  }) {
    final context = myNavigatorKey.currentContext;
    if (context == null) return;

    final snackBar = SnackBar(
      content: _buildContent(message, isSuccessful),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(bottom: bottomPadding.h, left: 20.w, right: 20.w),
      backgroundColor: Colors.transparent,
      elevation: 0,
      duration: duration,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Widget _buildContent(String message, bool isSuccessful) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: isSuccessful ? Colors.green : Colors.red,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Icon(
            isSuccessful ? Icons.check_circle : Icons.error,
            color: Colors.white,
            size: 24.spMin,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.spMin,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }
}
