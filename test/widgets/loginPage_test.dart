import 'package:clothing_roll/ui/screens/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Login Widget Test", () {
    testWidgets('Check For Empty field', (WidgetTester tester) async {

      // find text field
      final un = find.byKey(ValueKey('lun'));
      final pw = find.byKey(ValueKey('lpass'));
      final lB = find.byKey(ValueKey('llb'));

      // execute test
      await tester.pumpWidget(const MaterialApp(
          home: Scaffold(
            body: loginPage(),
          ),
        ));

      await tester.enterText(un, "");
      await tester.enterText(pw, "");
            
      expect(lB, findsOneWidget);
      await tester.tap(lB);
      await tester.pump();

      // check result
      expect(find.text('Username'), findsOneWidget);
      // expect(find.text('Required Password'), findsOneWidget);


    });



    testWidgets('Test password ',
        (WidgetTester tester) async {
      final password = find.byKey(ValueKey('lpass'));

      // execute test
      await tester.pumpWidget(const MaterialApp(
          home: Scaffold(
            body: loginPage(),
          ),
        ));


      await tester.enterText(password, "123456789");
      await tester.tap(find.byKey(ValueKey('llb')));
      await tester.pump();

      // check result
      expect(
          find.text('Required'), findsOneWidget);
    });
  
  
  
  
  
  });



}
