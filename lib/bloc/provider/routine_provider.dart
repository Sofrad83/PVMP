import 'package:dio/dio.dart';
import 'package:pvmp/bloc/provider/base_provider.dart';

class RoutineProvider{
  static Future<Response> getAllRoutines () async{
    Dio dio = await BaseProvider.getDio();
    return dio.get('/routine/get-all');
  }

  static Future<Response> getAllRoutinesLastSeries () async{
    Dio dio = await BaseProvider.getDio();
    return dio.get('/routine/get-all-last-series');
  }

  static Future<Response> delete ({required int id}) async{
    Dio dio = await BaseProvider.getDio();
    Map<String, dynamic> data = {
      "id" : id
    };
    FormData formData = FormData.fromMap(data);
    return dio.post('/routine/delete', data: formData);
  }

  static Future<Response> store ({required int? id, required String nom, required String description, required List exos}) async{
    Dio dio = await BaseProvider.getDio();
    Map<String, dynamic> data = {
      "nom" : nom,
      "description" : description,
      "id" : id
    };
    List exosId = [];
    exos.forEach((element) {
      exosId.add(element["id"]);
    });
    data.addAll({"exos" : exosId.toString()});
    FormData formData = FormData.fromMap(data);
    return dio.post('/routine/store', data: formData);
  }
}