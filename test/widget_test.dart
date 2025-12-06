import 'package:flutter_test/flutter_test.dart';
import 'package:personality_quiz_app/app/app.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const QuizApp());

    // Verify that the app renders without errors
    expect(find.byType(QuizApp), findsOneWidget);
  });
}
