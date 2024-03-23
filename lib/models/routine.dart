import 'package:pvmp/models/exercice.dart';
import 'package:pvmp/models/groupe_muscle.dart';

class Routine {
  String nom;
  String description;
  List<GroupeMuscle> muscles;
  List<Exercice> exercices;

  Routine({
    required this.nom,
    required this.description,
    required this.muscles,
    required this.exercices
  });
      
  
}
