import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:pvmp/config/PVMPConfigLOCAL.dart';
import 'package:pvmp/models/connexion.dart';
import 'package:pvmp/models/user.dart';
import 'package:pvmp/providers/auth.dart';

/// Gestion de l'authentification avec le package provider
class Users with ChangeNotifier {
  void update(Auth auth) {
    // Do some custom work based on myModel that may call `notifyListeners`
    cnx = auth.connexion;
    notifyListeners();
  }

  // Reset toutes les données (utile pour logof)
  void clear() {
    print('Clean de users');
    cnx = null;
    notifyListeners();
  }

  /// Utile pour les tests unitaires (voir test/api_traders_test.dart)
  int? responseStatusCode;
  String? responseStatusMessage;

  Connexion? cnx;

  User? _user;

  User get user {
    return _user!;
  }

  set user(value) {
    _user = value;
    notifyListeners();
  }

  /// Les options de base pour la requête http dio
  static BaseOptions options = BaseOptions(
      baseUrl: PVMPConfig.BASE_URL,
      headers: {
        'MerchantId': PVMPConfig.MERCHAND_ID,
        'ApiKey': PVMPConfig.API_KEY,
        'Authorization': PVMPConfig.AUTHORIZATION
      },
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

  
}
