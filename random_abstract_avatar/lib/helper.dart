import 'dart:math';

import 'package:flutter/widgets.dart';

extension ColorExtension on Color {
  /// Returns a new [Color], darkened by [val] for every RGB value.
  /// Clamp values to 0-255.
  Color darker(int val) => withBlue((blue - val).clamp(0, 255))
      .withGreen((green - val).clamp(0, 255))
      .withRed((red - val).clamp(0, 255));

  /// Faster version of [Color.computeLuminance].
  double fastLuminance() =>
      (0.2126 * red + 0.7152 * green + 0.0722 * blue) / 255;
}

extension ListExtension<T> on List<T> {
  /// Returns a random element from the list.
  T random() => this[Random.secure().nextInt(length)];
}
