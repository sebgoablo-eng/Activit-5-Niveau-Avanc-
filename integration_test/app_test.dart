// integration_test/app_test.dart
// Tests d'intégration : scénario complet de navigation

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:qualite_mobile_s5/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Tests d\'intégration – Navigation et interactions', () {
    testWidgets('Scénario complet : liste → détail d\'un étudiant → retour', (
      WidgetTester tester,
    ) async {
      // ÉTAPE 1 : Lancer l'application
      await tester.pumpWidget(const MonApplication());
      await tester.pumpAndSettle();

      // ÉTAPE 2 : Vérifier que la page d'accueil est affichée
      expect(find.text('Liste des étudiants'), findsOneWidget);
      expect(find.text('Nom: Alice'), findsOneWidget);

      // ÉTAPE 3 : Cliquer sur l'étudiant "Alice"
      await tester.tap(find.text('Nom: Alice'));
      await tester.pumpAndSettle();

      // ÉTAPE 4 : Vérifier que la page de détails s'est ouverte
      expect(find.text('Détails de l\'étudiant'), findsOneWidget);
      expect(find.text('Nom de l\'étudiant : Alice'), findsOneWidget);
      expect(find.text('Moyenne : 17.25'), findsOneWidget);

      // ÉTAPE 5 : Revenir à la page précédente
      final NavigatorState navigator = tester.state(find.byType(Navigator));
      navigator.pop();
      await tester.pumpAndSettle();

      // ÉTAPE 6 : Vérifier le retour à la liste
      expect(find.text('Liste des étudiants'), findsOneWidget);
    });

    testWidgets('Scénario : calcul de moyenne depuis la page principale', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MonApplication());
      await tester.pumpAndSettle();

      // Appuyer sur le bouton de calcul
      await tester.tap(find.text('Calculer la moyenne de la classe'));
      await tester.pumpAndSettle();

      // Vérifier la présence de la boîte de dialogue avec la bonne valeur
      expect(find.text('Moyenne des étudiants'), findsOneWidget);
      expect(find.textContaining('14.35'), findsOneWidget);

      // Fermer
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
      expect(find.text('Moyenne des étudiants'), findsNothing);
    });

    testWidgets('Navigation vers chaque étudiant et vérification des données', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MonApplication());
      await tester.pumpAndSettle();

      // Tester la navigation pour Bob
      await tester.tap(find.text('Nom: Bob'));
      await tester.pumpAndSettle();

      expect(find.text('Nom de l\'étudiant : Bob'), findsOneWidget);
      expect(find.text('Moyenne : 16.5'), findsOneWidget);

      final NavigatorState navigator = tester.state(find.byType(Navigator));
      navigator.pop();
      await tester.pumpAndSettle();

      // Tester la navigation pour Charlie
      await tester.tap(find.text('Nom: Charlie'));
      await tester.pumpAndSettle();

      expect(find.text('Nom de l\'étudiant : Charlie'), findsOneWidget);
      expect(find.text('Moyenne : 11.75'), findsOneWidget);
    });
  });
}
