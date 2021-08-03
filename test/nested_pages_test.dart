import 'package:auto_route_example/nested/nested_pages.dart';
import 'package:auto_route_example/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  Future<void> navigateToBooksPage(WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    final buttonFinder = find.byKey(ValueKey('books'));
    expect(buttonFinder, findsOneWidget);

    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();

    expect(find.byType(BooksWrapperPage), findsOneWidget);
  }

  testWidgets("BooksWrapperPage should redirect BooksPage",
      (WidgetTester tester) async {
    await navigateToBooksPage(tester);

    expect(find.byType(BooksPage), findsOneWidget);
  });

  testWidgets("BookDetailsPage should show up", (WidgetTester tester) async {
    await navigateToBooksPage(tester);

    expect(find.byType(BooksPage), findsOneWidget);

    final buttonFinder = find.byKey(ValueKey('details'));
    expect(buttonFinder, findsOneWidget);

    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();

    final pageFinder = find.byType(BookDetailsPage);
    expect(pageFinder, findsOneWidget);

    final page = tester.widget<BookDetailsPage>(pageFinder);
    expect(page.bookId, equals(3));
    expect(page.author, isNull);

    expect(find.textContaining('3'), findsOneWidget);
    expect(find.textContaining('null'), findsOneWidget);
  });
}
