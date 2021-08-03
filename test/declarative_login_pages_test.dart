import 'package:auto_route/auto_route.dart';
import 'package:auto_route_example/declarative_login/declarative_login_pages.dart';
import 'package:auto_route_example/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  Future<void> navigateToLoginPage(WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    final buttonFinder = find.byKey(ValueKey('login'));
    expect(buttonFinder, findsOneWidget);

    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();

    expect(find.byType(LoginWrapperPage), findsOneWidget);
  }

  testWidgets("Initial BooksWrapperPage should show up EmailPage",
      (WidgetTester tester) async {
    await navigateToLoginPage(tester);

    expect(find.byType(EmailPage), findsOneWidget);
  });

  testWidgets("PasswordPage should show up on email button click in EmailPage",
      (WidgetTester tester) async {
    await navigateToLoginPage(tester);

    expect(find.byType(EmailPage), findsOneWidget);

    final buttonFinder = find.byKey(ValueKey('email'));
    expect(buttonFinder, findsOneWidget);

    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();

    final pageFinder = find.byType(PasswordPage);
    expect(pageFinder, findsOneWidget);
  });
}
