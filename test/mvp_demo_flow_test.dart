import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youth_challenge_app_26/main.dart';

void main() {
  testWidgets('shows the demo landing screen and starts the flow', (tester) async {
    await tester.pumpWidget(const YouthChallengeApp());

    expect(find.byKey(const ValueKey('welcome-title')), findsOneWidget);
    expect(find.byKey(const ValueKey('start-demo-button')), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('start-demo-button')));
    await tester.pumpAndSettle();

    expect(find.text('Cadastro da escola'), findsOneWidget);
  });
}
