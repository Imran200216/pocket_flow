import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pocket_flow/main.dart';

void _usePhoneScreen(WidgetTester tester) {
  tester.view.physicalSize = const Size(1170, 2532);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);
}

Future<void> _goToAccountSetup(WidgetTester tester) async {
  await tester.pumpWidget(MyApp());
  await tester.pumpAndSettle();
  await tester.tap(find.text('Next'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Next'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Get Started'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('Onboarding shows Next, then Get Started on the last page', (
    tester,
  ) async {
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Next'), findsOneWidget);
    expect(find.text('Get Started'), findsNothing);

    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    expect(find.text('Get Started'), findsOneWidget);
    expect(find.text('Next'), findsNothing);
  });

  testWidgets('Get Started opens account setup with its three fields', (
    tester,
  ) async {
    _usePhoneScreen(tester);
    await _goToAccountSetup(tester);

    expect(find.text('Set up your account'), findsOneWidget);
    expect(find.text('Username'), findsOneWidget);
    expect(find.text('Language'), findsOneWidget);
    expect(find.text('Currency'), findsOneWidget);
  });

  testWidgets('Continue validates the empty account setup form', (
    tester,
  ) async {
    _usePhoneScreen(tester);
    await _goToAccountSetup(tester);

    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    expect(find.text('Please enter a username'), findsOneWidget);
    expect(find.text('Please select a language'), findsOneWidget);
    expect(find.text('Please select a currency'), findsOneWidget);
  });

  testWidgets('Onboarding and account setup fit on a tablet', (tester) async {
    tester.view.physicalSize = const Size(1600, 2560);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);

    await _goToAccountSetup(tester);

    expect(find.text('Continue'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
