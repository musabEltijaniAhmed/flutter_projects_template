import 'package:flutter/material.dart';

class AppToolTip extends StatelessWidget {
  final String message;
  final Widget child;
  const AppToolTip({super.key, required this.message, required this.child});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      triggerMode: TooltipTriggerMode.tap,
      child: child,
    );
  }
}
