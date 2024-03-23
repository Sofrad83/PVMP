import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:pvmp/bloc/cubit/connexion_cubit.dart';
import 'package:pvmp/bloc/state/connexion_state.dart';
import 'package:pvmp/models/connexion.dart';
import 'package:pvmp/providers/auth.dart';
import 'package:pvmp/screen/auth/login.dart';
import 'package:pvmp/screen/home.dart';

class Splashscreen extends StatelessWidget {
  Splashscreen({Key? key});
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
        return Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset("assets/images/splash.png", fit: BoxFit.cover,),
              Center(
                child: Image.asset("assets/images/logo-transparent.png",),
              )
            ],
          ),
        );
      },
    );
  }
}

// class _SplashscreenState extends State<Splashscreen> {

//   final scaffoldKey = GlobalKey<ScaffoldState>();

//   void initSession() async{
//     try{
      
//       Auth _authP = Provider.of<Auth>(context, listen: false);
//       _authP.createDioInstance();
//       await _authP.getSession();
//       if(_authP.isLogged == true){
//         Future.delayed(const Duration(seconds: 3), () {
//           Navigator.of(context).pushReplacementNamed(HomePageScreen.routeName);
//         });
//       }else{
//         Future.delayed(const Duration(seconds: 3), () {
//           Navigator.of(context).pushReplacementNamed(Login.routeName);
//         });
//       }
//     } on FormatException catch(e){
//       print(e);
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     initSession();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

  
// }