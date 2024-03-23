import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:pvmp/bloc/cubit/citation_cubit.dart';
import 'package:pvmp/bloc/cubit/connexion_cubit.dart';
import 'package:pvmp/bloc/state/citation_state.dart';
import 'package:pvmp/bloc/state/connexion_state.dart';
import 'package:pvmp/models/citation.dart';
import 'package:pvmp/screen/auth/login.dart';
import 'package:pvmp/screen/leaderboard.dart';
import 'package:pvmp/screen/my_friends.dart';
import 'package:pvmp/screen/routine.dart';
import 'package:pvmp/screen/training/choose_routine.dart';
import 'package:pvmp/screen/training_plan.dart';
import 'package:pvmp/widgets/citation_card.dart';
import 'package:pvmp/widgets/home_menu_element_widget.dart';
import 'package:pvmp/widgets/page_header.dart';

import '/components/mobile_nav_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key});
  static const routeName = "HomePage";
  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

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
          callback: () => Navigator.of(context).pushNamed(ChooseRoutineScreen.routeName),),
      HomeMenuElementWidget(
          icon: FaIcon(
            FontAwesomeIcons.dumbbell,
            color: FlutterFlowTheme.of(context).primary,
          ),
          iconColor: FlutterFlowTheme.of(context).primary,
          title: "LeaderBoard",
          titleStyle: FlutterFlowTheme.of(context).titleMedium,
          description: "Comparez vos performances avec celles de vos amis",
          descriptionStyle: FlutterFlowTheme.of(context).bodySmall,
          callback: () => Navigator.of(context).pushNamed(LeaderBoardScreen.routeName),),
      HomeMenuElementWidget(
          icon: FaIcon(
            FontAwesomeIcons.dumbbell,
            color: FlutterFlowTheme.of(context).primary,
          ),
          iconColor: FlutterFlowTheme.of(context).primary,
          title: "Plan d'entrainement",
          titleStyle: FlutterFlowTheme.of(context).titleMedium,
          description: "Planifiez vos entrainements sur la semaine",
          descriptionStyle: FlutterFlowTheme.of(context).bodySmall,
          callback: () => Navigator.of(context).pushNamed(TrainingPlanScreen.routeName),),
      // HomeMenuElementWidget(
      //   icon: FaIcon(FontAwesomeIcons.dumbbell, color: FlutterFlowTheme.of(context).primary,),
      //   iconColor: FlutterFlowTheme.of(context).primary,
      //   title: "Exercices",
      //   titleStyle: FlutterFlowTheme.of(context).titleMedium,
      //   description: "Consultez les exercices",
      //   descriptionStyle: FlutterFlowTheme.of(context).bodySmall,
      //   callback: () => print("S'exercer")
      // ),
      HomeMenuElementWidget(
          icon: FaIcon(
            FontAwesomeIcons.dumbbell,
            color: FlutterFlowTheme.of(context).primary,
          ),
          iconColor: FlutterFlowTheme.of(context).primary,
          title: "Routines",
          titleStyle: FlutterFlowTheme.of(context).titleMedium,
          description: "Gérez vos routines d'entrainement",
          descriptionStyle: FlutterFlowTheme.of(context).bodySmall,
          callback: () => Navigator.of(context).pushNamed(RoutineScreen.routeName),),
      HomeMenuElementWidget(
          icon: FaIcon(
            FontAwesomeIcons.dumbbell,
            color: FlutterFlowTheme.of(context).primary,
          ),
          iconColor: FlutterFlowTheme.of(context).primary,
          title: "Amis",
          titleStyle: FlutterFlowTheme.of(context).titleMedium,
          description: "Ajouter des amis grâce à votre code amis unique",
          descriptionStyle: FlutterFlowTheme.of(context).bodySmall,
          callback: () => Navigator.of(context).pushNamed(MyFriendsScreen.routeName),),
      HomeMenuElementWidget(
          icon: FaIcon(
            FontAwesomeIcons.dumbbell,
            color: FlutterFlowTheme.of(context).primary,
          ),
          iconColor: FlutterFlowTheme.of(context).primary,
          title: "Mon compte",
          titleStyle: FlutterFlowTheme.of(context).titleMedium,
          description: "Gérez les informations de votre compte",
          descriptionStyle: FlutterFlowTheme.of(context).bodySmall,
          callback: () => Navigator.of(context).pushNamed(MyFriendsScreen.routeName),),
    ];

    return BlocConsumer<ConnexionCubit, ConnexionState>(
      listener: (context, state) {
        if (state is ConnexionErrorState) {
          Logger().e(state.error);
        }
      },
      builder: (context, state) {
        if (state is ConnexionLoadedState) {
          if (state.connexion == null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushNamedAndRemoveUntil(Login.routeName, (route) => false);
            });
          }
          return BlocProvider(
            create: (context) => CitationCubit(dio: context.read<ConnexionCubit>().getDio()!),
            child: BlocConsumer<CitationCubit, CitationState>(
              listener: (context, state) {
                if (state is CitationErrorState) {
                  Logger().e(state.error);
                }
              },
              builder: (context, state) {
                if(state is CitationLoadingState){
                  context.read<CitationCubit>().getRandomCitation();
                }
                return Scaffold(
                  key: scaffoldKey,
                  backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
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
                                              16.0, 24.0, 16.0, 0.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              PageHeader(
                                                headerTitle: "PVMP",
                                                headerDescription: "",
                                                logoutCallback: () => context
                                                    .read<ConnexionCubit>()
                                                    .logout(),
                                              ),
                                              Text(
                                                'Inspiration du jour',
                                                style: FlutterFlowTheme.of(context)
                                                    .headlineMedium,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              state is CitationLoadedState ? CitationCard(citation: state.citation, isLoading: false,) : const CitationCard(citation: null, isLoading: true),
                                              Divider(
                                                height: 40.0,
                                                thickness: 2,
                                                color: FlutterFlowTheme.of(context)
                                                    .lineColor,
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Padding(
                                                      padding: EdgeInsetsDirectional
                                                          .fromSTEB(
                                                              0.0, 0.0, 16.0, 0.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Menu',
                                                            style:
                                                                FlutterFlowTheme.of(
                                                                        context)
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
                                                padding:
                                                    EdgeInsetsDirectional.fromSTEB(
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
                  ));
              },
            ),
          );
        }
        return Container();
      },
    );
  }
}
