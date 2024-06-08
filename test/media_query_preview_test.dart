// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:media_query_preview/media_query_preview.dart';
import 'package:media_query_preview/src/preview_table.dart';
import 'package:media_query_preview/src/sidebar.dart';

void main() {
  testWidgets(
    'MediaQueryPreview should display Sidebar and PreviewTable',
    (tester) async {
      final widget = MediaQueryPreview(
        previewDevices: [
          [
            PreviewDevice.iPhone5_5inch(),
          ],
          [
            PreviewDevice.iPhone6_7inch(),
            PreviewDevice.iPhone6_7inch(),
          ],
        ],
        builder: (context, previewDevice) {
          return Text(previewDevice.name);
        },
      );

      await tester.pumpWidget(widget);

      expect(
        find.byType(Sidebar),
        findsOneWidget,
      );
      expect(
        find.byType(PreviewTable),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'virtualKeyboard should be passed to Sidebar and PreviewTable',
    (tester) async {
      final widget = MediaQueryPreview(
        previewDevices: [
          [
            PreviewDevice.iPhone5_5inch(),
          ],
        ],
        builder: (context, previewDevice) {
          return Text(previewDevice.name);
        },
        virtualKeyboard: true,
      );

      await tester.pumpWidget(widget);

      final sidebar = tester.widget<Sidebar>(
        find.byType(Sidebar),
      );
      expect(sidebar.virtualKeyboard, isTrue);

      final previewTable = tester.widget<PreviewTable>(
        find.byType(PreviewTable),
      );
      expect(previewTable.virtualKeyboard, isTrue);
    },
  );

  testWidgets(
    'If previewDevices is empty, should throw an AssertionError',
    (tester) async {
      expect(
        () => MediaQueryPreview(
          previewDevices: const [],
          builder: (context, previewDevice) {
            fail('This test should not run.');
          },
        ),
        throwsAssertionError,
      );
    },
  );

  testWidgets(
    'backgroundColor should be passed to Scaffold and Sidebar',
    (tester) async {
      const expected = Colors.red;

      final widget = MediaQueryPreview(
        previewDevices: [
          [
            PreviewDevice.iPhone5_5inch(),
          ],
        ],
        builder: (context, previewDevice) {
          return Text(previewDevice.name);
        },
        backgroundColor: expected,
      );

      await tester.pumpWidget(widget);

      final scaffold = tester.widget<Scaffold>(
        find.byKey(
          const ValueKey('MediaQueryPreview Scaffold'),
        ),
      );
      expect(scaffold.backgroundColor, expected);

      final sidebar = tester.widget<Sidebar>(
        find.byType(Sidebar),
      );
      expect(sidebar.backgroundColor, expected);
    },
  );

  group(
    'DefaultTextStyle should change color based on backgroundColor luminance',
    () {
      testWidgets(
        'backgroundColor is white',
        (tester) async {
          const backgroundColor = Colors.white;

          final widget = MediaQueryPreview(
            previewDevices: [
              [
                PreviewDevice.iPhone5_5inch(),
              ],
            ],
            builder: (context, previewDevice) {
              return Text(previewDevice.name);
            },
            backgroundColor: backgroundColor,
          );

          await tester.pumpWidget(widget);

          final defaultTextStyle = tester.widget<DefaultTextStyle>(
            find.byKey(
              const ValueKey('MediaQueryPreview DefaultTextStyle'),
            ),
          );
          expect(
            defaultTextStyle.style.color,
            Colors.black,
          );
        },
      );

      testWidgets(
        'backgroundColor is black',
        (tester) async {
          const backgroundColor = Colors.black;

          final widget = MediaQueryPreview(
            previewDevices: [
              [
                PreviewDevice.iPhone5_5inch(),
              ],
            ],
            builder: (context, previewDevice) {
              return Text(previewDevice.name);
            },
            backgroundColor: backgroundColor,
          );

          await tester.pumpWidget(widget);

          final defaultTextStyle = tester.widget<DefaultTextStyle>(
            find.byKey(
              const ValueKey('MediaQueryPreview DefaultTextStyle'),
            ),
          );
          expect(
            defaultTextStyle.style.color,
            Colors.white,
          );
        },
      );
    },
  );
}
