import 'package:auto_route/auto_route.dart';
import 'package:auto_route_example/bottom_navigation_bar/bottom_navigation_bar_pages.dart';
import 'package:auto_route_example/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  Future<void> navigateToPage(WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    final buttonFinder = find.byKey(ValueKey('bottom-navigation-bar'));
    expect(buttonFinder, findsOneWidget);

    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();

    expect(find.byType(BottomNavigationBarWrapperPage), findsOneWidget);
  }

  testWidgets("Initial BottomNavigationBarWrapperPage should show up FlowPage",
      (WidgetTester tester) async {
    await navigateToPage(tester);

    expect(find.byType(FlowPage), findsOneWidget);
  });

  testWidgets("FlowDetailPage should show up when detail button click",
      (WidgetTester tester) async {
    await navigateToPage(tester);

    expect(find.byType(FlowPage), findsOneWidget);

    final buttonFinder = find.byKey(ValueKey('flow_detail'));
    expect(buttonFinder, findsOneWidget);

    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();

    expect(find.byType(FlowDetailPage), findsOneWidget);
  });

  testWidgets("FlowDetailPage should be able to back",
      (WidgetTester tester) async {
    await navigateToPage(tester);

    final buttonFinder = find.byKey(ValueKey('flow_detail'));

    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();

    expect(find.byType(FlowDetailPage), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();

    expect(find.byType(FlowPage), findsOneWidget);
  });

  testWidgets("ProfilePage should show up when profile BottomNavigationBarItem",
      (WidgetTester tester) async {
    await navigateToPage(tester);

    final buttonFinder = find.text('Profile');
    expect(buttonFinder, findsOneWidget);

    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();

    expect(find.byType(ProfilePage), findsOneWidget);
  });

  testWidgets("ProfileDetailPage should show up when detail button click",
      (WidgetTester tester) async {
    await navigateToPage(tester);

    final tabButtonFinder = find.text('Profile');
    expect(tabButtonFinder, findsOneWidget);

    await tester.tap(tabButtonFinder);
    await tester.pumpAndSettle();

    expect(find.byType(ProfilePage), findsOneWidget);

    final buttonFinder = find.byKey(ValueKey('profile_detail'));
    expect(buttonFinder, findsOneWidget);

    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();

    expect(find.byType(ProfileDetailPage), findsOneWidget);
  });

  testWidgets("ProfileDetailPage should be able to back",
      (WidgetTester tester) async {
    await navigateToPage(tester);

    final tabButtonFinder = find.text('Profile');

    await tester.tap(tabButtonFinder);
    await tester.pumpAndSettle();

    final buttonFinder = find.byKey(ValueKey('profile_detail'));
    expect(buttonFinder, findsOneWidget);

    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();

    await tester.pageBack();
    await tester.pumpAndSettle();

    expect(find.byType(ProfilePage), findsOneWidget);
  });
}
