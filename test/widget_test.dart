import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:fining/course.dart';
import 'package:fining/main.dart';

void main() {
  test('detecta empalmes y permite horarios separados', () {
    expect(demoCourses[0].overlaps(demoCourses[1]), isTrue);
    expect(demoCourses[0].overlaps(demoCourses[2]), isFalse);
  });
  testWidgets('carga catálogo oficial y filtra materias', (tester) async {
    await tester.pumpWidget(const FiningApp());
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(NavigationDestination, 'Materias'));
    await tester.pumpAndSettle();
    expect(find.text('Explora tu carrera'), findsOneWidget);
    await tester.enterText(
        find.byType(EditableText), 'Pensamiento Computacional');
    await tester.pumpAndSettle();
    expect(find.widgetWithText(ListTile, 'Pensamiento Computacional'),
        findsOneWidget);
    expect(find.text('Álgebra y Geometría Analítica'), findsNothing);
  });
}
