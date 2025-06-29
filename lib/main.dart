import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_template/core/error/error_log.dart';
import 'package:flutter_project_template/core/shared/class_shared_import.dart';
import 'app/app.dart';

void main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await EasyLocalization.ensureInitialized();
      WidgetsFlutterBinding.ensureInitialized();
      await ScreenUtil.ensureScreenSize();

      /// Allow only portrait mode
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

      runApp(
        EasyLocalization(
          supportedLocales: const [Locale('en'), Locale('ar')],
          path: 'assets/translations',
          fallbackLocale: const Locale('ar'),
          startLocale: const Locale('ar'),
          child: const ProviderScope(child: MyApp()),
        ),
      );
    },

    ///async/Future/Timer/Streams
    errorLog,
  );
}
