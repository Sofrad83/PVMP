
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pvmp/bloc/provider/exercice_provider.dart';
import 'package:pvmp/bloc/state/select_exercice_state.dart';
import 'package:pvmp/utilities/logger.dart';

class SelectExerciceCubit extends Cubit<SelectExerciceState> {
  SelectExerciceCubit() : super(SelectExerciceState());

  void search(String? search){
    emit(state.copyWith(search: search, isLoading: true));
  }

  void reload(){
    emit(state.copyWith());
  }

  void setError({required bool isError, String errorMessage = ""}){
    emit(state.copyWith(isError: isError, errorMessage: errorMessage, isLoading: false));
  }

  Future<void> getExercices() async {
    try {
      Response response = await ExerciceProvider.getExercices(search: state.search);
      int? statusCode = response.statusCode;
      String data = response.data;
      if(statusCode! < 300){
        var responseData = json.decode(data);
        if(responseData["error"] == true){
          setError(isError: true, errorMessage: responseData["error_message"]);
        }else{
          emit(state.copyWith(isError: false, isLoading: false, exercices: responseData["data"]));
        }
      }else{
        setError(isError: true, errorMessage: "Une erreur est survenue lors de la rechercher des exercices");
      }
    } catch (e) {
      logger.e(e);
      setError(isError: true, errorMessage: "Une erreur est survenue lors de la rechercher des exercices");
    }
  }
}