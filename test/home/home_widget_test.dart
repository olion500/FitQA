import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitqa/main.dart';

void main() {
  group('BottomNavigation', () {
    testWidgets('tab index should start at 0', (WidgetTester tester) async {
      await tester.pumpWidget(MyHomePage(title: 'test'));

      var bottomNavFinder = find.byType(BottomNavigationBar);
      expect(bottomNavFinder, findsOneWidget);

      BottomNavigationBar bottomNav = tester.firstWidget(bottomNavFinder);
      expect(bottomNav.currentIndex, 0);
    });

    testWidgets('tab index should be changed when user taps',
        (WidgetTester tester) async {
      await tester.pumpWidget(MyHomePage(title: 'test'));

      var bottomNavFinder = find.byType(BottomNavigationBar);
      expect(bottomNavFinder, findsOneWidget);

      var bottomNavItemFinder = find.byType(BottomNavigationBarItem);
      expect(bottomNavItemFinder, findsNWidgets(4));

      var randTabIndex = new Random().nextInt(4);

      await tester.tap(bottomNavItemFinder.at(randTabIndex));
      await tester.pump();

      BottomNavigationBar bottomNav = tester.firstWidget(bottomNavFinder);
      expect(bottomNav.currentIndex, randTabIndex);
    });
  });
}
