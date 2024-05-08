
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pvmp/bloc/provider/connexion_provider.dart';
import 'package:pvmp/bloc/state/session_state.dart';
import 'package:pvmp/models/connexion.dart';
import 'package:pvmp/utilities/logger.dart';
import 'package:pvmp/utilities/settings_manager.dart';

class SessionCubit extends Cubit<SessionState> {
  SessionCubit() : super(SessionState());
  

  void setSession({required Connexion connexion}){
    emit(SessionState(connexion: connexion));
  }

  void setError({required bool isError, String errorMessage = ""}){
    emit(state.copyWith(isError: isError, errorMessage: errorMessage));
  }

  Future<void> logout() async {
    try {
      Response response = await ConnexionProvider.logout();
      int? statusCode = response.statusCode;
      String data = response.data;

      if(statusCode! < 300){
        var responseData = json.decode(data);
        if(responseData["error"] == true){
          setError(isError: true, errorMessage: responseData["error_message"]);
        }else{
          //On complète la connexion
          SettingsManager.removeMail();
          SettingsManager.removeMdp();
          emit(state.copyWith(connexion: null));
        }
      }else{
        setError(isError: true, errorMessage: "Une erreur est survenue lors de la déconnexion");
      }
    } catch (e) {
      logger.e(e);
      setError(isError: true, errorMessage: "Une erreur est survenue lors de la déconnexion");
    }
  }
}