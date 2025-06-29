import 'package:flutter/material.dart';
import 'package:matryal_seller/core/shared/class_shared_import.dart';

class AppPopUpMenu extends StatelessWidget {
  final List<String> menuList;
  final Widget? icon;
  final PopupMenuPosition? position;
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry? padding;
  final Function(String)? onSelected;

  const AppPopUpMenu({
    super.key,
    required this.menuList,
    this.icon,
    this.constraints,
    this.position,
    this.padding,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      surfaceTintColor: AppColor.white,
      color: AppColor.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0.spMin),
      ),
      icon: icon,
      padding: padding ?? EdgeInsets.zero,
      position: position ?? PopupMenuPosition.over,
      constraints: constraints,
      onSelected: onSelected,
      itemBuilder:
          (context) =>
              menuList
                  .map(
                    (item) => PopupMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: TextStyle(color: Colors.black, fontSize: 14.sp),
                      ),
                    ),
                  )
                  .toList(),
    );
  }
}
