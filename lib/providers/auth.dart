import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:pvmp/config/PVMPConfigLOCAL.dart' as PVMPConfig;
import 'package:pvmp/flutter_flow/flutter_flow_theme.dart';
import 'package:pvmp/models/connexion.dart';
import 'package:pvmp/models/user.dart';
import 'package:pvmp/providers/users.dart';

/// Gestion de l'authentification avec le package provider
class Auth with ChangeNotifier {
  bool isLogged = false;

  Connexion? cnx;
  Dio? dio;

  void createDioInstance(){
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

    //on doit stocker la session dans les paramètres

    dio = Dio(options);
    CookieJar cookieJar = CookieJar();
    dio!.interceptors.add(CookieManager(cookieJar));
  }

  Future<void> getSession() async {
    try {
      Response response = await dio!.get('/');
      int? statusCode = response.statusCode;
      String data = response.data;
      
      switch (statusCode) {
        case 200:
        case 201:
          var responseJson = json.decode(data);
          if(responseJson["logged"] == true){
            isLogged = true;
          }else{
            isLogged = false;
          }
          break;
        case 401:
          isLogged = false;
          break;
        default:
          throw FormatException(data, statusCode);
      }
    } on DioException catch (exception) {
      print(exception);
    }
  }

  /// Log out
  void doLogOut(BuildContext context) {
    final users = Provider.of<Users>(context, listen: false);
    users.clear();
    clear();
  }

  // Reset toutes les données (utile pour logof)
  void clear() {
    print('Clean de AUTH');
    cnx = null;
    notifyListeners();
  }

  Future<void> login(String mail, String mdp) async {
    try {
      Response response = await dio!.post('/login', data: {
        'email' : mail,
        'password' : mdp,
      });
      int? statusCode = response.statusCode;
      String data = response.data;

      print(statusCode);
      print(data);
      
      switch (statusCode) {
        case 200:
        case 201:
          var responseData = json.decode(data);
          if(responseData["error"] == true){
            throw FormatException(responseData["error_message"]);
          }else{
            //On complète la connexion
            cnx = Connexion(user: User.fromJson(responseData["data"]));
          }
          break;
        default:
          throw FormatException(data, statusCode);
      }
    } on DioException catch (e) {
      print(e);
    }
  }

  /// Authentification
  // Future<void> loginByMail(
  //     String email, String password, String traderId) async {
  //   try {
  //     FormData formData = new FormData.fromMap(
  //         {"email": email, "password": password, "id_commercant": traderId});
  //     print(password);
  //     Response response =
  //         await dio.post('/utilisateur/connexion/admin', data: formData);
  //     responseStatusCode = response.statusCode;
  //     responseStatusMessage = response.data;
  //     switch (responseStatusCode) {
  //       case 200:
  //       case 201:
  //         var responseJson = json.decode(response.data);
  //         print('responseJson loginByMail - API Auth: $responseJson');
  //         _cnx = Connexion.fromJson(responseJson);
  //         isLogged = true;
  //         break;
  //       case 401:
  //       case 404:
  //       case 500:
  //         responseStatusMessage = response.data;
  //         throw FormatException(responseStatusMessage!, responseStatusCode);
  //       default:
  //         throw FormatException("Erreur lors de la connexion");
  //     }
  //   } on DioException catch (exception) {
  //     if (exception == null ||
  //         exception.toString().contains('SocketException')) {
  //       throw FormatException("Erreur réseau");
  //     } else if (exception.type == DioExceptionType.receiveTimeout ||
  //         exception.type == DioExceptionType.connectionTimeout) {
  //       throw FormatException(
  //           "Impossible de se connecter, assurer vous que votre réseau est stable.");
  //     } else {
  //       return null;
  //     }
  //   }
  // }
}
