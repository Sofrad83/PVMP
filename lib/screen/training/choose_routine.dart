import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pvmp/bloc/cubit/connexion_cubit.dart';
import 'package:pvmp/bloc/cubit/routine_cubit.dart';
import 'package:pvmp/bloc/state/connexion_state.dart';
import 'package:pvmp/bloc/state/routine_state.dart';
import 'package:pvmp/flutter_flow/flutter_flow_theme.dart';
import 'package:pvmp/flutter_flow/flutter_flow_util.dart';
import 'package:pvmp/screen/auth/login.dart';
import 'package:pvmp/screen/training/training.dart';
import 'package:pvmp/utilities/logger.dart';
import 'package:pvmp/widgets/choose_routine_row.dart';
import 'package:pvmp/widgets/page_header.dart';
class ChooseRoutineScreen extends StatelessWidget {
  ChooseRoutineScreen({super.key});
  static const routeName = "ChooseRoutineScreen";
  
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
        return BlocConsumer<RoutineCubit, RoutineState>(
            listener: (context, state) {
              if (state is RoutineErrorState) {
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
              if(state is RoutineLoadingState){
                context.read<RoutineCubit>().getAllRoutinesLastSeries();
              }
              return SafeArea(
                child: Scaffold(
                    backgroundColor: theme.secondaryBackground,
                    body: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          "assets/images/bg/1.jpg",
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
                                                .fromSTEB(
                                                16.0, 0.0, 16.0, 0.0),
                                            child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  PageHeader(
                                                    headerTitle: "S'exercer",
                                                    headerDescription:
                                                        "Démarrer une séance d'entrainement",
                                                    logoutCallback: () =>
                                                        context.read<ConnexionCubit>().logout(),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: state is RoutineLoadedState ? state.mesRoutines!
                                                        .map((routine) =>
                                                            ChooseRoutineRow(
                                                              routine: routine,
                                                              onTap: () => Navigator.of(context).pushNamed(TrainingScreen.routeName, arguments: routine),
                                                            ))
                                                        .toList()
                                                        .divide(const SizedBox(
                                                          height: 10,
                                                        )) : [CircularProgressIndicator(color: theme.primaryText,)],
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
          );
      },
    );
  }
}
