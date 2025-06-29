import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';

import '../../constants/app_constants.dart';
import '../../util/print_info.dart';
import '../shared_preferences_service.dart';

class HandelNotifications {
  ///make class singleton
  static final HandelNotifications _instance = HandelNotifications._internal();
  factory HandelNotifications() => _instance;
  HandelNotifications._internal();

  ///handel foreground message=============================================================================================================================
  Future<void> foregroundNotifications() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      // offersState offersVariable =
      // ProviderScope.containerOf(context).read(offersProvider);

      ///remove notification data
      /// when app open from is terminal and then receive notification
      /// if we don't do that the page(that user must navigate to)
      /// will open automatically when receive notification
      await SharedPreferencesService.removePreferences(
        key: AppConstants.isTerminateNotification,
      );

      ///update ui
      _updateUiBaseOnNotificationType(message.data);

      ///don't show notification when user open offers page
      ///don't put showNotification in refreshUi
      //if (offersVariable.openOffersPage != true) {
      //await LocalNotificationServices.showNotification(message);
      //}
    });
  }

  ///when notifications is new offers================================================================================================
  Future<void> _updateUiBaseOnNotificationType(
    Map<String, dynamic> notificationData,
  ) async {
    ///hande offers notification
    //if (notificationData['type'] == AppConstants.offersType) {
    printInfo('notificationData: $notificationData');
    // offersNotifier offerMethods =
    // ProviderScope.containerOf(context).read(offersProvider.notifier);

    // offerMethods.getOffers(
    //   cargoId: int.parse(notificationData['cargo_id']),
    //   showLoad: false,
    // );
    //}

    ///remove saved message from background state after update data
    await SharedPreferencesService.removePreferences(
      key: AppConstants.remoteMessage,
    );
  }

  ///============================================================================================================================
  ///call this function for handel background message
  ///using for update ui when app in background

  Future<void> refreshUi() async {
    ///remove data when app open from terminal and then receive notification
    await SharedPreferencesService.removePreferences(
      key: AppConstants.isTerminateNotification,
    );

    Map<String, dynamic> remoteMessage =
        await SharedPreferencesService.getRemoteMessage();

    ///update data only when app in background
    if (remoteMessage['type'] == 'background') {
      ///update offer page
      _updateUiBaseOnNotificationType(json.decode(remoteMessage['message']));
    }
  }
}
