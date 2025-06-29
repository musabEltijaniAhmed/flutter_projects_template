import 'package:flutter/material.dart';
import '../shared/class_shared_import.dart';
import 'package:matryal_seller/core/util/print_info.dart';
///Utility method for handling page transitions with optional animation

class AppRoutes {
  /// Push page with optional animation
  static void pushTo(
    BuildContext context,
    Widget page, {
    bool noAnimation = false,
  }) {
    final route =
        noAnimation
            ? MaterialPageRoute(builder: (_) => page)
            : _buildRoute(page);
    Navigator.push(context, route);
  }

  /// Push replacement page with optional animation
  static void pushReplacementTo(
    BuildContext context,
    Widget page, {
    bool noAnimation = false,
  }) {
    final route =
        noAnimation
            ? MaterialPageRoute(builder: (_) => page)
            : _buildRoute(page);

    Navigator.pushReplacement(context, route);
  }

  /// Push page and remove all previous routes with optional animation
  static void pushAndRemoveAllPageTo(
    BuildContext context,
    Widget page, {
    bool noAnimation = false,
    bool removeProviderData = false,
  }) {
    if (removeProviderData) {
      ///use this to remove provider data when user logout
      ///or when user authentication fails
      SharedPreferencesService.clearToken();
      ProviderScope.containerOf(context).invalidate(projectNotifier);

      printInfo('Provider data deleted');
    }

    final route =
        noAnimation
            ? MaterialPageRoute(builder: (_) => page)
            : _buildRoute(page);

    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  /// Private method to build route with animation
  static PageRouteBuilder _buildRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.linear;

        final tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }
}
