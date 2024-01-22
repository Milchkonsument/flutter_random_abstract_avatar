import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:hashlib/hashlib.dart';
import 'package:random_abstract_avatar/helper.dart';

// ignore: must_be_immutable
class Avatar extends StatelessWidget {
  /// Creates a random avatar based on the provided [source].
  Avatar({
    required this.source,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius = 16,
    this.complexity = AvatarComplexity.complex,
    this.primitives = AvatarPrimitive.values,
    this.size = 64,
    this.decoration,
    super.key,
  }) {
    assert(primitives.isNotEmpty, 'list of primitives cannot be empty');
  }

  /// Generation source for the avatar. Usually a username or email.
  final String source;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double size;
  final double borderRadius;

  /// List of geometric primtives that should be used for avatar generation.
  final List<AvatarPrimitive> primitives;

  /// Complexity of the avatar.
  ///
  /// The higher the complexity, the more layers will be drawn to the avatar.
  ///
  /// The higher the complexity, the longer it takes to generate the avatar,
  /// although the perfomance impact should not pose a problem either way.
  ///
  /// _It is recommended to use the default setting [complex] as it has the best_
  /// _results visually._
  final AvatarComplexity complexity;

  /// Decoration, in case you want to add a border, background image, or gradient.
  final BoxDecoration? decoration;

  // image data gets cached to prevent unnecessary regeneration.
  Uint8List? _cache;

  @override
  Widget build(BuildContext context) => Container(
      width: size,
      height: size,
      decoration: decoration?.copyWith(
          borderRadius: BorderRadius.circular(borderRadius)),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: FutureBuilder(
              future: Future(() async =>
                  _cache ??= await _generateImageBytedata(source, context)),
              builder: (c, snap) {
                if (snap.hasData && snap.data != null) {
                  return Image.memory(
                    snap.data!,
                    height: size,
                    width: size,
                  );
                }

                if (snap.hasError) {
                  return Text(snap.error.toString());
                }

                return Container(
                    color: backgroundColor ??
                        Color.lerp(Theme.of(context).colorScheme.background,
                            Theme.of(context).colorScheme.primary, 0.33)!);
              })));

  Future<Uint8List> _generateImageBytedata(
      String s, BuildContext context) async {
    final hash = sha256sum(s);
    final partSize = (hash.length / complexity.value).floor();

    final layerHashsums = List.generate(complexity.value,
            (i) => hash.substring(i * partSize, i * partSize + partSize))
        .map(sha256sum)
        .toList();

    final sourceRect = Rect.fromLTWH(
      0,
      0,
      size,
      size,
    );

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder, sourceRect);
    final background = backgroundColor ??
        Color.lerp(Theme.of(context).colorScheme.background,
            Theme.of(context).colorScheme.primary, 0.33)!;
    final foreground = foregroundColor ?? Theme.of(context).colorScheme.primary;

    final bgPaint = Paint()
      ..color = background
      ..style = PaintingStyle.fill
      ..strokeWidth = 0;

    canvas.drawRect(sourceRect, bgPaint);

    for (var i = layerHashsums.length - 1; i >= 0; i--) {
      final hash = layerHashsums[i];
      final paint = Paint()
        ..color = (switch (i) {
          0 => foreground,
          1 => foreground._darker(30),
          _ => foreground._darker(60),
        })
        ..style = PaintingStyle.fill;

      for (var k = 0; k < 4; k++) {
        final off = k * 13;
        const offsetOffset = 0.075;
        const offsetScale = 0.4;
        final layerbasedScaling = 0.15 + i * 0.025;

        final offsetX = offsetOffset +
            int.parse(hash.substring(off, off + 2), radix: 16) /
                255 *
                size *
                offsetScale;

        final primitive = primitives[
            int.parse(hash.substring(off + 10, off + 11), radix: 16) %
                primitives.length];

        final primitiveSize = 0.01 +
            int.parse(hash.substring(off + 4, off + 6), radix: 16) /
                255 *
                size *
                layerbasedScaling *
                (switch (primitive) {
                  AvatarPrimitive.circle => 1,
                  AvatarPrimitive.square => 1.333,
                  AvatarPrimitive.triangle => 1.666,
                });

        final offsetY = offsetOffset +
            int.parse(hash.substring(off + 7, off + 9), radix: 16) /
                255 *
                size *
                offsetScale;

        (switch (primitive) {
          AvatarPrimitive.circle => _paintCircles,
          AvatarPrimitive.square => _paintSquares,
          AvatarPrimitive.triangle => _paintTriangles,
        })(canvas, offsetX, offsetY, size, primitiveSize, paint);
      }
    }

    final picture = recorder.endRecording();
    final img = picture.toImageSync(size.toInt(), size.toInt());
    final bytedata = (await img.toByteData(format: ui.ImageByteFormat.png))!;

    return bytedata.buffer.asUint8List();
  }

  void _paintCircles(Canvas canvas, double offsetX, double offsetY,
      double canvasSize, double size, Paint paint) {
    canvas.drawCircle(Offset(offsetX, offsetY), size, paint);
    canvas.drawCircle(
        Offset(canvasSize - offsetX, canvasSize - offsetY), size, paint);
    canvas.drawCircle(Offset(offsetX, canvasSize - offsetY), size, paint);
    canvas.drawCircle(Offset(canvasSize - offsetX, offsetY), size, paint);
  }

  void _paintSquares(Canvas canvas, double offsetX, double offsetY,
      double canvasSize, double size, Paint paint) {
    canvas.drawRect(
        Rect.fromCenter(
          center: Offset(offsetX, offsetY),
          height: size,
          width: size,
        ),
        paint);
    canvas.drawRect(
        Rect.fromCenter(
          center: Offset(canvasSize - offsetX, canvasSize - offsetY),
          height: size,
          width: size,
        ),
        paint);
    canvas.drawRect(
        Rect.fromCenter(
          center: Offset(offsetX, canvasSize - offsetY),
          height: size,
          width: size,
        ),
        paint);
    canvas.drawRect(
        Rect.fromCenter(
          center: Offset(canvasSize - offsetX, offsetY),
          height: size,
          width: size,
        ),
        paint);
  }

  void _paintTriangles(Canvas canvas, double offsetX, double offsetY,
      double canvasSize, double size, Paint paint) {
    canvas.drawVertices(
        ui.Vertices(VertexMode.triangles, [
          Offset(offsetX, offsetY),
          Offset(offsetX + size, offsetY),
          Offset(offsetX, offsetY + size),
        ]),
        BlendMode.srcOver,
        paint);

    canvas.drawVertices(
        ui.Vertices(VertexMode.triangles, [
          Offset(canvasSize - offsetX, offsetY),
          Offset(canvasSize - offsetX - size, offsetY),
          Offset(canvasSize - offsetX, offsetY + size),
        ]),
        BlendMode.srcOver,
        paint);

    canvas.drawVertices(
        ui.Vertices(VertexMode.triangles, [
          Offset(canvasSize - offsetX, canvasSize - offsetY),
          Offset(canvasSize - offsetX - size, canvasSize - offsetY),
          Offset(canvasSize - offsetX, canvasSize - offsetY - size),
        ]),
        BlendMode.srcOver,
        paint);

    canvas.drawVertices(
        ui.Vertices(VertexMode.triangles, [
          Offset(offsetX, canvasSize - offsetY),
          Offset(offsetX + size, canvasSize - offsetY),
          Offset(offsetX, canvasSize - offsetY - size),
        ]),
        BlendMode.srcOver,
        paint);
  }
}

/// Complexity of the avatar.
///
/// The higher the complexity, the more layers will be drawn to the avatar.
///
/// The higher the complexity, the longer it takes to generate the avatar,
/// although the perfomance impact should not pose a problem either way.
///
/// _It is recommended to use the default setting [complex] as it has the best_
/// _results visually._
enum AvatarComplexity {
  simple(1),
  medium(2),
  complex(3);

  const AvatarComplexity(this.value);
  final int value;
}

/// Geometric primitives used in the generation of the avatar.
enum AvatarPrimitive {
  circle,
  square,
  triangle;
}
