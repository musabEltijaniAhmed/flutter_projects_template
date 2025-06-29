import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_template/core/error/error_log.dart';

import 'error_screen.dart';

void initGlobalErrorHandling() {
  ///1. Handle Flutter UI Errors
  ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
    return ErrorScreen(errorDetails);
  };

  ///Todo: un comment this in release
  ///Handle framework-level Flutter errors
  // FlutterError.onError = (FlutterErrorDetails details) {
  //   printInfo('${details.exception}', title: 'Flutter Error:', isError: true);
  //
  //   ///send error to crashlytics with context
  //   if (!kDebugMode) {
  //     errorLog(details, details.stack ?? StackTrace.current);
  //   }
  // };

  /// Handle Platform/System Errors
  ///like Native platform errors
  ///Memory issues
  ///Hardware-related failures
  ///fatal means the error kill app and must have high priority
  PlatformDispatcher.instance.onError = (error, stack) {
    errorLog(error, stack, fatal: true);
    return true;
  };
}
