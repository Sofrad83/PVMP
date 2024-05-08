import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pvmp/bloc/cubit/routine_cubit.dart';
import 'package:pvmp/bloc/state/routine_state.dart';
import 'package:pvmp/flutter_flow/flutter_flow_widgets.dart';
import 'package:pvmp/screen/routine_edit.dart';
import 'package:pvmp/widgets/page_header.dart';
import 'package:pvmp/widgets/routine_row.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class RoutineScreen extends StatelessWidget {
  RoutineScreen({super.key});
  final scaffoldKey = GlobalKey<ScaffoldState>();
  static const routeName = "RoutineScreen";

  @override
  Widget build(BuildContext context) {
    FlutterFlowTheme theme = FlutterFlowTheme.of(context);

    return BlocProvider(
      create: (context) => RoutineCubit(),
      child: BlocBuilder<RoutineCubit, RoutineState>(
        builder: (context, state) {
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
              ).show(context).then((value) => context.read<RoutineCubit>().setError(isError: false));
            });
          }
          if (state.isLoading) {
            context.read<RoutineCubit>().getAllRoutines();
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
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(16.0, 0.0, 16.0, 0.0),
                                        child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              PageHeader(
                                                headerTitle: "Routines",
                                                headerDescription:
                                                    "Gérez vos routines d'entrainement",
                                              ),
                                              FFButtonWidget(
                                                  text: "Créer une routine",
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pushNamed(
                                                            RoutineEditScreen
                                                                .routeName)
                                                        .then((value) => context
                                                            .read<
                                                                RoutineCubit>()
                                                            .reset());
                                                  },
                                                  options: FFButtonOptions(
                                                    width: 90.w,
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            0.0, 0.0, 0.0, 0.0),
                                                    iconPadding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            0.0, 0.0, 0.0, 0.0),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .info,
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .titleSmall
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmallFamily,
                                                          color: Colors.white,
                                                          useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                              .containsKey(theme
                                                                  .titleSmallFamily),
                                                        ),
                                                    elevation: 3.0,
                                                    borderSide:
                                                        const BorderSide(
                                                      color: Colors.transparent,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
                                                  )),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: !state.isLoading
                                                    ? state.routines!
                                                        .map((routine) =>
                                                            RoutineRow(
                                                              routine: routine,
                                                              onThen: () => context
                                                                  .read<
                                                                      RoutineCubit>()
                                                                  .reset(),
                                                              deleteCallback: () => context
                                                                  .read<
                                                                      RoutineCubit>()
                                                                  .delete(
                                                                      id: routine[
                                                                          "id"]),
                                                            ))
                                                        .toList()
                                                        .divide(const SizedBox(
                                                          height: 10,
                                                        ))
                                                    : [
                                                        CircularProgressIndicator(
                                                          color:
                                                              theme.primaryText,
                                                        )
                                                      ],
                                              ),
                                              const SizedBox(
                                                height: 80,
                                              )
                                            ]),
                                      ),
                                    ],
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
      ),
    );
  }
}
