import 'dart:ui';

extension ColorWithOpacityExt on Color {
  /// Extension on [Color] to resolve opacity based on a [double] value.
  /// The opacity is expected to be between 0.0 (fully transparent) and
  /// 1.0 (fully opaque).
  /// Returns a new color with the applied opacity.
  Color resolveOpacity(double opacity) {
    opacity = opacity.clamp(0.0, 1.0);
    final int alpha = (opacity * 255).round();
    return withAlpha(alpha);
  }
}

extension HexColorExtension on String {
  Color toColor() {
    final buffer = StringBuffer();
    if (length == 6 || length == 7) buffer.write('ff');
    buffer.write(replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
