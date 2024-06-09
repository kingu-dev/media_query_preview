import 'package:example/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:media_query_preview/media_query_preview.dart';

void main() {
  testWidgets(
    'Counter increments all Preview Devices',
    (tester) async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final widget = MediaQueryPreview(
        previewDevices: [
          [
            PreviewDevice.iPhone5_5inch(
              textScaleFactor: 0.5,
            ),
            PreviewDevice.iPhone5_5inch(),
            PreviewDevice.iPhone5_5inch(
              brightness: Brightness.dark,
            ),
            PreviewDevice.iPhone5_5inch(
              textScaleFactor: 1.5,
            ),
          ],
          [
            PreviewDevice.iPhone6_7inch(
              textScaleFactor: 0.5,
            ),
            PreviewDevice.iPhone6_7inch(),
            PreviewDevice.iPhone6_7inch(
              brightness: Brightness.dark,
            ),
            PreviewDevice.iPhone6_7inch(
              textScaleFactor: 1.5,
            ),
          ],
          [
            PreviewDevice.android6_7inch(
              textScaleFactor: 0.5,
            ),
            PreviewDevice.android6_7inch(),
            PreviewDevice.android6_7inch(
              brightness: Brightness.dark,
            ),
            PreviewDevice.android6_7inch(
              textScaleFactor: 1.5,
            ),
          ]
        ],
        builder: (_, previewDevice) => UncontrolledProviderScope(
          container: container,
          child: const MyApp(),
        ),
      );

      await tester.binding.setSurfaceSize(
        const Size(1920, 1080),
      );
      addTearDown(
        () => tester.binding.setSurfaceSize(null),
      );

      await tester.pumpWidget(widget);

      container.listen(
        counterControllerProvider,
        (_, __) {},
      );

      // The counter starts at 0.
      expect(
        container.read(counterControllerProvider),
        0,
      );

      // There are multiple Counter Text Widgets, and their text is '0'.
      expect(
        find.byKey(const ValueKey('counter')),
        findsWidgets,
      );
      expect(
        find.text('0'),
        findsWidgets,
      );

      // Tap the '+' icon and trigger a frame.
      await tester.tap(
        find.byType(FloatingActionButton).first,
      );
      await tester.pump();

      // The counter should now be 1.
      expect(
        container.read(counterControllerProvider),
        1,
      );

      // There are multiple Counter Text Widgets, and their text is '1'.
      expect(
        find.byKey(const ValueKey('counter')),
        findsWidgets,
      );
      expect(
        find.text('1'),
        findsWidgets,
      );
    },
  );
}
