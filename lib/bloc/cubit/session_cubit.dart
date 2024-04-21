
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pvmp/bloc/provider/connexion_provider.dart';
import 'package:pvmp/bloc/state/session_state.dart';
import 'package:pvmp/models/connexion.dart';
import 'package:pvmp/utilities/logger.dart';

class SessionCubit extends Cubit<SessionState> {
  SessionCubit() : super(SessionState());
  

  void setSession({required Connexion connexion}){
    emit(SessionState(connexion: connexion));
  }

  Future<void> logout() async {
    try {
      Response response = await ConnexionProvider.logout();
      int? statusCode = response.statusCode;
      String data = response.data;

      if(statusCode! < 300){
        var responseData = json.decode(data);
        if(responseData["error"] == true){
          emit(state.copyWith(isError: true, errorMessage: responseData["error_message"]));
        }else{
          //On complète la connexion
          emit(state.copyWith(connexion: null));
        }
      }else{
        emit(state.copyWith(isError: true, errorMessage: "Une erreur est survenue lors de la déconnexion"));
      }
    } on DioException catch (e) {
      logger.e(e);
      emit(state.copyWith(isError: true, errorMessage: "Une erreur est survenue lors de la déconnexion"));
    }
  }
}