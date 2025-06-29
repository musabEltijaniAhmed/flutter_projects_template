import 'package:awesome_drawer_bar/awesome_drawer_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_template/core/shared/class_shared_import.dart';

class AppDrawer extends StatelessWidget {
  final Widget mainScreen;
  const AppDrawer({super.key, required this.mainScreen});

  @override
  Widget build(BuildContext context) {
    return AwesomeDrawerBar(
      isRTL: context.isArabic ? true : false,
      type: StyleState.stack,
      borderRadius: 15.r,
      showShadow: true,
      disableOnCickOnMainScreen: true,
      angle: -0.0,
      menuScreen:
          const SizedBox(), //const DrawerBody(), change it to your drawer
      mainScreen: mainScreen,
    );
  }
}
