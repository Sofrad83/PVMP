
import 'package:pvmp/models/connexion.dart';

class SplashState {
  bool isLoading;
  bool isError;
  String? errorMessage;
  Connexion? connexion;

  SplashState({this.isLoading = true, this.isError = false, this.errorMessage, this.connexion});

  SplashState copyWith({
    bool? isLoading,
    bool? isError,
    String? errorMessage,
    Connexion? connexion
  }){
    return SplashState(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      connexion: connexion ?? this.connexion
    );
  }
}