
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pvmp/bloc/provider/connexion_provider.dart';
import 'package:pvmp/bloc/state/login_state.dart';
import 'package:pvmp/bloc/state/register_state.dart';
import 'package:pvmp/models/connexion.dart';
import 'package:pvmp/models/user.dart';
import 'package:pvmp/utilities/logger.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterState());

  void toggleMdpVisible(){
    emit(state.copyWith(mdpIsVisible: !state.mdpIsVisible));
  }

  Future<void> register(String name, String mail, String mdp) async {
    try {
      Response response = await ConnexionProvider.register(name: name, mail: mail, mdp: mdp);
      int? statusCode = response.statusCode;
      String data = response.data;

      if(statusCode! < 300){
        var responseData = json.decode(data);
        if(responseData["error"] == true){
          emit(state.copyWith(isError: true, errorMessage: responseData["error_message"]));
        }else{
          emit(state.copyWith(connexion: Connexion(user: User.fromJson(responseData["user"])), isError: false));
        }
      }else{
        emit(state.copyWith(isError: true, errorMessage: "Une erreur est survenue lors de la création de votre compte. Réessayez"));
      }
    } on DioException catch (e) {
      logger.e(e);
      emit(state.copyWith(isError: true, errorMessage: "Une erreur est survenue lors de la création de votre compte. Réessayez"));
    }
  }
}