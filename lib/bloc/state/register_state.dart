
import 'package:pvmp/models/connexion.dart';

class RegisterState {
  bool mdpIsVisible;
  bool isError;
  String? errorMessage;
  Connexion? connexion;
  RegisterState({this.mdpIsVisible = false, this.isError = false, this.errorMessage, this.connexion});

  RegisterState copyWith({
    bool? mdpIsVisible,
    bool? isError,
    String? errorMessage,
    Connexion? connexion
  }){
    return RegisterState(
      mdpIsVisible: mdpIsVisible ?? this.mdpIsVisible,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      connexion: connexion ?? this.connexion
    );
  }
}