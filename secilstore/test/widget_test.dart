import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:secilstore/app/app.dart';

void main() {
  testWidgets('App smoke test — renders without crashing',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: SecilStoreApp()),
    );
    await tester.pump();
    expect(find.byType(SecilStoreApp), findsOneWidget);
  });
}
