
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pvmp/bloc/provider/routine_provider.dart';
import 'package:pvmp/bloc/state/routine_state.dart';
import 'package:pvmp/utilities/logger.dart';

class RoutineCubit extends Cubit<RoutineState> {
  RoutineCubit() : super(RoutineState());

  void reset(){
    emit(RoutineState());
  }

  void setError({required bool isError, String errorMessage = ""}){
    emit(state.copyWith(isError: isError, errorMessage: errorMessage, isLoading: false));
  }

  void getAllRoutines() async {
    try {
      Response response = await RoutineProvider.getAllRoutines();
      int? statusCode = response.statusCode;
      String data = response.data;
      
      switch (statusCode) {
        case 200:
        case 201:
          var responseData = json.decode(data);
          if(responseData["error"] == true){
            setError(isError: true, errorMessage: responseData["error_message"]);
          }else{
            emit(state.copyWith(routines: responseData["data"], isError: false, isLoading: false));
          }
          break;
        default:
          setError(isError: true, errorMessage: "Une erreur est survenue lors de la récupération des routines. Actualisez cette page.");
      }
    } catch (e) {
      logger.e(e);
      setError(isError: true, errorMessage: "Une erreur est survenue lors de la récupération des routines. Actualisez cette page.");
    }
  }

  void delete({
    required int id
  }) async {
    try {
      Response response = await RoutineProvider.delete(id: id);
      int? statusCode = response.statusCode;

      if(statusCode! < 300){
        reset();
      }else{
        setError(isError: true, errorMessage: "Une erreur est survenue lors de la suppression de la routine");
      }
    } catch (e) {
      logger.e(e);
      setError(isError: true, errorMessage: "Une erreur est survenue lors de la suppression de la routine");
    }
  }
}