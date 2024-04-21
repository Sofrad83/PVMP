import 'package:dio/dio.dart';
import 'package:pvmp/bloc/provider/base_provider.dart';

class CitationProvider{
  static Future<Response> getRandomCitation () async{
    Dio dio = await BaseProvider.getDio();
    return dio.get('/citation/rand');
  }
}