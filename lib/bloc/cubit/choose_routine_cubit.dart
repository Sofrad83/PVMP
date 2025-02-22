
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pvmp/bloc/provider/routine_provider.dart';
import 'package:pvmp/bloc/state/choose_routine_state.dart';
import 'package:pvmp/utilities/logger.dart';

class ChooseRoutineCubit extends Cubit<ChooseRoutineState> {
  ChooseRoutineCubit() : super(ChooseRoutineState());

  void setError({required bool isError, String errorMessage = ""}){
    emit(state.copyWith(isError: isError, errorMessage: errorMessage, isLoading: false));
  }

  void getAllRoutinesLastSeries() async {
    try {
      Response response = await RoutineProvider.getAllRoutinesLastSeries();
      int? statusCode = response.statusCode;
      String data = response.data;

      if(statusCode! < 300){
        var responseData = json.decode(data);
        if(responseData["error"] == true){
          setError(isError: true, errorMessage: responseData["error_message"]);
        }else{
          emit(state.copyWith(isError: false, isLoading: false, routines: responseData["data"]));
        }
      }else{
        logger.e(json.decode(data));
        setError(isError: true, errorMessage: "Une erreur est survenue lors de la récupération des routines");
      }
    } catch (e) {
      logger.e(e);
      setError(isError: true, errorMessage: "Une erreur est survenue lors de la récupération des routines");
    }
  }
}