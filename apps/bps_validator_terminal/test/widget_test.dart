import 'package:bps_validator_terminal/app/bps_validator_terminal_app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders validator terminal dashboard', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const BpsValidatorTerminalApp());

    expect(find.text('BPS VALIDATOR TERMINAL'), findsOneWidget);
    expect(find.text('VALIDATOR STATUS'), findsOneWidget);
    expect(find.text('NODE HEALTH'), findsOneWidget);
    expect(find.text('TERMINAL CONSOLE'), findsOneWidget);
  });

  testWidgets('sidebar switches to real feature sections', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const BpsValidatorTerminalApp());

    await tester.tap(find.text('Validator').first);
    await tester.pump();
    expect(find.text('VALIDATOR DETAILS'), findsOneWidget);

    await tester.tap(find.text('Transactions').first);
    await tester.pump();
    expect(find.text('TRANSACTION INDEX'), findsOneWidget);

    await tester.tap(find.text('Governance').first);
    await tester.pump();
    expect(find.text('GOVERNANCE'), findsOneWidget);
  });
}
