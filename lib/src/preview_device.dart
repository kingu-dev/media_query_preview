import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// A device that can be used to preview the app
class PreviewDevice {
  /// Creates a device that can be used to preview the app
  const PreviewDevice({
    required this.name,
    required this.pixelRatio,
    required this.size,
    required this.targetPlatform,
    required this.textScaleFactor,
    required this.brightness,
    required this.hasHomeIndicator,
    this.key,
  });

  /// Creates an iPhone 6.7 inch device
  ///
  /// such as iPhone 15 Pro Max, iPhone 15 Plus
  /// https://developer.apple.com/help/app-store-connect/reference/screenshot-specifications/
  factory PreviewDevice.iPhone6_7inch({
    Key? key,
    double textScaleFactor = 1,
    Brightness brightness = Brightness.light,
    Orientation orientation = Orientation.portrait,
  }) =>
      PreviewDevice(
        name: 'iPhone 6.7 inch',
        pixelRatio: 3,
        size: switch (orientation) {
          Orientation.portrait => const Size(1290, 2796) / 3,
          Orientation.landscape => const Size(2796, 1290) / 3,
        },
        targetPlatform: TargetPlatform.iOS,
        textScaleFactor: textScaleFactor,
        brightness: brightness,
        hasHomeIndicator: true,
        key: key,
      );

  /// Creates an iPhone 5.5 inch device
  ///
  /// such as iPhone 8 Plus
  /// https://developer.apple.com/help/app-store-connect/reference/screenshot-specifications/
  factory PreviewDevice.iPhone5_5inch({
    Key? key,
    double textScaleFactor = 1,
    Brightness brightness = Brightness.light,
    Orientation orientation = Orientation.portrait,
  }) =>
      PreviewDevice(
        name: 'iPhone 5.5 inch',
        pixelRatio: 3,
        size: switch (orientation) {
          Orientation.portrait => const Size(1242, 2208) / 3,
          Orientation.landscape => const Size(2208, 1242) / 3,
        },
        targetPlatform: TargetPlatform.iOS,
        textScaleFactor: textScaleFactor,
        brightness: brightness,
        hasHomeIndicator: false,
        key: key,
      );

  /// Creates an Android 6.7 inch device
  ///
  /// such as Pixel 8 Pro
  /// https://store.google.com/product/pixel_8_pro_specs
  factory PreviewDevice.android6_7inch({
    Key? key,
    double textScaleFactor = 1,
    Brightness brightness = Brightness.light,
    Orientation orientation = Orientation.portrait,
  }) =>
      PreviewDevice(
        name: 'Android 6.7 inch',
        pixelRatio: 3,
        size: switch (orientation) {
          Orientation.portrait => const Size(1344, 2992) / 3,
          Orientation.landscape => const Size(2992, 1344) / 3,
        },
        targetPlatform: TargetPlatform.android,
        textScaleFactor: textScaleFactor,
        brightness: brightness,
        hasHomeIndicator: true,
        key: key,
      );

  /// The key of the PreviewDevice
  final Key? key;

  /// The name of the device
  final String name;

  /// The pixel ratio of the device
  final double pixelRatio;

  /// The screen size of the device
  final Size size;

  /// The target platform of the device
  final TargetPlatform targetPlatform;

  /// The text scale factor of the device
  final double textScaleFactor;

  /// The brightness of the device
  final Brightness brightness;

  /// Whether the device has a home indicator
  ///
  /// On Android, it's the gesture handle
  /// On iOS or iPadOS, it's the home indicator
  ///
  /// If this is true, it reserves a little space at the bottom of the screen
  final bool hasHomeIndicator;

  @override
  String toString() {
    // ignore: lines_longer_than_80_chars
    return 'PreviewDevice{key=$key, name=$name, pixelRatio=$pixelRatio, size=$size, targetPlatform=$targetPlatform, textScaleFactor=$textScaleFactor, brightness=$brightness, hasHomeIndicator=$hasHomeIndicator}';
  }

  /// Creates a copy of this [PreviewDevice] but with the given fields replaced
  /// with the new values.
  PreviewDevice copyWith({
    ValueGetter<Key?>? key,
    String? name,
    double? pixelRatio,
    Size? size,
    TargetPlatform? targetPlatform,
    double? textScaleFactor,
    Brightness? brightness,
    bool? hasHomeIndicator,
  }) {
    return PreviewDevice(
      key: key != null ? key() : this.key,
      name: name ?? this.name,
      pixelRatio: pixelRatio ?? this.pixelRatio,
      size: size ?? this.size,
      targetPlatform: targetPlatform ?? this.targetPlatform,
      textScaleFactor: textScaleFactor ?? this.textScaleFactor,
      brightness: brightness ?? this.brightness,
      hasHomeIndicator: hasHomeIndicator ?? this.hasHomeIndicator,
    );
  }
}
