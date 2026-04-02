import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/main.dart';
import 'package:app/providers/app_state.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Zigo Enterprise smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => AppState(),
        child: const MyApp(),
      ),
    );

    // Verify that we are on the Customers screen by default (as per my _selectedIndex = 1)
    expect(find.text('Zigo Enterprise'), findsOneWidget);
    expect(find.text('Alejandro Villalobos'), findsOneWidget);

    // Tap on a customer to go to details
    await tester.tap(find.text('Alejandro Villalobos'));
    await tester.pumpAndSettle();

    // Verify detail screen
    expect(find.text('Customers'), findsOneWidget);
    expect(find.text('SALDO DEUDOR TOTAL'), findsOneWidget);
  });
}
