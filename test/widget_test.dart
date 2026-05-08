import 'package:flutter_test/flutter_test.dart';
import 'package:exploremate/main.dart';

void main() {
  testWidgets('ExploreMate splash screen smoke test',
      (WidgetTester tester) async {
    await tester.pumpWidget(const ExploreMateApp());
    expect(find.text('ExploreMate'), findsWidgets);
  });
}
