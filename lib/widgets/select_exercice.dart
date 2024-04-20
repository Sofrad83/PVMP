import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:pvmp/bloc/cubit/connexion_cubit.dart';
import 'package:pvmp/bloc/cubit/exercice_cubit.dart';
import 'package:pvmp/bloc/state/connexion_state.dart';
import 'package:pvmp/bloc/state/exercice_state.dart';
import 'package:pvmp/flutter_flow/flutter_flow_widgets.dart';
import 'package:pvmp/flutter_flow/form_field_controller.dart';
import 'package:pvmp/models/json_model.dart';
import 'package:pvmp/screen/auth/login.dart';
import 'package:pvmp/widgets/select_exercice_row.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class SelectExercice extends StatefulWidget {
  const SelectExercice({super.key, required this.controller, required this.onPressed});
  final FormFieldController controller;
  final Function onPressed;

  @override
  _SelectExerciceState createState() => _SelectExerciceState();
}

class _SelectExerciceState extends State<SelectExercice> {

  bool checkIn(exo) {
    bool retour = false;
    (widget.controller.value as List).forEach((element) {
      if(element["id"] == exo["id"]){
        retour = true;
      }
    });
    return retour;
  }

  void removeIn(exo){
    Json? exoToRemove;
    (widget.controller.value as List).forEach((element) {
      if(element["id"] == exo["id"]){
        exoToRemove = element;
      }
    });
    (widget.controller.value as List).remove(exoToRemove);
  }

  void addIn(exo){
    (widget.controller.value as List).add(exo);
  }

  @override
  Widget build(BuildContext context) {
    FlutterFlowTheme theme = FlutterFlowTheme.of(context);

    return BlocConsumer<ConnexionCubit, ConnexionState>(
      listener: (context, state) {
        if (state is ConnexionLoadedState) {
          if (state.connexion == null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(Login.routeName, (route) => false);
            });
          }
        }
      },
      builder: (context, state) {
        
        return BlocConsumer<ExerciceCubit, ExerciceState>(
            listener: (context, state) {
              if (state is ExerciceErrorState) {
                Logger().e(state.error);
                Flushbar(
                  messageText: Text(
                    state.error,
                    style: theme.bodyMedium,
                  ),
                  backgroundColor: theme.error,
                  duration: const Duration(seconds: 3),
                  flushbarPosition: FlushbarPosition.BOTTOM,
                  flushbarStyle: FlushbarStyle.FLOATING,
                ).show(context);
              }
            },
            builder: (context, state) {
              if(state is ExerciceLoadingState){
                context.read<ExerciceCubit>().getExercices();
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextField(
                    onChanged: (value) {
                      if(value.length > 2 || value.isEmpty){
                        context.read<ExerciceCubit>().search(value);
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
                  state is ExerciceLoadedState ? Container(
                    height: 60.h,
                    child:  ListView(
                      children: state.mesExercices!.map((exo) {
                        return SelectRow(exo: exo, checked: checkIn(exo), onTap: () {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            setState(() {
                              if(checkIn(exo)){
                                removeIn(exo);
                                (widget.controller.value as List).remove(exo);
                              }else{
                                addIn(exo);
                              }
                            });
                          });
                        },);
                      }).toList(),
                    ) 
                  ) : Padding(padding: const EdgeInsets.only(top: 20), child: Container(height: 60.h, child: Column(children: [CircularProgressIndicator(color: theme.primaryText,)])),),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10), 
                    child: FFButtonWidget(
                      text: "Enregistrer les exercices (${(widget.controller.value as List).length})",
                      onPressed: () {
                        widget.onPressed();
                        Navigator.of(context).pop();
                      },
                      options: FFButtonOptions(
                        width:
                            90.w,
                        padding:
                            const EdgeInsetsDirectional
                                .fromSTEB(
                                    0.0,
                                    0.0,
                                    0.0,
                                    0.0),
                        iconPadding:
                            const EdgeInsetsDirectional
                                .fromSTEB(
                                    0.0,
                                    0.0,
                                    0.0,
                                    0.0),
                        color:
                            FlutterFlowTheme.of(
                                    context)
                                .primary,
                        textStyle:
                            FlutterFlowTheme.of(
                                    context)
                                .titleSmall
                                .override(
                                  fontFamily: FlutterFlowTheme.of(
                                          context)
                                      .titleSmallFamily,
                                  color: Colors
                                      .white,
                                  useGoogleFonts: GoogleFonts
                                          .asMap()
                                      .containsKey(
                                          theme
                                              .titleSmallFamily),
                                ),
                        elevation: 3.0,
                        borderSide: const BorderSide(
                          color: Colors
                              .transparent,
                          width: 1.0,
                        ),
                        borderRadius:
                            BorderRadius
                                .circular(12.0),
                      )),
                  )
                ],
              );
            },
          );
      },
    );
  }
}
