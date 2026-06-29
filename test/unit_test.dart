// test/unit_test.dart
// Tests unitaires pour la logique de calcul de moyenne

import 'package:flutter_test/flutter_test.dart';
import 'package:qualite_mobile_s5/main.dart';

// Fonction extraite pour les tests (identique à celle de PageAccueil)
double calculateMoyenne(List<Etudiant> etudiants) {
  double total = 0.0;
  for (var etudiant in etudiants) {
    total += etudiant.moyenne;
  }
  return total / etudiants.length;
}

void main() {
  group('Tests unitaires – calculateMoyenne', () {
    test('Cas simple : deux étudiants avec 10 et 14 → moyenne 12', () {
      final etudiants = [
        const Etudiant(nom: 'A', moyenne: 10.0),
        const Etudiant(nom: 'B', moyenne: 14.0),
      ];
      expect(calculateMoyenne(etudiants), equals(12.0));
    });

    test('Cas avec les 5 étudiants de l\'application → 14.35', () {
      final etudiants = [
        const Etudiant(nom: 'Alice', moyenne: 17.25),
        const Etudiant(nom: 'Bob', moyenne: 16.5),
        const Etudiant(nom: 'Charlie', moyenne: 11.75),
        const Etudiant(nom: 'David', moyenne: 12.75),
        const Etudiant(nom: 'Eve', moyenne: 13.5),
      ];
      // (17.25 + 16.5 + 11.75 + 12.75 + 13.5) / 5 = 71.75 / 5 = 14.35
      expect(calculateMoyenne(etudiants), closeTo(14.35, 0.001));
    });

    test('Un seul étudiant → retourne sa propre moyenne', () {
      final etudiants = [const Etudiant(nom: 'Solo', moyenne: 18.0)];
      expect(calculateMoyenne(etudiants), equals(18.0));
    });

    test('Moyennes avec décimales variées → résultat en double conservé', () {
      final etudiants = [
        const Etudiant(nom: 'X', moyenne: 17.25),
        const Etudiant(nom: 'Y', moyenne: 16.5),
        const Etudiant(nom: 'Z', moyenne: 11.75),
        const Etudiant(nom: 'W', moyenne: 12.75),
        const Etudiant(nom: 'V', moyenne: 13.5),
      ];
      final result = calculateMoyenne(etudiants);
      // Vérifie que le résultat est bien un double (pas un int arrondi)
      expect(result, isA<double>());
      expect(result, isNot(equals(result.truncate().toDouble())));
    });
  });
}
