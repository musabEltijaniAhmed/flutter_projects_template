// import 'package.svg:flutter/cupertino.dart';
// import 'package.svg:flutter_screenutil/flutter_screenutil.dart';
// import 'app_color.dart';
// import 'helpers.dart';
//
//
// class AppCounter extends StatelessWidget {
//   final void Function(double) onChanged;
//   final double? min;
//   final double? max;
//   final double value;
//   final BoxDecoration? decoration;
//   final bool ?readOnly;
//   const AppCounter(
//       {super.key,
//         required this.value,
//         required this.onChanged,
//         this.min,
//         this.max,
//         this.decoration,   this.readOnly});
//
//   @override
//   Widget build(BuildContext context) {
//     return CupertinoSpinBox(
//       padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 0),
//       decoration: decoration ??
//           GeneralWidget.decoration(
//               showBorder: true, borderColor: AppColor.darkGrey, shadow: false),
//       decrementIcon: Icon(
//         CupertinoIcons.minus_circle_fill,
//         color: value == min ? AppColor.lightGrey : AppColor.mainColor,
//       ),
//       incrementIcon: Icon(
//         CupertinoIcons.plus_circle_fill,
//         color: value == max ? AppColor.lightGrey : AppColor.mainColor,
//       ),
//       min: min ?? 1,
//       max: max ?? 100,
//       value: value,
//       readOnly:readOnly ??true,
//       onChanged: onChanged,textStyle: TextStyle(
//       color: AppColor.textColor,
//     ),
//     );
//   }
// }