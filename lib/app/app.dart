import 'package:flutter/material.dart';
import 'package:flutter_project_template/core/error/error_hander_type.dart';
import 'package:flutter_project_template/core/extensions/context_extensions.dart';
import 'package:flutter_project_template/core/services/notifications/handel_notifications.dart';
import 'package:flutter_project_template/core/shared/class_shared_import.dart';
import 'package:flutter_project_template/core/themes/app_them.dart';
import 'package:flutter_project_template/core/routing/route_paths.dart';

GlobalKey<NavigatorState> myNavigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    ///initialize global error handling
    initGlobalErrorHandling();

    ///handel foreground notification
    HandelNotifications().foregroundNotifications();

    ///refresh UI when app is resume when receive background message
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      HandelNotifications().refreshUi();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),

      minTextAdapt: true,
      splitScreenMode: true,
      builder:
          (_, __) => MaterialApp(
            initialRoute: RoutesNames.splashScreen,
            navigatorKey: myNavigatorKey,
            debugShowCheckedModeBanner: false,
            locale: context.locale,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            theme: AppThem().getAppThem(),
            routes: RoutesNames().routs,
            builder: (context, child) {
              if (context.isIOS) {
                return GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: child,
                );
              }
              return child!;
            },
          ),
    );
  }
}
