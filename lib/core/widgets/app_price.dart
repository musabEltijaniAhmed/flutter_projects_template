import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matryal_seller/core/constants/app_size.dart';

import 'app_text.dart';

class AppPrice extends StatelessWidget {
  final double? rsSize;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double price;
  final Color? color;
  const AppPrice({
    super.key,
    required this.price,
    this.rsSize,
    this.fontSize,
    this.fontWeight,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ///appText is custom widget for text
        ///you can use it instead of text widget
        ///or using text widget directly
        AppText(
          text: price.toString(),
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        ),

        ///this for arabic riyal symbol
        Text(
          '\u200A${String.fromCharCode(0xE900)}',
          style: TextStyle(
            fontSize: rsSize ?? AppSize.captionText,
            fontFamily: 'Saudi',
            color: color,
          ),
        ),
      ],
    );
  }
}
