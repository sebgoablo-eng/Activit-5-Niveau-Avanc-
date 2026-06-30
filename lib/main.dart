import 'package:flutter/material.dart';

void main() {
  runApp(const MonApplication());
}

// MODÈLE
class Etudiant {
  final String nom;
  final double moyenne;

  const Etudiant({required this.nom, required this.moyenne});
}

// WIDGET RACINE
class MonApplication extends StatelessWidget {
  const MonApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qualité Mobile S5',
      debugShowCheckedModeBanner: false,
      home: const PageAccueil(),
      routes: {'/details': (context) => const DetailPage()},
    );
  }
}

// PAGE D'ACCUEIL
class PageAccueil extends StatelessWidget {
  const PageAccueil({super.key});

  final List<Etudiant> etudiants = const [
    Etudiant(nom: 'Alice', moyenne: 17.25),
    Etudiant(nom: 'Bob', moyenne: 16.5),
    Etudiant(nom: 'Charlie', moyenne: 11.75),
    Etudiant(nom: 'David', moyenne: 12.75),
    Etudiant(nom: 'Eve', moyenne: 13.5),
  ];

  double calculateMoyenne(List<Etudiant> etudiants) {
    double total = 0;

    for (final etudiant in etudiants) {
      total += etudiant.moyenne;
    }

    return total / etudiants.length;
  }

  void moyenneAlertDialog(BuildContext context, double average) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Moyenne des étudiants'),
        content: Text(
          'La moyenne des étudiants est : ${average.toStringAsFixed(2)}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des étudiants'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Liste des étudiants et de leurs moyennes :',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: ListView.builder(
                itemCount: etudiants.length,
                itemBuilder: (context, index) {
                  final etudiant = etudiants[index];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text('Nom: ${etudiant.nom}'),
                      subtitle: Text('Moyenne : ${etudiant.moyenne}'),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/details',
                          arguments: etudiant,
                        );
                      },
                    ),
                  );
                },
              ),
            ),

            ElevatedButton(
              onPressed: () {
                final moyenne = calculateMoyenne(etudiants);
                moyenneAlertDialog(context, moyenne);
              },
              child: const Text('Calculer la moyenne de la classe'),
            ),
          ],
        ),
      ),
    );
  }
}

// PAGE DÉTAIL
class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final etudiant = ModalRoute.of(context)!.settings.arguments as Etudiant;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Détails de l'étudiant"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Nom de l'étudiant : ${etudiant.nom}",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 12),
            Text(
              "Moyenne : ${etudiant.moyenne}",
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
