import 'package:flutter_test/flutter_test.dart';
import 'package:youth_challenge_app_26/main.dart';

void main() {
  testWidgets('allows navigating from overview to school form in any order', (tester) async {
    await tester.pumpWidget(const YouthChallengeApp());

    expect(find.text('Visão geral da demo'), findsOneWidget);
    await tester.tap(find.text('Cadastro da escola'));
    await tester.pumpAndSettle();

    expect(find.text('Cadastro da escola'), findsOneWidget);
    expect(find.text('Preencha os dados institucionais para abrir o fluxo da demo.'), findsOneWidget);
  });
}
