
import 'package:pvmp/models/connexion.dart';

class LoginState {
  bool mdpIsVisible;
  bool isError;
  String? errorMessage;
  Connexion? connexion;
  LoginState({this.mdpIsVisible = false, this.isError = false, this.errorMessage, this.connexion});

  LoginState copyWith({
    bool? mdpIsVisible,
    bool? isError,
    String? errorMessage,
    Connexion? connexion
  }){
    return LoginState(
      mdpIsVisible: mdpIsVisible ?? this.mdpIsVisible,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      connexion: connexion ?? this.connexion
    );
  }
}