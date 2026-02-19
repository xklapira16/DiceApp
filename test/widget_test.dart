import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dice_app/main.dart';

void main() {
  testWidgets('Dice rolls when button is tapped', (WidgetTester tester) async {
    // Build the Dice app
    await tester.pumpWidget(const DiceApp());

    // Verify that the initial dice image is displayed
    expect(find.byType(Image), findsOneWidget);
    expect(find.text('Roll Dice'), findsOneWidget);

    // Tap the "Roll Dice" button
    await tester.tap(find.text('Roll Dice'));
    await tester.pump();

    // After tapping, there should still be one Image widget
    expect(find.byType(Image), findsOneWidget);

    // You could optionally check that the dice image changed dynamically
    // But since it's random, we can't predict the exact number
  });
}
