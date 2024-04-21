
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pvmp/bloc/provider/routine_provider.dart';
import 'package:pvmp/bloc/state/choose_routine_state.dart';
import 'package:pvmp/utilities/logger.dart';

class ChooseRoutineCubit extends Cubit<ChooseRoutineState> {
  ChooseRoutineCubit() : super(ChooseRoutineState());

  void getAllRoutinesLastSeries() async {
    try {
      Response response = await RoutineProvider.getAllRoutinesLastSeries();
      int? statusCode = response.statusCode;
      String data = response.data;

      if(statusCode! < 300){
        var responseData = json.decode(data);
        if(responseData["error"] == true){
          emit(state.copyWith(isError: true, isLoading: false, errorMessage: responseData["error_message"]));
        }else{
          emit(state.copyWith(isError: false, isLoading: false, routines: responseData["data"]));
        }
      }else{
        emit(state.copyWith(isError: true, isLoading: false, errorMessage: "Une erreur est survenue lors de la récupération des routines"));
      }
    } on DioException catch (e) {
      logger.e(e);
      emit(state.copyWith(isError: true, isLoading: false, errorMessage: "Une erreur est survenue lors de la récupération des routines"));
    }
  }
}