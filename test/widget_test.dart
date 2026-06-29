// test/widget_test.dart
// Tests de widgets pour l'interface principale
import 'package:flutter_test/flutter_test.dart';
import 'package:qualite_mobile_s5/main.dart';

void main() {
  group('Tests de widgets – PageAccueil', () {
    testWidgets('Le titre "Liste des étudiants" est affiché dans la AppBar', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MonApplication());

      expect(find.text('Liste des étudiants'), findsOneWidget);
    });

    testWidgets('Les noms des 5 étudiants apparaissent dans la liste', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MonApplication());

      expect(find.text('Nom: Alice'), findsOneWidget);
      expect(find.text('Nom: Bob'), findsOneWidget);
      expect(find.text('Nom: Charlie'), findsOneWidget);
      expect(find.text('Nom: David'), findsOneWidget);
      expect(find.text('Nom: Eve'), findsOneWidget);
    });

    testWidgets('Le bouton "Calculer la moyenne de la classe" est présent', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MonApplication());

      expect(find.text('Calculer la moyenne de la classe'), findsOneWidget);
    });

    testWidgets(
      'Appui sur le bouton → la boîte de dialogue s\'ouvre avec la bonne moyenne',
      (WidgetTester tester) async {
        await tester.pumpWidget(const MonApplication());

        // Appuyer sur le bouton de calcul
        await tester.tap(find.text('Calculer la moyenne de la classe'));
        await tester.pumpAndSettle(); // Laisser la dialog s'afficher

        // Vérifier le titre de la boîte de dialogue
        expect(find.text('Moyenne des étudiants'), findsOneWidget);

        // Vérifier que la moyenne affichée est 14.35
        expect(find.textContaining('14.35'), findsOneWidget);
      },
    );

    testWidgets('La boîte de dialogue se ferme en appuyant sur OK', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MonApplication());

      await tester.tap(find.text('Calculer la moyenne de la classe'));
      await tester.pumpAndSettle();

      expect(find.text('Moyenne des étudiants'), findsOneWidget);

      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      // La boîte de dialogue doit avoir disparu
      expect(find.text('Moyenne des étudiants'), findsNothing);
    });
  });
}
