import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:pvmp/config/PVMPConfigLOCAL.dart';
import 'package:pvmp/models/connexion.dart';
import 'package:pvmp/providers/users.dart';

/// Gestion de l'authentification avec le package provider
class Auth with ChangeNotifier {
  Connexion? _cnx;
  Connexion? get connexion {
    return _cnx;
  }

  set connexion(Connexion? connexion) {
    _cnx = connexion;
    notifyListeners();
  }

  bool _isLogged = false;

  bool get islogged {
    return _isLogged;
  }

  set isLogged(bool value) {
    _isLogged = value;
    notifyListeners();
  }

  // Reset toutes les données (utile pour logof)
  void clear() {
    print('Clean de traders');
    connexion = null;
    isLogged = false;
    notifyListeners();
  }

  /// Log out
  void doLogOut(BuildContext context) {
    final users = Provider.of<Users>(context, listen: false);
    users.clear();
    clear();
  }

  /// Les options de base pour la requête http dio
  static BaseOptions options = BaseOptions(
      baseUrl: PVMPConfig.BASE_URL,
      // headers: {
      //   'MerchantId': PVMPConfig.MERCHAND_ID,
      //   'ApiKey': PVMPConfig.API_KEY,
      //   'Authorization': PVMPConfig.AUTHORIZATION
      // },
      responseType: ResponseType.plain,
      connectTimeout: Duration(milliseconds: 30000),
      receiveTimeout: Duration(milliseconds: 30000),
      validateStatus: (code) {
        if (code! >= 200) {
          return true;
        }

        return false;
      });

  static Dio dio = Dio(options);

  Future<void> getSession() async {
    try {
      Response response = await dio.post('/');
      int? statusCode = response.statusCode;
      String? data = response.data;

      print(statusCode);
      print(data);
      // switch (statusCode) {
      //   case 200:
      //   case 201:
      //     var responseJson = json.decode(response.data);
      //     print('responseJson loginByMail - API Auth: $responseJson');
      //     _cnx = Connexion.fromJson(responseJson);
      //     isLogged = true;
      //     break;
      //   case 401:
      //   case 404:
      //   case 500:
      //     responseStatusMessage = response.data;
      //     throw FormatException(responseStatusMessage!, responseStatusCode);
      //   default:
      //     throw FormatException("Erreur lors de la connexion");
      // }
    } on DioException catch (exception) {
      print(exception);
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
