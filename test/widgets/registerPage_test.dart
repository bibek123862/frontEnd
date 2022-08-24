import 'package:clothing_roll/ui/screens/auth/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Register Widget Test", () {
    
    testWidgets('Check For Email Empty field', (WidgetTester tester) async {

      final un = find.byKey(ValueKey('run'));
      final pw = find.byKey(ValueKey('rpw'));
      final em = find.byKey(ValueKey('re'));
      final rB = find.byKey(ValueKey('rrb'));

      // execute test
      await tester.pumpWidget(const MaterialApp(
          home: Scaffold(
            body: registerPage(),
          ),
        ));

      await tester.enterText(em, "Required Email");
            
      expect(rB, findsOneWidget);
      await tester.tap(rB);
      await tester.pump();

      // check result
      // expect(find.text('Required'), findsOneWidget);
      // expect(find.text('Required'), findsOneWidget);
      expect(find.text('Required Email'), findsOneWidget);


    });


    testWidgets('Check if all Fields and Button are built',
        (WidgetTester tester) async {

      final un = find.byKey(ValueKey('run'));
      final pw = find.byKey(ValueKey('rpw'));
      final em = find.byKey(ValueKey('rpw'));
      final rb = find.byKey(ValueKey('rrb'));


      // execute test
      await tester.pumpWidget(const MaterialApp(
          home: Scaffold(
            body: registerPage(),
          ),
        ));
      await tester.pump();

      // check result
      expect(un, findsOneWidget);
      expect(pw, findsOneWidget);
      expect(em, findsOneWidget);
      expect(rb, findsOneWidget);
    });



                              
    testWidgets('Check error message ',
        (WidgetTester tester) async {

      await tester.pumpWidget(const MaterialApp(
          home: Scaffold(
            body: registerPage(),
          ),
        ));
      await tester.pump();

      // check result
      expect(find.text("required username"), findsNothing);
      expect(find.text("required email"), findsNothing);
      expect(find.text("required password"), findsNothing);
    });




  
  
  
  
  });



}
