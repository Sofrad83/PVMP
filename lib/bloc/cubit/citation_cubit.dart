
import 'dart:convert';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pvmp/bloc/state/citation_state.dart';
import 'package:pvmp/bloc/state/connexion_state.dart';
import 'package:pvmp/models/citation.dart';
import 'package:pvmp/models/connexion.dart';
import 'package:pvmp/config/PVMPConfigLOCAL.dart' as PVMPConfig;
import 'package:pvmp/models/user.dart';

class CitationCubit extends Cubit<CitationState> {
  CitationCubit({required this.dio}) : super(CitationLoadingState());
  Dio dio;

  Future<void> getRandomCitation() async {
    try {
      Response response = await dio.get('/citation/rand');
      int? statusCode = response.statusCode;
      String data = response.data;

      Logger().d(data);

      if(statusCode! < 300){
        var responseData = json.decode(data);
        if(responseData["error"] == true){
          emit(CitationErrorState(responseData["error_message"]));
        }else{
          //On complète la connexion
          emit(CitationLoadedState(Citation.fromJson(responseData)));
        }
      }else{
        emit(CitationErrorState(data));
      }
    } on DioException catch (e) {
      emit(CitationErrorState(e.message.toString()));
    }
  }
}