
import 'dart:convert';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pvmp/bloc/provider/connexion_provider.dart';
import 'package:pvmp/bloc/state/splash_state.dart';
import 'package:pvmp/models/connexion.dart';
import 'package:pvmp/models/user.dart';
import 'package:pvmp/utilities/logger.dart';
import 'package:pvmp/utilities/settings_manager.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashState());

  void setError({required bool isError, String errorMessage = ""}){
    emit(state.copyWith(isError: isError, errorMessage: errorMessage, isLoading: false));
  }
    
  Future<void> getSession() async {
    try {
      Response response = await ConnexionProvider.getSession();
      int? statusCode = response.statusCode;
      String data = response.data;
      var responseJson = json.decode(data);
      
      switch (statusCode) {
        case 200:
        case 201:
          emit(state.copyWith(isLoading: false, isError: false, connexion: Connexion(user: User.fromJson(responseJson["data"]))));
          break;
        case 401:
          //ici on est pas connecté du coup on essaye de login avec les id enregistré
          var mail = await SettingsManager.getMail();
          var mdp = await SettingsManager.getMdp();

          if(mail != null && mdp != null){
            login(mail, mdp);
          }else{
            emit(state.copyWith(isError: false, isLoading: false));
          }
          break;
        default:
          setError(isError: true, errorMessage: "Erreur lors de la récupération de la session");
      }
    } catch (exception) {
      logger.e(exception);
      setError(isError: true, errorMessage: "Impossible de récupérer la session");
    }
  }

  Future<void> login(String mail, String mdp) async {
    try {
      Response response = await ConnexionProvider.login(mail: mail, mdp: mdp);
      int? statusCode = response.statusCode;
      String data = response.data;
      
      switch (statusCode) {
        case 200:
        case 201:
          var responseData = json.decode(data);
          if(responseData["error"] == true){
            setError(isError: true, errorMessage: responseData["error_message"]);
          }else{
            emit(state.copyWith(isLoading: false, isError: false, connexion: Connexion(user: User.fromJson(responseData["data"]))));
          }
          break;
        default:
          setError(isError: true, errorMessage: "Une erreur est survenue lors de la connexion, réessayez");
      }
    } catch (e) {
      logger.e(e);
      setError(isError: true, errorMessage: "Une erreur est survenue lors de la connexion, réessayez");
    }
  }
}