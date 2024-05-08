import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:pvmp/bloc/cubit/congrat_cubit.dart';
import 'package:pvmp/bloc/cubit/session_cubit.dart';
import 'package:pvmp/bloc/pvmp_observer.dart';
import 'package:pvmp/bloc/state/session_state.dart';
import 'package:pvmp/flutter_flow/flutter_flow_theme.dart';
import 'package:pvmp/screen/auth/forgot_password.dart';
import 'package:pvmp/screen/auth/login.dart';
import 'package:pvmp/screen/auth/register.dart';
import 'package:pvmp/screen/home.dart';
import 'package:pvmp/screen/leaderboard.dart';
import 'package:pvmp/screen/my_account.dart';
import 'package:pvmp/screen/my_friends.dart';
import 'package:pvmp/screen/routine.dart';
import 'package:pvmp/screen/routine_edit.dart';
import 'package:pvmp/screen/splashscreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pvmp/screen/training/choose_routine.dart';
import 'package:pvmp/screen/training/congrat.dart';
import 'package:pvmp/screen/training/training.dart';
import 'package:pvmp/screen/training_plan.dart';

void main() async{
  await dotenv.load(fileName: ".env");
  Bloc.observer = PvmpObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    final ThemeMode themeMode = FlutterFlowTheme.themeMode;
    return MultiBlocProvider(
        //Ici on met uniquement le cubit qui doivent être accéder partout
        providers: [
          BlocProvider(
            create: (context) => SessionCubit(),
          ),
          BlocProvider(
            create: (context) => CongratCubit(),
          ),
        ],
        child: BlocListener<SessionCubit, SessionState>(
          listener: (context, state) {
            if (state.isError) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Flushbar(
                  messageText: Text(
                    state.errorMessage!,
                    style: FlutterFlowTheme.of(context).bodyMedium,
                  ),
                  backgroundColor: FlutterFlowTheme.of(context).error,
                  duration: const Duration(seconds: 3),
                  flushbarPosition: FlushbarPosition.BOTTOM,
                  flushbarStyle: FlushbarStyle.FLOATING,
                ).show(context).then((value) => context.read<SessionCubit>().setError(isError: false));
              });
            }
            if (state.connexion == null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                navigatorKey.currentState!.pushReplacementNamed(Login.routeName);
              });
            }
          },
          child: FlutterSizer(builder: (context, orientation, screenType) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              navigatorKey: navigatorKey,
              title: 'PVMP',
              theme: ThemeData(
                brightness: Brightness.light,
              ),
              darkTheme: ThemeData(
                brightness: Brightness.dark,
              ),
              themeMode: themeMode,
              initialRoute: Splashscreen.routeName,
              routes: {
                Splashscreen.routeName: (ctx) => Splashscreen(),
                HomePageScreen.routeName: (ctx) => HomePageScreen(),
                Login.routeName: (ctx) => Login(),
                Register.routeName: (ctx) => Register(),
                ForgotPasswordPage.routeName: (ctx) => ForgotPasswordPage(),
                RoutineScreen.routeName: (ctx) => RoutineScreen(),
                ChooseRoutineScreen.routeName: (ctx) => ChooseRoutineScreen(),
                LeaderBoardScreen.routeName: (ctx) => LeaderBoardScreen(),
                TrainingPlanScreen.routeName: (ctx) => TrainingPlanScreen(),
                MyFriendsScreen.routeName: (ctx) => MyFriendsScreen(),
                MyAccountScreen.routeName: (ctx) => MyAccountScreen(),
                RoutineEditScreen.routeName: (ctx) => RoutineEditScreen(),
                TrainingScreen.routeName: (ctx) => TrainingScreen(),
                CongratScreen.routeName: (ctx) => CongratScreen(),
              },
            );
          }),
        ));
  }
}
