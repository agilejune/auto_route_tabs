import 'package:auto_route_example/bottom_navigation_bar/bottom_navigation_bar_pages.dart';
import 'package:auto_route_example/declarative_auth/declarative_auth_pages.dart';
import 'package:auto_route_example/declarative_login/declarative_login_pages.dart';
import 'package:auto_route_example/nested/nested_pages.dart';
import 'package:auto_route_example/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  testWidgets("Initial page should be HomePage", (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    expect(find.byType(app.HomePage), findsOneWidget);
  });

  testWidgets("BooksWrapperPage should show up", (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    final buttonFinder = find.byKey(ValueKey('books'));
    expect(buttonFinder, findsOneWidget);

    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();

    expect(find.byType(BooksWrapperPage), findsOneWidget);
  });

  testWidgets("LoginWrapperPage should show up", (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    final buttonFinder = find.byKey(ValueKey('login'));
    expect(buttonFinder, findsOneWidget);

    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();

    expect(find.byType(LoginWrapperPage), findsOneWidget);
  });

  testWidgets("AuthFlowWrapperPage should show up",
      (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    final buttonFinder = find.byKey(ValueKey('auth'));
    expect(buttonFinder, findsOneWidget);

    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();

    expect(find.byType(AuthFlowWrapperPage), findsOneWidget);
  });

  testWidgets("BottomNavigationBarWrapperPage should show up",
      (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    final buttonFinder = find.byKey(ValueKey('bottom-navigation-bar'));
    expect(buttonFinder, findsOneWidget);

    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();

    expect(find.byType(BottomNavigationBarWrapperPage), findsOneWidget);
  });
}
