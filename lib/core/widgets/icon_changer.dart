import 'package:flutter/services.dart';
import 'package:matryal_seller/core/util/print_info.dart';



class IconChanger {
  static const MethodChannel _channel = MethodChannel('icon_channel');

  static Future<void> changeIcon(String aliasName) async {
    try {
      _channel.invokeMethod('changeIcon', {'aliasName': aliasName});
    } on PlatformException catch (e) {
      printInfo("Failed to change app icon: ${e.toString()}");
    } catch (e) {
      printInfo("Failed to change app icon: ${e.toString()}");
    }
  }
}
