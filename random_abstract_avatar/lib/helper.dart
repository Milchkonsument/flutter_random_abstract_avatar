import 'package:flutter/widgets.dart';

extension ColorExtension on Color {
  Color darker(int val) => withBlue((blue - val).clamp(0, 255))
      .withGreen((green - val).clamp(0, 255))
      .withRed((red - val).clamp(0, 255));

  double fastLuminance() =>
      (0.2126 * red + 0.7152 * green + 0.0722 * blue) / 255;
}
