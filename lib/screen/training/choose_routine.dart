import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pvmp/bloc/cubit/choose_routine_cubit.dart';
import 'package:pvmp/bloc/state/choose_routine_state.dart';
import 'package:pvmp/flutter_flow/flutter_flow_theme.dart';
import 'package:pvmp/flutter_flow/flutter_flow_util.dart';
import 'package:pvmp/screen/training/training.dart';
import 'package:pvmp/widgets/choose_routine_row.dart';
import 'package:pvmp/widgets/page_header.dart';

class ChooseRoutineScreen extends StatelessWidget {
  ChooseRoutineScreen({super.key});
  static const routeName = "ChooseRoutineScreen";

  @override
  Widget build(BuildContext context) {
    FlutterFlowTheme theme = FlutterFlowTheme.of(context);

    return BlocProvider(
      create: (context) => ChooseRoutineCubit(),
      child: BlocBuilder<ChooseRoutineCubit, ChooseRoutineState>(
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
              ).show(context);
            });
          }
          if (state.isLoading) {
            context.read<ChooseRoutineCubit>().getAllRoutinesLastSeries();
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
                                            .fromSTEB(16.0, 0.0, 16.0, 0.0),
                                        child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              PageHeader(
                                                headerTitle: "S'exercer",
                                                headerDescription:
                                                    "Démarrer une séance d'entrainement",
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: !state.isLoading ? state.routines!
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
      ),
    );
  }
}
