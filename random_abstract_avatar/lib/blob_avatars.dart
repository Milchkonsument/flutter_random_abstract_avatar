import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:hashlib/hashlib.dart';

// ignore: must_be_immutable
class Avatar extends StatelessWidget {
  Avatar({
    required this.source,
    required this.coloring,
    this.layersCount = AvatarLayersCount.one,
    this.sourceSize = 64,
    this.borderRadius = 16,
    this.decoration,
    super.key,
  });

  /// Generation source for the avatar. Usually a username or email.
  final String source;
  Uint8List? _cache;
  final AvatarLayersCount layersCount;
  final AvatarColoring coloring;
  final double sourceSize;
  final double borderRadius;
  final BoxDecoration? decoration;

  Future<Uint8List> _generateImageBytedata(String s) async {
    final hash = xxh128sum(s);
    final partSize = (hash.length / layersCount.value).floor();

    final layerHashsums = List.generate(layersCount.value,
            (i) => hash.substring(i * partSize, i * partSize + partSize))
        .map(xxh128sum)
        .toList();

    final sourceRect = Rect.fromLTWH(
      0,
      0,
      sourceSize,
      sourceSize,
    );

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder, sourceRect);

    final bgPaint = Paint()
      ..color = coloring.backgroundColor
      ..style = PaintingStyle.fill;

    canvas.drawRect(sourceRect, bgPaint);

    for (var i = layerHashsums.length - 1; i >= 0; i--) {
      final hash = layerHashsums[i];
      // final scale = (i + 1 / layerHashsums.length - 1);
      final paint = Paint()
        ..color = (switch (i) {
          // foreground
          0 => coloring.foregroundColor,
          // first layer
          1 => coloring.firstLayerColor,
          // second layer
          _ => coloring.secondLayerColor,
        })
        ..style = PaintingStyle.fill;

      for (var k = 0; k < 4; k++) {
        final off = k * 6;
        const offset = 0.4;

        final offsetX = int.parse(hash.substring(off, off + 2), radix: 16) /
            255 *
            sourceSize *
            offset;
        final circleSize =
            int.parse(hash.substring(off + 4, off + 6), radix: 16) /
                255 *
                sourceSize *
                0.2;

        final offsetY = int.parse(hash.substring(off + 7, off + 9), radix: 16) /
            255 *
            sourceSize *
            offset;

        canvas.drawCircle(Offset(offsetX, offsetY), circleSize, paint);
        canvas.drawCircle(Offset(sourceSize - offsetX, sourceSize - offsetY),
            circleSize, paint);
        canvas.drawCircle(
            Offset(offsetX, sourceSize - offsetY), circleSize, paint);
        canvas.drawCircle(
            Offset(sourceSize - offsetX, offsetY), circleSize, paint);
      }
    }

    final picture = recorder.endRecording();
    final img = picture.toImageSync(sourceSize.toInt(), sourceSize.toInt());
    final bytedata = (await img.toByteData(format: ui.ImageByteFormat.png))!;

    return bytedata.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) => Container(
      decoration: decoration?.copyWith(
          borderRadius: BorderRadius.circular(borderRadius)),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: FutureBuilder(
              future: Future(
                  () async => _cache ??= await _generateImageBytedata(source)),
              builder: (c, snap) {
                if (snap.hasData && snap.data != null) {
                  return Image.memory(
                    snap.data!,
                    height: sourceSize,
                    width: sourceSize,
                  );
                }

                if (snap.hasError) {
                  return Text(snap.error.toString());
                }

                return ClipRRect(
                    borderRadius: BorderRadius.circular(borderRadius),
                    child: Container(color: coloring.backgroundColor));
              })));
}

class AvatarColoring {
  /// Defines the coloring used to generate the avatar.
  ///
  /// _[firstLayerColor] and [secondLayerColor] are optional
  /// and will be used only if [layersType]
  /// is set to [AvatarLayersCount.two] or [AvatarLayersCount.three] respectively._
  ///
  /// __See also:__
  /// * [AvatarColoring.fromThemedata]
  /// * [AvatarColoring.fromThemedataOnTransparent]
  /// * [AvatarColoring.fromContext].
  const AvatarColoring._({
    required this.foregroundColor,
    required this.backgroundColor,
    required this.firstLayerColor,
    required this.secondLayerColor,
  });

  factory AvatarColoring.fromColors({
    required Color foregroundColor,
    required Color backgroundColor,
    Color? firstLayerColor,
    Color? secondLayerColor,
  }) {
    return AvatarColoring._(
      foregroundColor: foregroundColor,
      backgroundColor: backgroundColor,
      firstLayerColor: firstLayerColor ??
          Color.lerp(foregroundColor, backgroundColor, 0.33)!,
      secondLayerColor: secondLayerColor ??
          Color.lerp(foregroundColor, backgroundColor, 0.66)!,
    );
  }

  /// Generates coloring based on current theme.
  factory AvatarColoring.fromThemedata(ThemeData theme) {
    return AvatarColoring._(
      foregroundColor: theme.colorScheme.primary,
      firstLayerColor: theme.colorScheme.secondary,
      secondLayerColor: theme.colorScheme.tertiary,
      backgroundColor: theme.colorScheme.background,
    );
  }

  /// Generates coloring based on current theme, with transparent background.
  factory AvatarColoring.fromThemedataOnTransparent(ThemeData theme) {
    return AvatarColoring._(
      foregroundColor: theme.colorScheme.primary,
      firstLayerColor: theme.colorScheme.secondary,
      secondLayerColor: theme.colorScheme.tertiary,
      backgroundColor: Colors.transparent,
    );
  }

  /// Generates coloring based on current build context.
  factory AvatarColoring.fromContext(BuildContext context) {
    return AvatarColoring.fromThemedata(Theme.of(context));
  }

  /// Generates coloring based on current build context, with transparent background.
  factory AvatarColoring.fromContextOnTransparent(BuildContext context) {
    return AvatarColoring.fromThemedataOnTransparent(Theme.of(context));
  }

  final Color foregroundColor;
  final Color backgroundColor;
  final Color firstLayerColor;
  final Color secondLayerColor;
}

/// Defines the number of layers the avatar is made up of.
enum AvatarLayersCount {
  one._(1),
  two._(2),
  three._(3);

  const AvatarLayersCount._(this.value);

  final int value;
}
