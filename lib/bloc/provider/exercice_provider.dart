import 'package:dio/dio.dart';
import 'package:pvmp/bloc/provider/base_provider.dart';

class ExerciceProvider{
  static Future<Response> getExercices ({required String? search}) async{
    Dio dio = await BaseProvider.getDio();
    return dio.post('/exercice/search', data: {
      "search" : search
    });
  }
}