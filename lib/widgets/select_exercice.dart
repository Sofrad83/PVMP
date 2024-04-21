
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pvmp/bloc/cubit/select_exercice_cubit.dart';
import 'package:pvmp/bloc/state/select_exercice_state.dart';
import 'package:pvmp/flutter_flow/flutter_flow_widgets.dart';
import 'package:pvmp/flutter_flow/form_field_controller.dart';
import 'package:pvmp/models/json_model.dart';
import 'package:pvmp/widgets/select_exercice_row.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class SelectExercice extends StatelessWidget {
  const SelectExercice(
      {super.key, required this.controller, required this.onPressed});
  final FormFieldController controller;
  final Function onPressed;

  bool checkIn(exo) {
    bool retour = false;
    (controller.value as List).forEach((element) {
      if (element["id"] == exo["id"]) {
        retour = true;
      }
    });
    return retour;
  }

  void removeIn(exo) {
    Json? exoToRemove;
    (controller.value as List).forEach((element) {
      if (element["id"] == exo["id"]) {
        exoToRemove = element;
      }
    });
    (controller.value as List).remove(exoToRemove);
  }

  void addIn(exo) {
    (controller.value as List).add(exo);
  }

  @override
  Widget build(BuildContext context) {
    FlutterFlowTheme theme = FlutterFlowTheme.of(context);
    return BlocProvider(
      create: (context) => SelectExerciceCubit(),
      child: BlocBuilder<SelectExerciceCubit, SelectExerciceState>(
        builder: (context, state) {
          if (state.isLoading) {
            context.read<SelectExerciceCubit>().getExercices();
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextField(
                onChanged: (value) {
                  if (value.length > 2 || value.isEmpty) {
                    context.read<SelectExerciceCubit>().search(value);
                  }
                },
                style: theme.bodyMedium,
                decoration: InputDecoration(
                    hintText: "Rechercher",
                    labelStyle: theme.labelMedium,
                    prefixIcon: Padding(
                        padding: const EdgeInsets.all(10),
                        child: FaIcon(
                          FontAwesomeIcons.magnifyingGlass,
                          color: theme.primaryText,
                        )),
                    focusColor: theme.primaryText),
              ),
              state.isLoading
                  ? Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                          height: 60.h,
                          child: Column(children: [
                            CircularProgressIndicator(
                              color: theme.primaryText,
                            )
                          ])),
                    )
                  : Container(
                      height: 60.h,
                      child: ListView(
                        children: state.exercices!.map((exo) {
                          return SelectRow(
                            exo: exo,
                            checked: checkIn(exo),
                            onTap: () {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                if (checkIn(exo)) {
                                  removeIn(exo);
                                  (controller.value as List).remove(exo);
                                } else {
                                  addIn(exo);
                                }
                                context.read<SelectExerciceCubit>().reload();
                              });
                            },
                          );
                        }).toList(),
                      )),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: FFButtonWidget(
                    text:
                        "Enregistrer les exercices (${(controller.value as List).length})",
                    onPressed: () {
                      onPressed();
                      Navigator.of(context).pop();
                    },
                    options: FFButtonOptions(
                      width: 90.w,
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 0.0),
                      iconPadding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle: FlutterFlowTheme.of(context)
                          .titleSmall
                          .override(
                            fontFamily:
                                FlutterFlowTheme.of(context).titleSmallFamily,
                            color: Colors.white,
                            useGoogleFonts: GoogleFonts.asMap()
                                .containsKey(theme.titleSmallFamily),
                          ),
                      elevation: 3.0,
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    )),
              )
            ],
          );
        },
      ),
    );
  }
}

// class _SelectExerciceState extends State<SelectExercice> {

  

//   @override
//   Widget build(BuildContext context) {
    

//     return BlocConsumer<ConnexionCubit, ConnexionState>(
//       listener: (context, state) {
//         if (state is ConnexionLoadedState) {
//           if (state.connexion == null) {
//             WidgetsBinding.instance.addPostFrameCallback((_) {
//               Navigator.of(context)
//                   .pushNamedAndRemoveUntil(Login.routeName, (route) => false);
//             });
//           }
//         }
//       },
//       builder: (context, state) {
        
//         return BlocConsumer<ExerciceCubit, ExerciceState>(
//             listener: (context, state) {
//               if (state is ExerciceErrorState) {
//                 Logger().e(state.error);
//                 Flushbar(
//                   messageText: Text(
//                     state.error,
//                     style: theme.bodyMedium,
//                   ),
//                   backgroundColor: theme.error,
//                   duration: const Duration(seconds: 3),
//                   flushbarPosition: FlushbarPosition.BOTTOM,
//                   flushbarStyle: FlushbarStyle.FLOATING,
//                 ).show(context);
//               }
//             },
//             builder: (context, state) {
//               if(state is ExerciceLoadingState){
//                 context.read<ExerciceCubit>().getExercices();
//               }
              
//             },
//           );
//       },
//     );
//   }
// }
