
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

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashState());
    
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
          emit(state.copyWith(isError: false, isLoading: false));
          break;
        default:
          emit(state.copyWith(isError: true, isLoading: false, errorMessage: "Erreur lors de la récupération de la session"));
      }
    } on DioException catch (exception) {
      logger.e(exception);
      emit(state.copyWith(isError: true, isLoading: false, errorMessage: "Impossible de récupérer la session"));
    }
  }
}