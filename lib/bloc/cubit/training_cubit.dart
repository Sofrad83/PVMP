import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pvmp/bloc/cubit/connexion_cubit.dart';
import 'package:pvmp/bloc/state/training_state.dart';
import 'package:pvmp/models/json_model.dart';
import 'package:pvmp/utilities/logger.dart';

class TrainingCubit extends Cubit<TrainingState> {
  TrainingCubit() : super(TrainingLoadingState());

  void reset(){
    emit(TrainingLoadingState());
  }

  void init({required Json routine}){
    (routine["exercices"] as List).forEach((exo) {
      (exo["series"] as List).forEach((serie) {
        (serie as Json).addAll({"done" : false});
      });
    });
    logger.d(routine);

    emit(TrainingLoadedState(routine: routine));
  }

  void removeSerie({required Json serie}){
    Json maRoutine = (state as TrainingLoadedState).routine;
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

    emit(TrainingLoadedState(routine: maRoutine));
  }

  void confirmSerie({required Json serie}){
    Json maRoutine = (state as TrainingLoadedState).routine;
    (maRoutine["exercices"] as List).forEach((exo) {
      (exo["series"] as List).forEach((maSerie) {
        if(maSerie["serie_number"] == serie["serie_number"] && maSerie["exercice_id"] == serie["exercice_id"]){
          maSerie["done"] = true;
        }
      });
    });

    emit(TrainingLoadedState(routine: maRoutine));
  }

  void addSerie({required Json serie}){
    Json maRoutine = (state as TrainingLoadedState).routine;
    (maRoutine["exercices"] as List).forEach((exo) {
      if(exo['id'] == serie['exercice_id']){
        serie["done"] = true;
        (exo['series'] as List).add(serie);
        (exo["series"] as List).asMap().forEach((index, maSerie) {
          maSerie["serie_number"] = index + 1;
        });
      }
    });
    
    emit(TrainingLoadedState(routine: maRoutine));
  }

  Future<void> storeSeance({required Json routine}) async{
    try {
      List mesSeries = [];
      (routine["exercices"] as List).forEach((exercice) {
        mesSeries.addAll(exercice["series"]);
      });
      Map<String, dynamic> data = {
        "series" : json.encode(mesSeries),
      };
      FormData formData = FormData.fromMap(data);


      Dio dio = await ConnexionCubit.getDioInstance();
      Response response = await dio.post('/seance/store', data: formData);
      int? statusCode = response.statusCode;
      Json responseData = json.decode(response.data);

      if(statusCode! < 300){
        emit(TrainingStoreDoneState(volumeLastSeance: double.parse(responseData["data"]["volume"].toString())));
      }else{
        emit(TrainingErrorState("Une erreur est survenue lors de l'enregistrement de la séance"));
      }
    } on DioException catch (e) {
      print(e);
    }
  }
}