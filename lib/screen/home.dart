import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pvmp/bloc/cubit/home_cubit.dart';
import 'package:pvmp/bloc/state/home_state.dart';
import 'package:pvmp/screen/leaderboard.dart';
import 'package:pvmp/screen/my_friends.dart';
import 'package:pvmp/screen/routine.dart';
import 'package:pvmp/screen/training/choose_routine.dart';
import 'package:pvmp/screen/training_plan.dart';
import 'package:pvmp/widgets/citation_card.dart';
import 'package:pvmp/widgets/home_menu_element_widget.dart';
import 'package:pvmp/widgets/page_header.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePageScreen extends StatelessWidget {
  HomePageScreen({super.key});
  static const routeName = "HomePageScreen";
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    List<Widget> menuWidgets;
    menuWidgets = [
      HomeMenuElementWidget(
        icon: FaIcon(
          FontAwesomeIcons.dumbbell,
          color: FlutterFlowTheme.of(context).primary,
        ),
        iconColor: FlutterFlowTheme.of(context).primary,
        title: "S'exercer",
        titleStyle: FlutterFlowTheme.of(context).titleMedium,
        description: "Lancer une séance d'entrainement",
        descriptionStyle: FlutterFlowTheme.of(context).bodySmall,
        callback: () =>
            Navigator.of(context).pushNamed(ChooseRoutineScreen.routeName),
      ),
      HomeMenuElementWidget(
        icon: FaIcon(
          FontAwesomeIcons.repeat,
          color: FlutterFlowTheme.of(context).info,
        ),
        iconColor: FlutterFlowTheme.of(context).info,
        title: "Routines",
        titleStyle: FlutterFlowTheme.of(context).titleMedium,
        description: "Gérez vos routines d'entrainement",
        descriptionStyle: FlutterFlowTheme.of(context).bodySmall,
        callback: () =>
            Navigator.of(context).pushNamed(RoutineScreen.routeName),
      ),
      HomeMenuElementWidget(
        comingSoon: true,
        icon: FaIcon(
          FontAwesomeIcons.chartLine,
          color: FlutterFlowTheme.of(context).secondary,
        ),
        iconColor: FlutterFlowTheme.of(context).secondary,
        title: "LeaderBoard",
        titleStyle: FlutterFlowTheme.of(context).titleMedium,
        description: "Comparez vos performances avec celles de vos amis",
        descriptionStyle: FlutterFlowTheme.of(context).bodySmall,
        callback: () =>
            Navigator.of(context).pushNamed(LeaderBoardScreen.routeName),
      ),
      HomeMenuElementWidget(
        comingSoon: true,
        icon: FaIcon(
          FontAwesomeIcons.calendarDays,
          color: FlutterFlowTheme.of(context).warning,
        ),
        iconColor: FlutterFlowTheme.of(context).warning,
        title: "Plan d'entrainement",
        titleStyle: FlutterFlowTheme.of(context).titleMedium,
        description: "Planifiez vos entrainements sur la semaine",
        descriptionStyle: FlutterFlowTheme.of(context).bodySmall,
        callback: () =>
            Navigator.of(context).pushNamed(TrainingPlanScreen.routeName),
      ),
      HomeMenuElementWidget(
        comingSoon: true,
        icon: const FaIcon(
          FontAwesomeIcons.userGroup,
          color: Color.fromARGB(255, 255, 81, 0),
        ),
        iconColor: const Color.fromARGB(255, 255, 81, 0),
        title: "Amis",
        titleStyle: FlutterFlowTheme.of(context).titleMedium,
        description: "Ajouter des amis grâce à votre code amis unique",
        descriptionStyle: FlutterFlowTheme.of(context).bodySmall,
        callback: () =>
            Navigator.of(context).pushNamed(MyFriendsScreen.routeName),
      ),
      HomeMenuElementWidget(
        comingSoon: true,
        icon: FaIcon(
          FontAwesomeIcons.circleUser,
          color: FlutterFlowTheme.of(context).primaryText,
        ),
        iconColor: FlutterFlowTheme.of(context).primaryText,
        title: "Mon compte",
        titleStyle: FlutterFlowTheme.of(context).titleMedium,
        description: "Gérez les informations de votre compte",
        descriptionStyle: FlutterFlowTheme.of(context).bodySmall,
        callback: () =>
            Navigator.of(context).pushNamed(MyFriendsScreen.routeName),
      ),
    ];

    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocBuilder<HomeCubit, HomeState>(
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
            context.read<HomeCubit>().getRandomCitation();
          }
          return SafeArea(
            child: Scaffold(
                key: scaffoldKey,
                backgroundColor:
                    FlutterFlowTheme.of(context).secondaryBackground,
                body: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      "assets/images/login.png",
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
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 16.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            PageHeader(
                                              headerTitle: "PVMP",
                                              headerDescription: "Accueil",
                                              canPop: false,
                                            ),
                                            Text(
                                              'Inspiration du jour',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineMedium,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            CitationCard(
                                              citation: state.citation,
                                              isLoading: state.citation == null,
                                            ),
                                            Divider(
                                              height: 40.0,
                                              thickness: 2,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .lineColor,
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                16.0, 0.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Menu',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .headlineMedium,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      4.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Text(
                                                            'Tout ce qu\'il faut pour progresser',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodySmall,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 12.0, 16.0, 24.0),
                                              child: ListView(
                                                padding: EdgeInsets.zero,
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                children: menuWidgets,
                                              ),
                                            ),
                                          ],
                                        ),
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
