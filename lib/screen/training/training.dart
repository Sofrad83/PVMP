import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pvmp/bloc/cubit/connexion_cubit.dart';
import 'package:pvmp/bloc/cubit/training_cubit.dart';
import 'package:pvmp/bloc/state/training_state.dart';
import 'package:pvmp/flutter_flow/flutter_flow_theme.dart';
import 'package:pvmp/models/json_model.dart';
import 'package:pvmp/screen/training/congrat.dart';
import 'package:pvmp/utilities/logger.dart';
import 'package:pvmp/widgets/chronometer.dart';
import 'package:pvmp/widgets/my_ff_button.dart';
import 'package:pvmp/widgets/page_header.dart';
import 'package:pvmp/widgets/serie_table.dart';

class TrainingScreen extends StatelessWidget {
  TrainingScreen({super.key});
  static const routeName = "TrainingScreen";

  void endSeance(BuildContext myContext, Json routine, FlutterFlowTheme theme){
    if(checkSeriesDone(routine)){
      showDialog<void>(
        context: myContext,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Voulez-vous vraiment terminer la séance ?', style: GoogleFonts.getFont("Urbanist")),
            actions: <Widget>[
              TextButton(onPressed: () => Navigator.of(context).pop(), child: Text("Annuler", style: GoogleFonts.getFont("Urbanist"))),
              TextButton(onPressed: () {
                Navigator.of(context).pop();
                myContext.read<TrainingCubit>().storeSeance(routine: routine);
              }, child: Text("Terminer", style: GoogleFonts.getFont("Urbanist"),))
            ],
          );
        },
      );
    }else{
      Flushbar(
        messageText: Text("Complétez toutes vos séries pour terminer la séance", style: theme.bodyMedium,),
        backgroundColor: theme.error,
        duration: const Duration(seconds: 3),
        flushbarPosition: FlushbarPosition.BOTTOM,
        flushbarStyle: FlushbarStyle.FLOATING,
      ).show(myContext);
    }
  }

  bool checkSeriesDone(Json routine){
    bool done = true;
    (routine["exercices"] as List).forEach((exercice) {
      (exercice["series"] as List).forEach((serie) {
        if(serie["done"] != true){
          done = false;
        }
      });
    });
    return done;
  }

  @override
  Widget build(BuildContext context) {
    FlutterFlowTheme theme = FlutterFlowTheme.of(context);
    Json routine = ModalRoute.of(context)!.settings.arguments as Json;

    return BlocConsumer<TrainingCubit, TrainingState>(
      listener: (context, state) {
        if (state is TrainingErrorState) {
              logger.e(state.error);
              Flushbar(
                messageText: Text(state.error, style: theme.bodyMedium,),
                backgroundColor: theme.error,
                duration: const Duration(seconds: 3),
                flushbarPosition: FlushbarPosition.BOTTOM,
                flushbarStyle: FlushbarStyle.FLOATING,
              ).show(context);
            }
      },
      builder: (context, state) {
        if(state is TrainingLoadingState){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<TrainingCubit>().init(routine: routine);
          });
        }
        if(state is TrainingStoreDoneState){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushNamedAndRemoveUntil(CongratScreen.routeName, (route) => false);
          });
        }
        return SafeArea(
          child: Scaffold(
              backgroundColor: theme.secondaryBackground,
              body: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    "assets/images/bg/5.jpg",
                    fit: BoxFit.cover,
                    opacity: const AlwaysStoppedAnimation(.2),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              16.0, 0.0, 16.0, 0.0),
                                      child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            PageHeader(
                                              headerTitle: "S'exercer",
                                              headerDescription: "Entrainement",
                                              logoutCallback: () => context
                                                  .read<ConnexionCubit>()
                                                  .logout(),
                                            ),
                                          ]),
                                    ),
                                    state is TrainingLoadedState ?
                                    Column(
                                      children: [
                                        MyFfButton(
                                          label: "Terminer la séance",
                                          onPressed: () =>
                                              endSeance(context, routine, theme),
                                          width: 90.w,
                                        ),
                                        Divider(
                                          color: theme.lineColor,
                                        ),
                                        Column(
                                          children: state.routine["exercices"]
                                              .map<Widget>((e) => SerieTable(
                                                    exercice: e,
                                                  ))
                                              .toList(),
                                        ),
                                        Divider(
                                          color: theme.lineColor,
                                        ),
                                        MyFfButton(
                                          label: "Terminer la séance",
                                          onPressed: () =>
                                              endSeance(context, routine, theme),
                                          width: 90.w,
                                        ),
                                        SizedBox(
                                          height: 12.h,
                                        )
                                      ],
                                    ) : Center(child: CircularProgressIndicator(color: theme.primary),)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 10.h,
                        decoration: BoxDecoration(
                            color: theme.primaryBackground,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25)),
                            border: Border.all(color: theme.lineColor)),
                        child: Chronometer(),
                      )
                    ],
                  )
                ],
              )),
        );
      },
    );
  }
}
