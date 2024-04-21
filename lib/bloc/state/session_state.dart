
import 'package:pvmp/models/connexion.dart';

class SessionState {
  Connexion? connexion;
  bool isError;
  String? errorMessage;

  SessionState({this.connexion, this.isError = false, this.errorMessage});

  SessionState copyWith({
    Connexion? connexion,
    bool? isError,
    String? errorMessage
  }){
    return SessionState(
      connexion: connexion,
      isError:  isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }
}