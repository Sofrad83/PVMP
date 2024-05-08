
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pvmp/bloc/provider/connexion_provider.dart';
import 'package:pvmp/bloc/state/login_state.dart';
import 'package:pvmp/models/connexion.dart';
import 'package:pvmp/models/user.dart';
import 'package:pvmp/utilities/logger.dart';
import 'package:pvmp/utilities/settings_manager.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState());

  void toggleMdpVisible(){
    emit(state.copyWith(mdpIsVisible: !state.mdpIsVisible));
  }

  void setError({required bool isError, String errorMessage = ""}){
    emit(state.copyWith(isError: isError, errorMessage: errorMessage));
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
            await SettingsManager.setMail(mail);
            await SettingsManager.setMdp(mdp);
            emit(state.copyWith(connexion: Connexion(user: User.fromJson(responseData["data"])), isError: false));
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