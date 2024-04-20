
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pvmp/bloc/cubit/connexion_cubit.dart';
import 'package:pvmp/bloc/state/routine_state.dart';

class RoutineCubit extends Cubit<RoutineState> {
  RoutineCubit() : super(RoutineLoadingState());

  void reload(){
    emit(RoutineLoadingState());
  }

  void error(String error){
    emit(RoutineErrorState(error));
  }

  void getAllRoutines() async {
    try {
      Dio dio = await ConnexionCubit.getDioInstance();
      Response response = await dio.get('/routine/get-all');
      int? statusCode = response.statusCode;
      String data = response.data;
      
      switch (statusCode) {
        case 200:
        case 201:
          var responseData = json.decode(data);
          if(responseData["error"] == true){
            emit(RoutineErrorState(responseData["error_message"]));
          }else{

            emit(RoutineLoadedState(mesRoutines: responseData["data"]));
          }
          break;
        default:
          emit(RoutineErrorState(data));
      }
    } on DioException catch (e) {
      print(e);
    }
  }

  void getAllRoutinesLastSeries() async {
    try {
      Dio dio = await ConnexionCubit.getDioInstance();
      Response response = await dio.get('/routine/get-all-last-series');
      int? statusCode = response.statusCode;
      String data = response.data;
      
      switch (statusCode) {
        case 200:
        case 201:
          var responseData = json.decode(data);
          if(responseData["error"] == true){
            emit(RoutineErrorState(responseData["error_message"]));
          }else{

            emit(RoutineLoadedState(mesRoutines: responseData["data"]));
          }
          break;
        default:
          emit(RoutineErrorState(data));
      }
    } on DioException catch (e) {
      print(e);
    }
  }

  void store({
    required String nom,
    required String description,
    required List exos,
    int? id
  }) async {
    try {
      Map<String, dynamic> data = {
        "nom" : nom,
        "description" : description,
        "id" : id
      };
      List exosId = [];
      exos.forEach((element) {
        exosId.add(element["id"]);
      });
      data.addAll({"exos" : exosId.toString()});
      FormData formData = FormData.fromMap(data);


      Dio dio = await ConnexionCubit.getDioInstance();
      Response response = await dio.post('/routine/store', data: formData);
      int? statusCode = response.statusCode;
      String rep = response.data;

      if(statusCode! < 300){
        var responseData = json.decode(rep);
        emit(RoutineStoreDoneState(responseData["message"]));
      }else{
        emit(RoutineErrorState("Une erreur est survenue lors de l'enregistrement de la routine"));
      }
    } on DioException catch (e) {
      print(e);
    }
  }

  void delete({
    required int id
  }) async {
    try {
      Dio dio = await ConnexionCubit.getDioInstance();
      Map<String, dynamic> data = {
        "id" : id
      };
      FormData formData = FormData.fromMap(data);
      Response response = await dio.post('/routine/delete', data: formData);
      int? statusCode = response.statusCode;

      if(statusCode! < 300){
        emit(RoutineLoadingState());
      }else{
        emit(RoutineErrorState("Une erreur est survenue lors de l'enregistrement de la routine"));
      }
    } on DioException catch (e) {
      print(e);
    }
  }
}