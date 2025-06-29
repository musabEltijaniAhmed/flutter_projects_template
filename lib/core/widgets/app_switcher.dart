import 'package:flutter/material.dart';
import 'package:flutter_project_template/core/shared/class_shared_import.dart';

class AppSwitcher extends StatelessWidget {
  final double? size;
  final void Function(bool) onChanged;
  final bool value;
  const AppSwitcher({
    super.key,
    required this.onChanged,
    required this.value,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: size ?? 0.85,
      child: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppColor.green,
        activeTrackColor: AppColor.lightGreen,
        inactiveThumbColor: AppColor.black.resolveOpacity(0.3),
        inactiveTrackColor: AppColor.black.resolveOpacity(0.1),
        thumbColor: WidgetStateColor.resolveWith((states) => AppColor.white),
        trackOutlineColor: WidgetStateColor.resolveWith(
          (states) => AppColor.noColor,
        ),
      ),
    );
  }
}
