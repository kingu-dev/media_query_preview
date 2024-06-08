import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:media_query_preview/media_query_preview.dart';
import 'package:media_query_preview/src/preview_cell.dart';

void main() {
  group(
    'virtualKeyboard',
    () {
      testWidgets(
        'should not be displayed',
        (tester) async {
          final device = PreviewDevice.iPhone6_7inch();

          final widget = Directionality(
            textDirection: TextDirection.ltr,
            child: PreviewCell(
              previewDevice: device,
              virtualKeyboard: false,
              builder: (context, previewDevice) {
                expect(previewDevice, device);
                return const Text('previewDevice');
              },
            ),
          );

          await tester.pumpWidget(widget);

          expect(
            find.byKey(const ValueKey('virtualKeyboard')),
            findsNothing,
          );
        },
      );

      testWidgets(
        'should be displayed',
        (tester) async {
          final device = PreviewDevice.iPhone6_7inch();

          final widget = Directionality(
            textDirection: TextDirection.ltr,
            child: PreviewCell(
              previewDevice: device,
              virtualKeyboard: true,
              builder: (context, previewDevice) {
                expect(previewDevice, device);
                return const Text('previewDevice');
              },
            ),
          );

          await tester.pumpWidget(widget);

          expect(
            find.byKey(const ValueKey('virtualKeyboard')),
            findsOneWidget,
          );
        },
      );
    },
  );

  group(
    'MediaQueryData',
    () {
      testWidgets(
        'platformBrightness',
        (tester) async {
          const targetKey = ValueKey('previewDevice');

          for (final brightness in [
            Brightness.light,
            Brightness.dark,
          ]) {
            final widget = Directionality(
              textDirection: TextDirection.ltr,
              child: PreviewCell(
                previewDevice: PreviewDevice.iPhone6_7inch(
                  brightness: brightness,
                ),
                virtualKeyboard: false,
                builder: (context, previewDevice) {
                  return const Text(
                    'previewDevice',
                    key: targetKey,
                  );
                },
              ),
            );

            await tester.pumpWidget(widget);

            final mediaQueryData = MediaQuery.of(
              tester.element(
                find.byKey(targetKey),
              ),
            );
            expect(
              mediaQueryData.platformBrightness,
              brightness,
            );
          }
        },
      );

      testWidgets(
        'size',
        (tester) async {
          const targetKey = ValueKey('previewDevice');

          for (final previewDevice in [
            PreviewDevice.iPhone5_5inch(),
            PreviewDevice.iPhone6_7inch(),
            PreviewDevice.android6_7inch(),
          ]) {
            final widget = Directionality(
              textDirection: TextDirection.ltr,
              child: PreviewCell(
                previewDevice: previewDevice,
                virtualKeyboard: false,
                builder: (context, previewDevice) {
                  return const Text(
                    'previewDevice',
                    key: targetKey,
                  );
                },
              ),
            );

            await tester.pumpWidget(widget);

            final mediaQueryData = MediaQuery.of(
              tester.element(
                find.byKey(targetKey),
              ),
            );
            expect(
              mediaQueryData.size,
              previewDevice.size,
            );
          }
        },
      );

      testWidgets(
        'textScaleFactor',
        (tester) async {
          const targetKey = ValueKey('previewDevice');

          for (final textScaleFactor in [0.5, 1.0, 1.5]) {
            final widget = Directionality(
              textDirection: TextDirection.ltr,
              child: PreviewCell(
                previewDevice: PreviewDevice.iPhone6_7inch(
                  textScaleFactor: textScaleFactor,
                ),
                virtualKeyboard: false,
                builder: (context, previewDevice) {
                  return const Text(
                    'previewDevice',
                    key: targetKey,
                  );
                },
              ),
            );

            await tester.pumpWidget(widget);

            final mediaQueryData = MediaQuery.of(
              tester.element(
                find.byKey(targetKey),
              ),
            );
            expect(
              mediaQueryData.textScaler,
              TextScaler.linear(textScaleFactor),
            );
          }
        },
      );

      testWidgets(
        'padding, viewInsets, viewPadding',
        (tester) async {
          const targetKey = ValueKey('previewDevice');

          final devices = [
            const PreviewDevice(
              name: 'has not home indicator',
              pixelRatio: 3,
              size: Size(100, 100),
              targetPlatform: TargetPlatform.iOS,
              textScaleFactor: 1,
              brightness: Brightness.light,
              hasHomeIndicator: false,
            ),
            const PreviewDevice(
              name: 'has home indicator',
              pixelRatio: 3,
              size: Size(100, 100),
              targetPlatform: TargetPlatform.iOS,
              textScaleFactor: 1,
              brightness: Brightness.light,
              hasHomeIndicator: true,
            ),
          ];

          for (final device in devices) {
            for (final virtualKeyboard in [true, false]) {
              final widget = Directionality(
                textDirection: TextDirection.ltr,
                child: PreviewCell(
                  previewDevice: device,
                  virtualKeyboard: virtualKeyboard,
                  builder: (context, previewDevice) {
                    return const Text(
                      'previewDevice',
                      key: targetKey,
                    );
                  },
                ),
              );

              await tester.pumpWidget(widget);

              final mediaQueryData = MediaQuery.of(
                tester.element(
                  find.byKey(targetKey),
                ),
              );

              // expect padding
              if (virtualKeyboard) {
                // When the keyboard is displayed, the padding should
                // not include the home indicator
                expect(
                  mediaQueryData.padding,
                  const EdgeInsets.only(
                    top: PreviewCell.statusBarHeight,
                  ),
                );
              } else {
                // When the keyboard is not displayed, the padding should
                // include the home indicator if the device has it
                expect(
                  mediaQueryData.padding,
                  EdgeInsets.only(
                    top: PreviewCell.statusBarHeight,
                    bottom: device.hasHomeIndicator
                        ? PreviewCell.homeIndicatorHeight
                        : 0,
                  ),
                );
              }

              // expect viewInsets
              expect(
                mediaQueryData.viewInsets,
                EdgeInsets.only(
                  bottom: virtualKeyboard ? PreviewCell.keyboardHeight : 0,
                ),
              );

              // expect viewPadding
              expect(
                mediaQueryData.viewPadding,
                EdgeInsets.only(
                  top: PreviewCell.statusBarHeight,
                  bottom: device.hasHomeIndicator
                      ? PreviewCell.homeIndicatorHeight
                      : 0,
                ),
              );
            }
          }
        },
      );
    },
  );
}
