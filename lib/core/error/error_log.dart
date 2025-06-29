import 'dart:io';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

Future<void> errorLog(
  dynamic error,
  StackTrace stackTrace, {
  bool fatal = false,
}) async {
  final deviceInfo = {
    'platform': Platform.operatingSystem,
    'version': Platform.operatingSystemVersion,
    'locale': Platform.localeName,
  };
  if (!kDebugMode) {
    await FirebaseCrashlytics.instance.recordError(
      error,
      stackTrace,
      reason:
          '${fatal ? "Fatal" : "Non-fatal"} error of type ${error.runtimeType}',
      information: [
        'Device Info: $deviceInfo',
        'Error Type: ${error.runtimeType}',
      ],
      fatal: fatal,
    );
  }
}
