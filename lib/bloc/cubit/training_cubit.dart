import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pvmp/bloc/provider/seance_provider.dart';
import 'package:pvmp/bloc/state/training_state.dart';
import 'package:pvmp/models/json_model.dart';
import 'package:pvmp/utilities/logger.dart';

class TrainingCubit extends Cubit<TrainingState> {
  TrainingCubit() : super(TrainingState());

  void setError({required bool isError, String errorMessage = ""}){
    emit(state.copyWith(isError: isError, errorMessage: errorMessage, isLoading: false));
  }

  void init({required Json routine}){
    (routine["exercices"] as List).forEach((exo) {
      (exo["series"] as List).forEach((serie) {
        (serie as Json).addAll({"done" : false});
      });
    });
    logger.d(routine);

    emit(state.copyWith(routine: routine, isLoading: false));
  }

  setZoom({required bool zoom, String zoomUrl = ""}){
    emit(state.copyWith(zoom: zoom, zoomUrl: zoomUrl));
  }

  void removeSerie({required Json serie}){
    Json maRoutine = state.routine!;
    (maRoutine["exercices"] as List).forEach((exo) {
      Json? serieToRemove;
      (exo["series"] as List).forEach((maSerie) {
        if(maSerie["serie_number"] == serie["serie_number"] && maSerie["exercice_id"] == serie["exercice_id"]){
          if(maSerie["done"]){
            serieToRemove = maSerie;
          }
        }
      });
      if(serieToRemove != null){
        (exo["series"] as List).removeWhere((element) => element["serie_number"] == serieToRemove!["serie_number"]);
        (exo["series"] as List).asMap().forEach((index, maSerie) {
          maSerie["serie_number"] = index + 1;
        });
      }
    });

    emit(state.copyWith(routine: maRoutine));
  }

  void confirmSerie({required Json serie}){
    Json maRoutine = state.routine!;
    (maRoutine["exercices"] as List).forEach((exo) {
      (exo["series"] as List).forEach((maSerie) {
        if(maSerie["serie_number"] == serie["serie_number"] && maSerie["exercice_id"] == serie["exercice_id"]){
          maSerie["done"] = true;
        }
      });
    });

    emit(state.copyWith(routine: maRoutine));
  }

  void addSerie({required Json serie}){
    Json maRoutine = state.routine!;
    (maRoutine["exercices"] as List).forEach((exo) {
      if(exo['id'] == serie['exercice_id']){
        serie["done"] = true;
        (exo['series'] as List).add(serie);
        (exo["series"] as List).asMap().forEach((index, maSerie) {
          maSerie["serie_number"] = index + 1;
        });
      }
    });
    
    emit(state.copyWith(routine: maRoutine));
  }

  Future<void> storeSeance({required Json routine}) async{
    try {
      Response response = await SeanceProvider.store(routine: routine);
      int? statusCode = response.statusCode;
      Json responseData = json.decode(response.data);

      if(statusCode! < 300){
        emit(state.copyWith(storeDone: true, volume: double.parse(responseData["data"]["volume"].toString())));
      }else{
        setError(isError: true, errorMessage: "Une erreur est survenue lors de l'enregistrement de la séance");
      }
    } on DioException catch (e) {
      logger.e(e);
      setError(isError: true, errorMessage: "Une erreur est survenue lors de l'enregistrement de la séance");
    }
  }
}