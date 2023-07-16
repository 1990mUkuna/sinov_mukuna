import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test ElevatedButton onPressed callback',
      (WidgetTester tester) async {
    bool isPressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ElevatedButton(
            onPressed: () {
              isPressed = true;
            },
            child: const Text('Submit'),
          ),
        ),
      ),
    );

    // Verify initial state
    expect(isPressed, isFalse);

    // Tap the button
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Verify updated state
    expect(isPressed, isTrue);
  });
}
