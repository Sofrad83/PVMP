import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:pvmp/bloc/cubit/connexion_cubit.dart';
import 'package:pvmp/bloc/state/connexion_state.dart';
import 'package:pvmp/screen/auth/login.dart';
import 'package:pvmp/screen/home.dart';
import 'package:pvmp/widgets/fade_in_zoom_in.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});
  static const routeName = "Splashscreen";
  
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConnexionCubit, ConnexionState>(
      listener: (context, state) {

        if(state is ConnexionErrorState) {
          Logger().e(state.error);
        }

      },
      builder: (context, state) {
        if(state is ConnexionLoadingState){
          Future.delayed(
            const Duration(seconds: 1),
            (){
              context.read<ConnexionCubit>().getSession();
            }
          );
        }
        if(state is ConnexionLoadedState) {
          if(state.connexion == null){
            Future.delayed(
              const Duration(seconds: 3),
              (){
                Navigator.of(context).pushNamedAndRemoveUntil(Login.routeName, (route) => false);
              }
            );
          }else{
            Future.delayed(
              const Duration(seconds: 3),
              (){
                Navigator.of(context).pushNamedAndRemoveUntil(HomePageScreen.routeName, (route) => false);
              }
            );
          }
        }
        return SafeArea(
          child: Scaffold(
            body: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset("assets/images/splash.png", fit: BoxFit.cover,),
                Center(
                  child: FadeInZoomIn(child: Image.asset("assets/images/logo-transparent.png",)),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}