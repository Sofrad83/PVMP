import 'package:pvmp/models/connexion.dart';

abstract class ConnexionState {}

class ConnexionLoadingState extends ConnexionState {}

class ConnexionLoadedState extends ConnexionState {
  final Connexion? connexion;
  ConnexionLoadedState(this.connexion);

  Connexion? getConnexion(){
    return connexion;
  }
}

class ConnexionErrorState extends ConnexionState {
  final String error;
  ConnexionErrorState(this.error);
}