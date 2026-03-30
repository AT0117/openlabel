import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openlabel/main.dart';

void main() {
  testWidgets('OpenLabel app loads', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: OpenLabelApp()),
    );
    await tester.pump();
    expect(find.text('OpenLabel'), findsOneWidget);
  });
}
