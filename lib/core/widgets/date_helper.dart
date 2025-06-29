import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:matryal_seller/core/shared/class_shared_import.dart';
import 'package:matryal_seller/core/util/print_info.dart';

class DateUtilsHelper {
  static String convertStringDateToStringFormat({
    required String? dateString,
    required BuildContext context,
  }) {
    if (dateString == null || dateString.isEmpty) return '';

    try {
      final DateTime dateTime = DateTime.parse(dateString);

      final locale = EasyLocalization.of(context)?.locale.toString() ?? 'ar';

      initializeDateFormatting(locale);

      String formattedDate = DateFormat(
        'dd MMMM yyyy',
        locale,
      ).format(dateTime);

      if (locale.startsWith('ar')) {
        formattedDate = _convertToArabicNumbers(formattedDate);
      }

      return formattedDate;
    } catch (e) {
      return ''; // في حالة وجود خطأ في التحويل
    }
  }

  static String _convertToArabicNumbers(String input) {
    const western = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const eastern = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

    for (int i = 0; i < western.length; i++) {
      input = input.replaceAll(western[i], eastern[i]);
    }
    return input;
  }

  ///convert string to date==================================================
  static DateTime? convertStringToDate(
    BuildContext context,
    String dateString,
  ) {
    initializeDateFormatting(EasyLocalization.of(context)?.locale.toString());
    try {
      // Parse the string date into a DateTime object based on the specified locale
      final DateTime parsedDate = DateFormat.yMMMMd(
        EasyLocalization.of(context)?.locale.toString(),
      ).parse(dateString);

      return parsedDate;
    } catch (e) {
      printInfo('Error parsing date: $e');
      return null;
    }
  }

  ///convert date to string===========================================================================================
  static convertDateToString(
    DateTime? dateTime, {
    required BuildContext context,
  }) {
    initializeDateFormatting(EasyLocalization.of(context)?.locale.toString());
    final String formattedDate = DateFormat.yMMMMEEEEd(
      EasyLocalization.of(context)?.locale.toString(),
    ).format(dateTime!);
    return formattedDate;
  }
}
