import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart' as p;
import 'notifications_routs.dart';
import 'package:flutter_project_template/core/shared/class_shared_import.dart';
import 'package:flutter_project_template/core/util/print_info.dart';

class InitializeNotification {
  static final FlutterLocalNotificationsPlugin _notification =
      FlutterLocalNotificationsPlugin();

  ///initialize local notification=========================================================================================================================
  static Future<void> initialize() async {
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await _notification.getNotificationAppLaunchDetails();

    const AndroidInitializationSettings initAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initIos = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initAndroid, iOS: initIos);

    ///handel on tap notification in terminate state
    ///when click notification this will be handel, we wont it only in terminal state,
    ///so we need to add anther term for chick if from terminal or not
    if (notificationAppLaunchDetails != null &&
        notificationAppLaunchDetails.didNotificationLaunchApp &&
        await SharedPreferencesService.isTerminateNotification() == true) {
      printInfo('${notificationAppLaunchDetails.didNotificationLaunchApp}');
      onTapNotificationTerminate(notificationAppLaunchDetails);
    }

    ///handel on tap notification in background and foreground state
    await _notification.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onTapNotificationForegroundBackground,
    );
  }

  ///request permission===================================================================================================================================
  static Future<bool> requestPermissions() async {
    bool result = false;
    if (Platform.isIOS) {
      printInfo('ios permeation: ${await p.Permission.notification.isGranted}');
      await _notification
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          _notification
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >();

      final bool? grantedNotificationPermission =
          await androidImplementation?.requestNotificationsPermission();

      result = grantedNotificationPermission ?? false;
    }
    return result;
  }

  ///check if notification permission enable or not=======================================================================================================
  static Future<bool> isAndroidPermissionGranted() async {
    bool granted = false;
    if (Platform.isAndroid) {
      granted =
          await _notification
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >()
              ?.areNotificationsEnabled() ??
          false;
    }
    return granted;
  }

  /// display notification===============================================================================================================================
  static showNotification(RemoteMessage message) async {
    try {
      const AndroidNotificationDetails android = AndroidNotificationDetails(
        'channel_id',
        'channel name',
        icon: '@mipmap/ic_launcher',
        channelDescription: 'channel description',
        importance: Importance.max,
        priority: Priority.high,
      );
      const DarwinNotificationDetails iOSPlatformChannelSpecifics =
          DarwinNotificationDetails(
            presentSound: true,
            presentBadge: true,
            presentAlert: true,
          );
      const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: android,
        iOS: iOSPlatformChannelSpecifics,
      );

      /// Update the iOS foreground notification ui options to allow
      if (Platform.isIOS) {
        await FirebaseMessaging.instance
            .setForegroundNotificationPresentationOptions(
              alert: true,
              badge: true,
              sound: true,
            );
      }
      printInfo('show notification: ${message.data}');

      /// heads up notifications.
      /// don't show hiding notification
      if (message.data['type'] != 'read') {
        await _notification.show(
          int.parse(message.data['cargo_id']),
          '${message.data['title']}',
          '${message.data['body']}',
          platformChannelSpecifics,
          payload: json.encode(message.data),
        );
      }
    } catch (e) {
      printInfo('Error in show notification: ${e.toString()}');
    }
  }

  ///remove one notification from status bar=============================================================================================================
  static void closeOneNotification({required int notificationId}) async {
    await _notification.cancel(notificationId);
    printInfo('notification removed successful');
  }

  ///remove all notification from status bar=============================================================================================================
  static void closeAllNotifications() async {
    await _notification.cancelAll();
    printInfo('all notifications removed');
  }

  ///handle on tab foreground-background message=========================================================================================================
  static void onTapNotificationForegroundBackground(
    NotificationResponse response,
  ) {
    printInfo('onTapNotificationForegroundBackground: ${response.payload}');
    if (response.payload != null) {
      final Map<String, dynamic> payload = json.decode(response.payload!);
      NotificationRouter.navigateFromPayload(payload: payload);
    }
  }

  ///handel on tap notification in terminate state=======================================================================================================
  static void onTapNotificationTerminate(
    NotificationAppLaunchDetails? notificationDetails,
  ) async {
    final Map<String, dynamic> data = json.decode(
      notificationDetails!.notificationResponse!.payload!,
    );
    if (data.isNotEmpty) {
      ///navigation after tree build, so context will be available
      ///and the also fix splash screen timer, must run splash screen first
      ///then go to route, so the time must be more than splash timer
      SharedPreferencesService.setTerminateNotification(isTerminate: false);
      Future.delayed(const Duration(seconds: AppConstants.splashTimer + 2), () {
        NotificationRouter.navigateFromPayload(payload: data);

        ///delete saved notification from terminal state after nave
        SharedPreferencesService.removePreferences(
          key: AppConstants.remoteMessage,
        );
      });
    }
  }

  ///handel on background message========================================================================================================================
  ///@pragma('vm:entry-point') use for indicate to the compiler that it will be used from native code(run dart code only).
  ///isolate method
  @pragma('vm:entry-point')
  static Future<void> onBackgroundMessage(RemoteMessage message) async {
    // await Firebase.initializeApp(
    //     options: DefaultFirebaseOptions.currentPlatform);
    await showNotification(message);
    printInfo('background message ${message.data}');

    ///We need to store the value of "true" in case the app is completely closed,
    /// but this function(onBackgroundMessage) is executed in case the app is in
    /// the background or closed as well,
    /// so we need to delete the value of the preference when the app is in the foreground
    /// or when the app is restarted (Resume).
    await SharedPreferencesService.setTerminateNotification(isTerminate: true);

    ///store message , using for update data and alert in main page
    ///first remove previous stored message then add new one
    await SharedPreferencesService.removePreferences(
      key: AppConstants.remoteMessage,
    );
    await SharedPreferencesService.setRemoteMessage(
      message: json.encode(message.data),
    );
  }

  ///get device token===============================================================================================================================
  static getDeviceToken() async {
    const token =
        "cmY_NPGGTwWau0fBmBoQyq:APA91bFGSg08Hx-UQ31WDJt3KEVooJ1UNIR8pIOsJyt8KWKwl-aPpc_MMQFeaaOoDBMjPBXFdcr1fcTMUirDCc__DOcmc_wXQBPKAcn2BeHcYVZ9K-QtWUg";
    try {
      return await FirebaseMessaging.instance.getToken();
    } catch (e) {
      printInfo('error getDeviceToken: ${e.toString()}');
      return token;
    }
  }
}
