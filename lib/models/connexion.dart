
import 'package:pvmp/models/user.dart';

/// L'objet connection renvoyé à l'identification
/// Run >"flutter packages pub run build_runner build" to generate serialisation/deserialisation methods
class Connexion {
  User? user;

  Connexion({this.user});
}
