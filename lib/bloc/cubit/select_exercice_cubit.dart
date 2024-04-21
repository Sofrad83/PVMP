
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pvmp/bloc/provider/exercice_provider.dart';
import 'package:pvmp/bloc/state/select_exercice_state.dart';

class SelectExerciceCubit extends Cubit<SelectExerciceState> {
  SelectExerciceCubit() : super(SelectExerciceState());

  void search(String? search){
    emit(state.copyWith(search: search, isLoading: true));
  }

  void reload(){
    emit(state.copyWith());
  }

  Future<void> getExercices() async {
    try {
      Response response = await ExerciceProvider.getExercices(search: state.search);
      int? statusCode = response.statusCode;
      String data = response.data;
      if(statusCode! < 300){
        var responseData = json.decode(data);
        if(responseData["error"] == true){
          emit(state.copyWith(isError: true, isLoading: false, errorMessage: responseData["error_message"]));
        }else{
          emit(state.copyWith(isError: false, isLoading: false, exercices: responseData["data"]));
        }
      }else{
        emit(state.copyWith(isError: true, isLoading: false, errorMessage: "Une erreur est survenue lors de la rechercher des exercices"));
      }
    } on DioException catch (e) {
      emit(state.copyWith(isError: true, isLoading: false, errorMessage: "Une erreur est survenue lors de la rechercher des exercices"));
    }
  }
}