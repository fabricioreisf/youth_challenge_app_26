import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youth_challenge_app_26/main.dart';

void main() {
  testWidgets('allows navigating from overview to student registration', (tester) async {
    await tester.pumpWidget(const YouthChallengeApp());

    expect(find.byKey(const ValueKey('welcome-title')), findsOneWidget);
    await tester.tap(find.text('Cadastro do aluno'));
    await tester.pumpAndSettle();

    expect(find.text('Cadastro do aluno'), findsOneWidget);
    expect(find.text('Registre os dados principais do aluno no sistema.'), findsOneWidget);
  });
}
