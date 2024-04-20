
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:pvmp/bloc/cubit/connexion_cubit.dart';
import 'package:pvmp/bloc/state/citation_state.dart';

class CitationCubit extends Cubit<CitationState> {
  CitationCubit() : super(CitationLoadingState());

  Future<void> getRandomCitation() async {
    try {
      Dio dio = await ConnexionCubit.getDioInstance();
      Response response = await dio.get('/citation/rand');
      int? statusCode = response.statusCode;
      String data = response.data;

      Logger().d(data);

      if(statusCode! < 300){
        var responseData = json.decode(data);
        if(responseData["error"] == true){
          emit(CitationErrorState(responseData["error_message"]));
        }else{
          //On complète la connexion
          emit(CitationLoadedState(responseData));
        }
      }else{
        emit(CitationErrorState(data));
      }
    } on DioException catch (e) {
      emit(CitationErrorState(e.message.toString()));
    }
  }
}