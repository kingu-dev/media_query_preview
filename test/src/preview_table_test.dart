import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:media_query_preview/media_query_preview.dart';
import 'package:media_query_preview/src/preview_cell.dart';
import 'package:media_query_preview/src/preview_table.dart';

void main() {
  testWidgets(
    'PreviewTable should display the preview of the app on multiple devices',
    (tester) async {
      final widget = Directionality(
        textDirection: TextDirection.ltr,
        child: PreviewTable(
          previewDevices: [
            [
              PreviewDevice.iPhone5_5inch(
                key: const ValueKey('Device 1'),
              ),
            ],
            [
              PreviewDevice.iPhone6_7inch(
                key: const ValueKey('Device 2'),
              ),
              PreviewDevice.iPhone6_7inch(
                key: const ValueKey('Device 3'),
              ),
            ],
          ],
          virtualKeyboard: false,
          builder: (context, previewDevice) {
            return Text(
              (previewDevice.key! as ValueKey<String>).value,
            );
          },
        ),
      );

      await tester.pumpWidget(widget);

      expect(
        find.byType(PreviewCell),
        findsNWidgets(3),
      );

      expect(
        find.text('Device 1'),
        findsOneWidget,
      );
      expect(
        find.text('Device 2'),
        findsOneWidget,
      );
      expect(
        find.text('Device 3'),
        findsOneWidget,
      );

      // "No device" is displayed in the empty space
      expect(
        find.text('No device'),
        findsOneWidget,
      );
    },
  );
}
