import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:pvmp/bloc/cubit/citation_cubit.dart';
import 'package:pvmp/bloc/cubit/connexion_cubit.dart';
import 'package:pvmp/bloc/pvmp_observer.dart';
import 'package:pvmp/bloc/state/connexion_state.dart';
import 'package:pvmp/flutter_flow/flutter_flow_theme.dart';
import 'package:pvmp/providers/auth.dart';
import 'package:pvmp/providers/users.dart';
import 'package:pvmp/screen/auth/forgot_password.dart';
import 'package:pvmp/screen/auth/login.dart';
import 'package:pvmp/screen/auth/register.dart';
import 'package:pvmp/screen/home.dart';
import 'package:pvmp/screen/leaderboard.dart';
import 'package:pvmp/screen/my_account.dart';
import 'package:pvmp/screen/my_friends.dart';
import 'package:pvmp/screen/routine.dart';
import 'package:pvmp/screen/splashscreen.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pvmp/screen/training/choose_routine.dart';
import 'package:pvmp/screen/training_plan.dart';

void main() {
  Bloc.observer = PvmpObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ThemeMode themeMode = FlutterFlowTheme.themeMode;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ConnexionCubit(),
        ),
      ], 
      child: BlocConsumer<ConnexionCubit, ConnexionState>(
        listener: (context, state) {
          if(state is ConnexionErrorState) {
            Logger().e(state.error);
          }
        },
        builder: (context, state) {
          if(state is ConnexionLoadingState){
            context.read<ConnexionCubit>().createDioInstance();
          }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
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
              Splashscreen.routeName : (ctx) => Splashscreen(),
              HomePageScreen.routeName : (ctx) => HomePageScreen(),
              Login.routeName : (ctx) => Login(),
              Register.routeName : (ctx) => Register(),
              ForgotPasswordPage.routeName : (ctx) => ForgotPasswordPage(),
              RoutineScreen.routeName : (ctx) => RoutineScreen(),
              ChooseRoutineScreen.routeName : (ctx) => ChooseRoutineScreen(),
              LeaderBoardScreen.routeName : (ctx) => LeaderBoardScreen(),
              TrainingPlanScreen.routeName : (ctx) => TrainingPlanScreen(),
              MyFriendsScreen.routeName : (ctx) => MyFriendsScreen(),
              MyAccountScreen.routeName : (ctx) => MyAccountScreen(),
            },);
        },
      )
    );
  }
}