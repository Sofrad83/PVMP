import 'package:pvmp/models/groupe_muscle.dart';

class Exercice{
  String nom;
  String description;
  GroupeMuscle muscle;

  Exercice({
    required this.nom,
    required this.description,
    required this.muscle
  });
}