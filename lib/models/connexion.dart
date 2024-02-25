import 'package:json_annotation/json_annotation.dart';
import 'package:pvmp/models/user.dart';

/// L'objet connection renvoyé à l'identification
/// Run >"flutter packages pub run build_runner build" to generate serialisation/deserialisation methods
class Connexion {
  int? id;
  User? user;

  Connexion({this.id, this.user});
}
