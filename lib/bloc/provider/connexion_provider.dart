import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pvmp/bloc/provider/base_provider.dart';

class ConnexionProvider{
  static Future<Response> getSession () async{
    Dio dio = await BaseProvider.getDio();
    return dio.get('/');
  }

  static Future<Response> login ({required String mail, required String mdp}) async{
    Dio dio = await BaseProvider.getDio();
    return dio.post('/login', data: {
      'email' : mail,
      'password' : mdp,
    });
  }

  static Future<Response> register ({required String name, required String mail, required String mdp}) async{
    Dio dio = await BaseProvider.getDio();
    return dio.post('/register', data: {
      'name' : name,
      'email' : mail,
      'password' : mdp,
    });
  }

  static Future<Response> logout () async{
    Dio dio = await BaseProvider.getDio();
    return dio.post('/logout');
  }
}