
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pvmp/bloc/provider/citation_provider.dart';
import 'package:pvmp/bloc/provider/connexion_provider.dart';
import 'package:pvmp/bloc/state/home_state.dart';
import 'package:pvmp/bloc/state/login_state.dart';
import 'package:pvmp/models/connexion.dart';
import 'package:pvmp/models/user.dart';
import 'package:pvmp/utilities/logger.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());

  void setError({required bool isError, String errorMessage = ""}){
    emit(state.copyWith(isError: isError, errorMessage: errorMessage, isLoading: false));
  }

  Future<void> getRandomCitation() async {
    try {
      Response response = await CitationProvider.getRandomCitation();
      int? statusCode = response.statusCode;
      String data = response.data;

      if(statusCode! < 300){
        var responseData = json.decode(data);
        if(responseData["error"] == true){
          setError(isError: true, errorMessage: "Une erreur est survenue, actualisez cette page");
        }else{
          emit(state.copyWith(isError: false, citation: responseData, isLoading: false));
        }
      }else{
        setError(isError: true, errorMessage: "Une erreur est survenue, actualisez cette page");
      }
    } on DioException catch (e) {
      logger.e(e);
      setError(isError: true, errorMessage: "Une erreur est survenue, actualisez cette page");
    }
  }
}