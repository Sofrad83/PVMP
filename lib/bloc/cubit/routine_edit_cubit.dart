import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pvmp/bloc/provider/routine_provider.dart';
import 'package:pvmp/bloc/state/routine_edit_state.dart';
import 'package:pvmp/utilities/logger.dart';

class RoutineEditCubit extends Cubit<RoutineEditState> {
  RoutineEditCubit() : super(RoutineEditState());

  void init({required int id}){
    emit(state.copyWith(needToInit: false, id: id));
  }

  void reload(){
    emit(state.copyWith());
  }

  void error(String error){
    emit(state.copyWith(errorMessage: error, isError: true));
  }
  void resetError(){
    emit(state.copyWith(isError: false));
  }

  void reset(){
    emit(RoutineEditState());
  }

  void store({
    required String nom,
    required String description,
    required List exos,
    int? id
  }) async {
    try {
      Response response = await RoutineProvider.store(id: id, nom: nom, description: description, exos: exos);
      int? statusCode = response.statusCode;
      String rep = response.data;

      if(statusCode! < 300){
        var responseData = json.decode(rep);
        emit(state.copyWith(isError: false, storeDone: true, storeMessage: responseData["message"]));
      }else{
        emit(state.copyWith(isError: true, errorMessage: "Une erreur est survenue lors de l'enregistrement de la routine"));
      }
    } on DioException catch (e) {
      logger.e(e);
      emit(state.copyWith(isError: true, errorMessage: "Une erreur est survenue lors de l'enregistrement de la routine"));
    }
  }
  
}