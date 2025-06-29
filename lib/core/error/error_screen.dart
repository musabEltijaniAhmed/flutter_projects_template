import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:matryal_seller/core/shared/class_shared_import.dart';

import '../widgets/app_decoration.dart';

class ErrorScreen extends StatelessWidget {
  final FlutterErrorDetails errorDetails;
  const ErrorScreen(this.errorDetails, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: AppHelpers.scrollList(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 30.h),
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
              decoration: AppDecoration.decoration(),
              child: AppText(
                text:
                    kDebugMode
                        ? 'خطأ في التطبيق:\n\n${errorDetails.exceptionAsString()}'
                        : AppMessage.formatText,

                fontWeight: FontWeight.bold,

                align: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
