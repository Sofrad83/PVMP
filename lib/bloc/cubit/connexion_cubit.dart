
import 'dart:convert';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pvmp/bloc/state/connexion_state.dart';
import 'package:pvmp/models/connexion.dart';
import 'package:pvmp/config/PVMPConfigLOCAL.dart' as PVMPConfig;
import 'package:pvmp/models/user.dart';
import 'package:pvmp/utilities/logger.dart';

class ConnexionCubit extends Cubit<ConnexionState> {
  ConnexionCubit() : super(ConnexionLoadingState());

  static Future<Dio> getDioInstance() async{
    /// Les options de base pour la requête http dio
    BaseOptions options = BaseOptions(
        baseUrl: PVMPConfig.BASE_URL,
        headers: {
          'MerchantId': PVMPConfig.MERCHAND_ID,
          'ApiKey': PVMPConfig.API_KEY,
          'Authorization': PVMPConfig.AUTHORIZATION,
          "Accept": "application/json"
        },
        responseType: ResponseType.plain,
        connectTimeout: Duration(milliseconds: 30000),
        receiveTimeout: Duration(milliseconds: 30000),
        persistentConnection: true,
        followRedirects: true,
        validateStatus: (code) {
          if (code! >= 200) {
            return true;
          }
          if(code < 500){
            return true;
          }
          return false;
        });

    
    Dio dio = Dio(options);

    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String appDocPath = appDocDir.path;
    final jar = PersistCookieJar(
      ignoreExpires: false,
      storage: FileStorage(appDocPath + "/.cookies/"),
    );
    dio.interceptors.add(CookieManager(jar));

    return dio;
  }

  Future<void> getSession() async {
    try {
      Response response = await (await getDioInstance()).get('/');
      int? statusCode = response.statusCode;
      String data = response.data;
      var responseJson = json.decode(data);
      Logger().d(data);
      
      switch (statusCode) {
        case 200:
        case 201:
          emit(ConnexionLoadedState(Connexion(user: User.fromJson(responseJson["data"]))));

          break;
        case 401:
          emit(ConnexionLoadedState(null));
          break;
        default:
          emit(ConnexionErrorState(statusCode.toString()));
      }
    } on DioException catch (exception) {
      logger.e(exception);
      emit(ConnexionErrorState("Impossible de récupérer la session"));
    }
  }

  Future<void> register(String name, String mail, String mdp) async {
    try {
      Response response = await (await getDioInstance()).post('/register', data: {
        'name' : name,
        'email' : mail,
        'password' : mdp,
      });
      int? statusCode = response.statusCode;
      String data = response.data;

      if(statusCode! < 300){
        var responseData = json.decode(data);
        if(responseData["error"] == true){
          emit(ConnexionErrorState(responseData["error_message"]));
        }else{
          //On complète la connexion
          emit(ConnexionLoadedState(Connexion(user: User.fromJson(responseData["user"]))));
        }
      }else{
        emit(ConnexionErrorState(data));
      }
    } on DioException catch (e) {
      emit(ConnexionErrorState(e.message.toString()));
    }
  }

  Future<void> login(String mail, String mdp) async {
    try {
      Response response = await (await getDioInstance()).post('/login', data: {
        'email' : mail,
        'password' : mdp,
      });
      int? statusCode = response.statusCode;
      String data = response.data;
      
      switch (statusCode) {
        case 200:
        case 201:
          var responseData = json.decode(data);
          if(responseData["error"] == true){
            emit(ConnexionErrorState(responseData["error_message"]));
          }else{
            //On complète la connexion
            emit(ConnexionLoadedState(Connexion(user: User.fromJson(responseData["data"]))));
          }
          break;
        default:
          emit(ConnexionErrorState(data));
      }
    } on DioException catch (e) {
      print(e);
    }
  }

  Future<void> logout() async {
    try {
      Response response = await (await getDioInstance()).post('/logout');
      int? statusCode = response.statusCode;
      String data = response.data;
      
      switch (statusCode) {
        case 200:
        case 201:
          var responseData = json.decode(data);
          if(responseData["error"] == true){
            emit(ConnexionErrorState(responseData["error_message"]));
          }else{
            //On complète la connexion
            emit(ConnexionLoadedState(null));
          }
          break;
        default:
          emit(ConnexionErrorState(data));
      }
    } on DioException catch (e) {
      print(e);
    }
  }
}