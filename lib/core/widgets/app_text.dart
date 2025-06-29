import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_project_template/core/constants/app_color.dart';
import 'package:flutter_project_template/core/constants/app_size.dart';
import 'package:flutter_project_template/core/extensions/context_extensions.dart';

class AppText extends StatelessWidget {
  final String text;
  final TextAlign? align;
  final Color? color;
  final TextOverflow? overflow;
  final String? fontFamily;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextDecoration? textDecoration;
  final double? textHeight;
  final List<Shadow>? shadow;
  final TextDirection? textDirection;
  final bool? softWrap;
  final int? maxLine;
  const AppText({
    super.key,
    required this.text,
    this.align,
    this.color,
    this.overflow,
    this.fontSize,
    this.fontWeight,
    this.textDecoration,
    this.textHeight,
    this.shadow,
    this.textDirection,
    this.softWrap,
    this.fontFamily,
    this.maxLine,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      textDirection: textDirection,
      softWrap: softWrap,
      maxLines: maxLine,
      overflow: overflow,
      style: GoogleFonts.almarai(
        fontSize: fontSize ?? AppSize.captionText,
        fontWeight: fontWeight,
        color: color ?? AppColor.textColor,
        decoration: textDecoration,
        decorationColor: AppColor.lightGray,
        height: textHeight,
        shadows: shadow,
      ),
    );
  }
}

/// This function prints debug information such as the file path and the text passed in, but only in debug mode.
// void printInfo(String text) {
//   if (kDebugMode) {
//     var stackTrace = StackTrace.current.toString();
//
//     // Extract the file path correctly
//     var path = stackTrace.split('\n')[1];
//     var regExp = RegExp(r'package:[^:]+:\d+');
//     var match = regExp.firstMatch(path);
//     var filePath = match?.group(0) ?? 'مسار غير معروف';
//
//     debugPrint(
//       '==================================================================\n',
//     );
//     debugPrint('Called from: $filePath');
//     debugPrint(text);
//     debugPrint(
//       '==================================================================\n',
//     );
//   }
// }
