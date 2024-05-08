import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path_provider/path_provider.dart';

class BaseProvider{

  static Future<Dio> getDio() async{
    BaseOptions options = BaseOptions(
        baseUrl: dotenv.env["BASE_URL_${dotenv.env["ENV"]}"]!,
        headers: {
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

}