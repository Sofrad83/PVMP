import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pvmp/bloc/provider/base_provider.dart';
import 'package:pvmp/models/json_model.dart';

class SeanceProvider{
  static Future<Response> store ({required Json routine}) async{
    Dio dio = await BaseProvider.getDio();
    List mesSeries = [];
    (routine["exercices"] as List).forEach((exercice) {
      mesSeries.addAll(exercice["last_series"]);
    });
    Map<String, dynamic> data = {
      "series" : json.encode(mesSeries),
    };
    FormData formData = FormData.fromMap(data);
    return dio.post('/seance/store', data: formData);
  }
}