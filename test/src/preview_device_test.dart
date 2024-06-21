import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:media_query_preview/media_query_preview.dart';

void main() {
  test('iPhone6_7inch factory constructor sets default values correctly', () {
    final actual = PreviewDevice.iPhone6_7inch();

    expect(actual.name, 'iPhone 6.7 inch');
    expect(actual.pixelRatio, 3);
    expect(actual.size.width, closeTo(430, 0.1));
    expect(actual.size.height, closeTo(932, 0.1));
    expect(actual.targetPlatform, TargetPlatform.iOS);
    expect(actual.textScaleFactor, 1);
    expect(actual.brightness, Brightness.light);
    expect(actual.hasHomeIndicator, true);
  });

  test('iPhone5_5inch factory constructor sets default values correctly', () {
    final actual = PreviewDevice.iPhone5_5inch();

    expect(actual.name, 'iPhone 5.5 inch');
    expect(actual.pixelRatio, 3);
    expect(actual.size.width, closeTo(414, 0.1));
    expect(actual.size.height, closeTo(736, 0.1));
    expect(actual.targetPlatform, TargetPlatform.iOS);
    expect(actual.textScaleFactor, 1);
    expect(actual.brightness, Brightness.light);
    expect(actual.hasHomeIndicator, false);
  });

  test('android6_7inch factory constructor sets default values correctly', () {
    final actual = PreviewDevice.android6_7inch();

    expect(actual.name, 'Android 6.7 inch');
    expect(actual.pixelRatio, 3);
    expect(actual.size.width, closeTo(448, 0.1));
    expect(actual.size.height, closeTo(997.3, 0.1));
    expect(actual.targetPlatform, TargetPlatform.android);
    expect(actual.textScaleFactor, 1);
    expect(actual.brightness, Brightness.light);
    expect(actual.hasHomeIndicator, true);
  });

  test('copyWith should correctly modify fields', () {
    final originalDevice = PreviewDevice(
      name: 'Original Device',
      pixelRatio: 2,
      size: const Size(100, 200),
      targetPlatform: TargetPlatform.iOS,
      textScaleFactor: 1,
      brightness: Brightness.dark,
      hasHomeIndicator: false,
      key: UniqueKey(),
    );

    final modifiedDevice = originalDevice.copyWith(
      name: 'Modified Device',
      pixelRatio: 3,
      size: const Size(200, 400),
      targetPlatform: TargetPlatform.android,
      textScaleFactor: 2,
      brightness: Brightness.light,
      hasHomeIndicator: true,
    );

    expect(modifiedDevice.name, 'Modified Device');
    expect(modifiedDevice.pixelRatio, 3.0);
    expect(modifiedDevice.size.width, 200);
    expect(modifiedDevice.size.height, 400);
    expect(modifiedDevice.targetPlatform, TargetPlatform.android);
    expect(modifiedDevice.textScaleFactor, 2.0);
    expect(modifiedDevice.brightness, Brightness.light);
    expect(modifiedDevice.hasHomeIndicator, true);

    // Asserting unchanged fields
    expect(modifiedDevice.key, originalDevice.key);
  });
}
