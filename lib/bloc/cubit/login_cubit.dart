
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pvmp/bloc/provider/connexion_provider.dart';
import 'package:pvmp/bloc/state/login_state.dart';
import 'package:pvmp/models/connexion.dart';
import 'package:pvmp/models/user.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState());

  void toggleMdpVisible(){
    emit(state.copyWith(mdpIsVisible: !state.mdpIsVisible));
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
            emit(state.copyWith(isError : true, errorMessage: responseData["error_message"]));
          }else{
            emit(state.copyWith(connexion: Connexion(user: User.fromJson(responseData["data"])), isError: false));
          }
          break;
        default:
          emit(state.copyWith(isError : true, errorMessage: "Une erreur est survenue lors de la connexion, réessayez"));
      }
    } on DioException catch (e) {
      print(e);
    }
  }
}