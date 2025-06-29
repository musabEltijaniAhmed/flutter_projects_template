import 'dart:convert';

import 'package:flutter_project_template/core/shared/class_shared_import.dart';
import 'package:flutter_project_template/core/util/print_info.dart';

/// A utility class that provides static methods to interact with SharedPreferences.
///
/// This class is stateless and does not require instantiation or state management.
/// It is designed to be used directly via its static methods, making it convenient
/// for saving, retrieving, and clearing shared data like tokens and notifications.

class SharedPreferencesService {
  ///mack class singleton

  static Future<void> saveToken(String userToken) async {
    final prefs = await SharedPreferences.getInstance();
    final x = await prefs.setString(AppConstants.tokenKey, userToken);
    printInfo('saved token: $x');
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConstants.tokenKey);
  }

  static Future<void> saveUserData(Map<String, dynamic> user) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = json.encode(user);
    final success = await prefs.setString(AppConstants.userDataKey, userJson);
    printInfo('Saved user data: $success');
  }

  /*
  static Future<User?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(AppConstants.userDataKey);
    if (userJson == null) return null;
    final Map<String, dynamic> userMap = json.decode(userJson);
    printInfo('user data: $userMap');
    return User.fromJson(userMap);
  }
  */
  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstants.tokenKey);
    await prefs.remove(AppConstants.userDataKey);
    try {
      //  await FirebaseMessaging.instance.deleteToken();
    } catch (e) {
      printInfo('Error deleting token: $e');
    }
    printInfo('deleting token: true');
  }

  ///get notification when app in background===========================================================================
  static Future<Map<String, dynamic>> getRemoteMessage() async {
    final prefs = await SharedPreferences.getInstance();

    /// background handler run in a different isolate so,
    /// when you try to get a data, the shared preferences instance is empty.
    /// To avoid this you simply have to force a refresh:
    await prefs.reload();
    final String? value = prefs.getString(AppConstants.remoteMessage);
    final Map<String, dynamic> re =
        value == null ? {'type': '', 'message': ''} : json.decode(value);
    printInfo('getRemoteMessage:$re');
    return re;
  }

  ///save  Remote Message when app in background==========================================================================
  static Future<void> setRemoteMessage({
    required String message,
    bool? isForegroundMessage,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    final Map<String, dynamic> value = {
      'type': isForegroundMessage == true ? 'foreground' : 'background',
      'message': message,
    };
    final bool result = await prefs.setString(
      AppConstants.remoteMessage,
      json.encode(value),
    );
    printInfo('setRemoteMessage: $result - result: ${json.encode(value)}');
  }

  ///remove SharedPreferences ================================================================================================
  static Future<void> removePreferences({required String key}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    // final bool de = await prefs.remove(key);
    // printInfo('remove key $key $de');
  }

  ///save message type when app in terminate==================================================================================
  static Future<void> setTerminateNotification({
    required bool isTerminate,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    final bool value = await prefs.setBool(
      AppConstants.isTerminateNotification,
      isTerminate,
    );
    printInfo('isTerminate: $isTerminate, value is: $value');
  }

  ///get message type when app in terminate===================================================================================
  static Future<bool?> isTerminateNotification() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    final bool? value = prefs.getBool(AppConstants.isTerminateNotification);
    printInfo('isTerminateNotification is: $value');
    return value;
  }

  static Future<void> saveCompleteOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    final x = await prefs.setString(
      AppConstants.onboardingKey,
      AppConstants.onboardingValue,
    );
    printInfo('save ShowOnboarding Status: $x');
  }

  static Future<bool> isUserCompleteOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    final String? value = prefs.getString(AppConstants.onboardingKey);
    printInfo('get ShowOnboarding Status: $value');
    return value == AppConstants.onboardingValue;
  }
}
