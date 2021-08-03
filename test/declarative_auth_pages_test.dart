import 'package:auto_route/auto_route.dart';
import 'package:auto_route_example/declarative_auth/auth_page_routes_notifier.dart';
import 'package:auto_route_example/declarative_auth/declarative_auth_pages.dart';
import 'package:auto_route_example/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  Future<void> navigateToPage(WidgetTester tester,
      {List<Override>? overrides}) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: overrides ?? [],
        child: app.MyApp(),
      ),
    );
    await tester.pumpAndSettle();

    final buttonFinder = find.byKey(ValueKey('auth'));
    expect(buttonFinder, findsOneWidget);

    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();

    expect(find.byType(AuthFlowWrapperPage), findsOneWidget);
  }

  testWidgets("Initial AuthFlowWrapperPage should show up SplashPage",
      (WidgetTester tester) async {
    await navigateToPage(tester);

    expect(find.byType(SplashPage), findsOneWidget);
  });

  testWidgets(
      "AuthFlowWrapperPage should show up ProtectedPage when login success",
      (WidgetTester tester) async {
    await navigateToPage(tester, overrides: [
      AuthPageRoutesNotifier.provider.overrideWithProvider(
        StateNotifierProvider<AuthPageRoutesNotifier, List<PageRouteInfo>>(
          (_) => AuthPageRoutesNotifier.test(seconds: 0, isLogin: true),
        ),
      )
    ]);

    await tester.pumpAndSettle();

    await Future.delayed(Duration(seconds: 0));
    await tester.pumpAndSettle();

    expect(find.byType(ProtectedPage), findsOneWidget);
  });

  testWidgets("AuthFlowWrapperPage should show up AuthPage when login failed",
      (WidgetTester tester) async {
    await navigateToPage(tester, overrides: [
      AuthPageRoutesNotifier.provider.overrideWithProvider(
        StateNotifierProvider<AuthPageRoutesNotifier, List<PageRouteInfo>>(
          (_) => AuthPageRoutesNotifier.test(seconds: 0, isLogin: false),
        ),
      )
    ]);

    await tester.pumpAndSettle();

    await Future.delayed(Duration(seconds: 0));
    await tester.pumpAndSettle();

    expect(find.byType(AuthPage), findsOneWidget);
  });
}
