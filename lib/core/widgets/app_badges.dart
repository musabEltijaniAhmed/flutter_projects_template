import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:matryal_seller/core/shared/class_shared_import.dart';

class AppBadge extends StatelessWidget {
  final Widget child;

  final int badgeCount;
  const AppBadge({super.key, required this.child, required this.badgeCount});

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      showBadge: badgeCount == 0 ? false : true,
      position: badges.BadgePosition.topEnd(top: -2.spMin, end: 24.spMin),
      badgeContent: AppText(
        text: badgeCount >= 100 ? '99+' : badgeCount.toString(),
        fontSize: AppSize.smallText,
        color: Colors.white,
        align: TextAlign.center,
        fontWeight: FontWeight.bold,
      ),
      badgeStyle: badges.BadgeStyle(
        badgeColor: AppColor.mainColor,
        shape: badges.BadgeShape.square,
        borderRadius: BorderRadius.circular(12.spMin),
        padding: EdgeInsets.only(left: 10.spMin, right: 10.spMin, top: 2.spMin),
      ),

      ///stop animation
      badgeAnimation: const badges.BadgeAnimation.fade(
        animationDuration: Duration(), // Set duration to zero
      ),
      child: child,
    );
  }
}
