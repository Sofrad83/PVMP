import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:pvmp/bloc/cubit/connexion_cubit.dart';
import 'package:pvmp/bloc/cubit/routine_cubit.dart';
import 'package:pvmp/bloc/state/connexion_state.dart';
import 'package:pvmp/bloc/state/routine_state.dart';
import 'package:pvmp/flutter_flow/flutter_flow_widgets.dart';
import 'package:pvmp/flutter_flow/form_field_controller.dart';
import 'package:pvmp/models/json_model.dart';
import 'package:pvmp/screen/auth/login.dart';
import 'package:pvmp/widgets/exo_row.dart';
import 'package:pvmp/widgets/page_header.dart';
import 'package:pvmp/widgets/select_exercice.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class RoutineEditScreen extends StatefulWidget {
  const RoutineEditScreen({super.key});
  static const routeName = "RoutineEditScreen";

  @override
  State<RoutineEditScreen> createState() => _RoutineEditScreenState();
}

class _RoutineEditScreenState extends State<RoutineEditScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> mainForm = GlobalKey<FormState>();
  TextEditingController nomController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  FormFieldController exoController = FormFieldController([]);
  int? id;
  bool needToInit = true;

  void store(RoutineCubit routineCubit) async {
    bool isValid = mainForm.currentState!.validate();
    if(isValid){
      if(exoController.value.isNotEmpty){
        routineCubit.store(nom: nomController.text, description: descriptionController.text, exos: exoController.value, id: id);
      }else{
        routineCubit.error("Ajouter des exos à cette routine pour continuer");
      }
    }
  }

  void removeIn(exo){
    setState(() {
      Json? exoToRemove;
      (exoController.value as List).forEach((element) {
        if(element["id"] == exo["id"]){
          exoToRemove = element;
        }
      });
      (exoController.value as List).remove(exoToRemove);
    });
  }


  @override
  Widget build(BuildContext context) {
    if(needToInit){
      final routine = ModalRoute.of(context)!.settings.arguments as Json?;
      if(routine != null){
        setState(() {
          nomController.text = routine["nom"];
          descriptionController.text = routine["description"];
          exoController.value = routine["exercices"];
          id = routine["id"];
        });
      }
      setState(() {
        needToInit = false;
      });
    }
    


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
        
        return BlocConsumer<RoutineCubit, RoutineState>(
            listener: (context, state) {
              if (state is RoutineErrorState) {
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
              if(state is RoutineStoreDoneState){
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Flushbar(
                    messageText: Text(
                      state.message,
                      style: theme.bodyMedium,
                    ),
                    backgroundColor: theme.success,
                    duration: const Duration(seconds: 3),
                    flushbarPosition: FlushbarPosition.BOTTOM,
                    flushbarStyle: FlushbarStyle.FLOATING,
                  ).show(context);
                  Future.delayed(const Duration(seconds: 3), (){
                    Navigator.of(context).pop();
                  });
                });
              }
              return SafeArea(
                child: Scaffold(
                    key: scaffoldKey,
                    backgroundColor: theme.secondaryBackground,
                    body: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          "assets/images/bg/4.jpg",
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
                                      child: Form(
                                        key: mainForm,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                  16.0, 0.0, 16.0, 0.0),
                                              child: Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    PageHeader(
                                                      headerTitle: "Routines",
                                                      headerDescription:
                                                          "Ajouter une routine",
                                                      logoutCallback: () => context
                                                          .read<ConnexionCubit>()
                                                          .logout(),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(0.0, 0.0,
                                                                  0.0, 16.0),
                                                      child: Container(
                                                        width: double.infinity,
                                                        child: TextFormField(
                                                          validator: (value) {
                                                            if (value!.isEmpty) {
                                                              return 'Merci de remplir ce champ.';
                                                            }
                                                            return null;
                                                          },
                                                          controller: nomController,
                                                          obscureText: false,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText: 'Nom',
                                                            labelStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium,
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: FlutterFlowTheme
                                                                        .of(context)
                                                                    .primaryText,
                                                                width: 2.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12.0),
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: FlutterFlowTheme
                                                                        .of(context)
                                                                    .primary,
                                                                width: 2.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12.0),
                                                            ),
                                                            errorBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: FlutterFlowTheme
                                                                        .of(context)
                                                                    .error,
                                                                width: 2.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12.0),
                                                            ),
                                                            focusedErrorBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: FlutterFlowTheme
                                                                        .of(context)
                                                                    .error,
                                                                width: 2.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12.0),
                                                            ),
                                                            filled: true,
                                                            fillColor: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            contentPadding:
                                                                const EdgeInsets.all(
                                                                    24.0),
                                                          ),
                                                          style:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(0.0, 0.0,
                                                                  0.0, 16.0),
                                                      child: Container(
                                                        width: double.infinity,
                                                        child: TextFormField(
                                                          validator: (value) {
                                                            if (value!.isEmpty) {
                                                              return 'Merci de remplir ce champ.';
                                                            }
                                                            return null;
                                                          },
                                                          controller: descriptionController,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText:
                                                                'Description',
                                                            labelStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium,
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: FlutterFlowTheme
                                                                        .of(context)
                                                                    .primaryText,
                                                                width: 2.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12.0),
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: FlutterFlowTheme
                                                                        .of(context)
                                                                    .primary,
                                                                width: 2.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12.0),
                                                            ),
                                                            errorBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: FlutterFlowTheme
                                                                        .of(context)
                                                                    .error,
                                                                width: 2.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12.0),
                                                            ),
                                                            focusedErrorBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: FlutterFlowTheme
                                                                        .of(context)
                                                                    .error,
                                                                width: 2.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12.0),
                                                            ),
                                                            filled: true,
                                                            fillColor: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            contentPadding:
                                                                const EdgeInsets.all(
                                                                    24.0),
                                                          ),
                                                          style:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium,
                                                          keyboardType: TextInputType.multiline,
                                                          maxLines: null,
                                                        ),
                                                      ),
                                                    ),
                                                    FFButtonWidget(
                                                        text: "Gérer les exercices",
                                                        onPressed: () {
                                                          WoltModalSheet.show(
                                                            context: context, 
                                                            pageListBuilder: (modalSheetContext) {
                                                              return [
                                                                WoltModalSheetPage(
                                                                  child: Container(
                                                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                                                    child: SelectExercice(controller: exoController, onPressed: () {
                                                                      setState(() {
                                                                        
                                                                      });
                                                                    },),
                                                                  ),
                                                                  topBarTitle: Text('Gérer les exercices', style: FlutterFlowTheme.of(context).headlineSmall,),
                                                                  trailingNavBarWidget: IconButton(
                                                                    padding: const EdgeInsets.fromLTRB(0,5,15,0),
                                                                    icon: const FaIcon(FontAwesomeIcons.circleXmark),
                                                                    onPressed: () {
                                                                      Navigator.of(modalSheetContext).pop();
                                                                    },
                                                                  ),
                                                                  isTopBarLayerAlwaysVisible: true,
                                                                )
                                                              ];
                                                            }
                                                          );
                                                        },
                                                        options: FFButtonOptions(
                                                          // width:screenWidth * 0.5,
                                                          padding:
                                                              const EdgeInsets.all(10),
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
                                                    Container(
                                                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                                      child: Column(
                                                        children: (exoController.value as List).map((e) => ExoRow(exo: e, onXPressed: () => removeIn(e),)).toList()
                                                      )
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.fromLTRB(0,0,0,10),
                                                      child: FFButtonWidget(
                                                          icon: const FaIcon(FontAwesomeIcons.floppyDisk),
                                                          text: "Enregistrer la routine",
                                                          onPressed: () => store(context.read<RoutineCubit>()),
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
                                                                    .secondary,
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
                                                    ),
                                                  ]),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              );
            },
          );
      },
    );
  }
}

