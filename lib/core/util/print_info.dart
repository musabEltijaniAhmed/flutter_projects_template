import 'dart:convert';
import 'package:flutter/foundation.dart';

void printInfo(
  dynamic value, {
  String? title,
  String? url,
  int? status,
  bool isError = false,
}) {
  if (!kDebugMode) return;

  final stackTrace = StackTrace.current.toString();
  final callerLine = stackTrace.split('\n')[1];
  final filePath =
      RegExp(r'package:.*').firstMatch(callerLine)?.group(0) ??
      '📁 مسار غير معروف';

  final buffer =
      StringBuffer()
        ..writeln((isError ? '❌' : '🔵') * 70)
        ..writeln('📄 Called from: $filePath');
  if (url != null) buffer.writeln('🌐 URL: $url');
  if (status != null) buffer.writeln('📥 Status: $status');
  if (title != null) buffer.writeln('📌 $title');

  final content = _formatValue(value);
  buffer.writeln(content);

  _printLong(buffer.toString(), isError: isError);
}

String _formatValue(dynamic value) {
  try {
    if (value is String) {
      final decoded = json.decode(value);
      return const JsonEncoder.withIndent('  ').convert(decoded);
    } else if (value is Map || value is List) {
      return const JsonEncoder.withIndent('  ').convert(value);
    }
  } catch (_) {
    // تنسيق السطور حتى لو لم يكن JSON
    return value.toString().split('\n').map((e) => '  $e').join('\n');
  }

  return value.toString();
}

void _printLong(String text, {int chunkSize = 800, required bool isError}) {
  final pattern = RegExp('.{1,$chunkSize}', dotAll: true);
  for (final match in pattern.allMatches(text)) {
    debugPrint(match.group(0));
  }
  debugPrint((isError ? '❌' : '🔵') * 70);
}
