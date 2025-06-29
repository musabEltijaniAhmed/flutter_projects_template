import 'package:matryal_seller/app/app.dart';
 
class NotificationRouter {
  static void navigateFromPayload({required Map<String, dynamic> payload}) {
    final navigator = myNavigatorKey.currentState;
    //final page = getRoute(payload['type']);

    /* navigator?.pushNamedAndRemoveUntil(
      page,

      ///we using this if we wont to navigate to page on nav bar
      ///replace "order" with your page name in nav bar
      (route) => payload['type'] == 'order' ? false : route.isFirst,
      arguments: payload,
    );
    */
  }

  /*
  static String getRoute(String type) {
    switch (type) {
      case 'order':
        return RoutesNames.login;
      case 'chat':
        return RoutesNames.splashScreen;
      default:
        return RoutesNames.home;
    }
  }*/
}
