import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pvmp/flutter_flow/flutter_flow_theme.dart';
import 'package:pvmp/providers/auth.dart';
import 'package:pvmp/providers/users.dart';
import 'package:pvmp/screen/auth/forgot_password.dart';
import 'package:pvmp/screen/auth/login.dart';
import 'package:pvmp/screen/home.dart';
import 'package:pvmp/screen/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ThemeMode _themeMode = FlutterFlowTheme.themeMode;
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, Users?>(
            create: (_) => Users(),
            update: (context, auth, users) => users?..update(auth),
          ),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'PVMP',
              theme: ThemeData(
                  brightness: Brightness.light,
              ),
              darkTheme: ThemeData(
                brightness: Brightness.dark,
              ),
              themeMode: _themeMode,
              initialRoute: Splashscreen.routeName,
              routes: {
                Splashscreen.routeName : (ctx) => Splashscreen(),
                HomePageScreen.routeName : (ctx) => HomePageScreen(),
                Login.routeName : (ctx) => Login(),
                ForgotPasswordPage.routeName : (ctx) => ForgotPasswordPage()
              },),
        ));
  }
}