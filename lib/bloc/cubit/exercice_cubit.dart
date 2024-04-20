
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:pvmp/bloc/cubit/connexion_cubit.dart';
import 'package:pvmp/bloc/state/exercice_state.dart';

class ExerciceCubit extends Cubit<ExerciceState> {
  ExerciceCubit() : super(ExerciceLoadingState());

  void search(String? search){
    emit(ExerciceLoadingState(search: search));
  }

  Future<void> getExercices() async {
    try {
      Dio dio = await ConnexionCubit.getDioInstance();
      Response response = await dio.post('/exercice/search', data: {
        "search" : (state as ExerciceLoadingState).search ?? ""
      });
      int? statusCode = response.statusCode;
      String data = response.data;
      if(statusCode! < 300){
        var responseData = json.decode(data);
        if(responseData["error"] == true){
          emit(ExerciceErrorState(responseData["error_message"]));
        }else{
          //On complète la connexion
          emit(ExerciceLoadedState(mesExercices: responseData["data"]));
        }
      }else{
        emit(ExerciceErrorState(data));
      }
    } on DioException catch (e) {
      emit(ExerciceErrorState(e.message.toString()));
    }
  }
}