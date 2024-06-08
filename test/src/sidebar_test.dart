import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:media_query_preview/src/sidebar.dart';

void main() {
  testWidgets(
    'Sidebar should display a switch to toggle the virtual keyboard',
    (tester) async {
      var value = false;

      final widget = Directionality(
        textDirection: TextDirection.ltr,
        child: StatefulBuilder(
          builder: (context, StateSetter setState) {
            return Sidebar(
              backgroundColor: Colors.white,
              virtualKeyboard: value,
              onVirtualKeyboardChanged: (newValue) {
                setState(() {
                  value = newValue;
                });
              },
            );
          },
        ),
      );

      await tester.pumpWidget(widget);

      final switchFinder = find.byKey(
        const ValueKey('virtualKeyboard switch'),
      );

      expect(switchFinder, findsOneWidget);
      expect(tester.widget<Switch>(switchFinder).value, isFalse);

      await tester.tap(switchFinder);
      await tester.pump();

      expect(tester.widget<Switch>(switchFinder).value, isTrue);
    },
  );
}
