import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:pvmp/flutter_flow/flutter_flow_theme.dart';
import 'package:pvmp/providers/auth.dart';
import 'package:pvmp/screen/auth/login.dart';
import 'package:pvmp/screen/leaderboard.dart';
import 'package:pvmp/screen/my_account.dart';
import 'package:pvmp/screen/my_friends.dart';
import 'package:pvmp/screen/routine.dart';
import 'package:pvmp/screen/training/choose_routine.dart';
import 'package:pvmp/screen/training_plan.dart';
import 'package:quds_popup_menu/quds_popup_menu.dart';

class PageHeader extends StatelessWidget {
  
  final String headerTitle;
  final String headerDescription;
  final Function logoutCallback;
  final bool canPop;

  const PageHeader({
    super.key, 
    required this.headerTitle,
    required this.headerDescription,
    required this.logoutCallback,
    this.canPop = true
  });

  /// Déconnexion
  void logout(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    auth.doLogOut(context);
    Navigator.of(context).pushNamedAndRemoveUntil(Login.routeName, (route) => false);
  }


  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(height: 10,),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 12,
              child: Align(
                alignment:
                    AlignmentDirectional(0.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Navigator.of(context).canPop() && canPop == true ?
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        width: 50,
                        child: Center(child: FaIcon(FontAwesomeIcons.caretLeft, color: FlutterFlowTheme.of(context).primaryText, size: 35,)),
                      ),
                    ) : SizedBox(),
                    Expanded(
                      flex: 87,
                      child: Align(
                        alignment: AlignmentDirectional(
                            -1.0, 1.0),
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
                                headerTitle,
                                style:
                                    FlutterFlowTheme.of(
                                            context)
                                        .displaySmall,
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
                                  headerDescription,
                                  style: FlutterFlowTheme
                                          .of(context)
                                      .bodySmall,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(
                          1.0, -1.0),
                      child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment:
                              MainAxisAlignment.end,
                          children: [
                            QudsPopupButton(
                              items: [
                              QudsPopupMenuItem(
                                leading: FaIcon(FontAwesomeIcons.dumbbell, color: FlutterFlowTheme.of(context).primary,),
                                title: Text("S'exercer", style: FlutterFlowTheme.of(context).bodyMedium,),
                                onPressed: () {
                                  Navigator.of(context).pushNamed(ChooseRoutineScreen.routeName);
                              }),
                              QudsPopupMenuDivider(),
                              QudsPopupMenuItem(
                                leading: FaIcon(
                                  FontAwesomeIcons.chartLine,
                                  color: FlutterFlowTheme.of(context).secondary,
                                ),
                                title: Text("LeaderBoard", style: FlutterFlowTheme.of(context).bodyMedium,),
                                onPressed: () {
                                  Navigator.of(context).pushNamed(LeaderBoardScreen.routeName);
                              }),
                              QudsPopupMenuDivider(),
                              QudsPopupMenuItem(
                                leading: FaIcon(
                                  FontAwesomeIcons.calendarDays,
                                  color: FlutterFlowTheme.of(context).warning,
                                ),
                                title: Text("Plan d'entrainement", style: FlutterFlowTheme.of(context).bodyMedium,),
                                onPressed: () {
                                  Navigator.of(context).pushNamed(TrainingPlanScreen.routeName);
                              }),
                              // QudsPopupMenuDivider(),
                              // QudsPopupMenuItem(
                              //   leading: FaIcon(FontAwesomeIcons.dumbbell, color: FlutterFlowTheme.of(context).primary,),
                              //   title: Text("Exercices", style: FlutterFlowTheme.of(context).bodyMedium,),
                              //   onPressed: () {
                              //     print("test");
                              // }),
                              QudsPopupMenuDivider(),
                              QudsPopupMenuItem(
                                leading: FaIcon(
                                  FontAwesomeIcons.repeat,
                                  color: FlutterFlowTheme.of(context).info,
                                ),
                                title: Text("Routines", style: FlutterFlowTheme.of(context).bodyMedium,),
                                onPressed: () {
                                  Navigator.of(context).pushNamed(RoutineScreen.routeName);
                              }),
                              QudsPopupMenuDivider(),
                              QudsPopupMenuItem(
                                leading: FaIcon(
                                  FontAwesomeIcons.userGroup,
                                  color: const Color.fromARGB(255, 255, 81, 0),
                                ),
                                title: Text("Amis", style: FlutterFlowTheme.of(context).bodyMedium,),
                                onPressed: () {
                                  Navigator.of(context).pushNamed(MyFriendsScreen.routeName);
                              }),
                              QudsPopupMenuDivider(),
                              QudsPopupMenuItem(
                                leading: FaIcon(
                                  FontAwesomeIcons.circleUser,
                                  color: FlutterFlowTheme.of(context).primaryText,
                                ),
                                title: Text("Mon compte", style: FlutterFlowTheme.of(context).bodyMedium,),
                                onPressed: () {
                                  Navigator.of(context).pushNamed(MyAccountScreen.routeName);
                              }),
                              QudsPopupMenuDivider(),
                              QudsPopupMenuItem(
                                leading: Icon(Icons.logout, size: 30,),
                                title: Text('Se déconnecter', style: FlutterFlowTheme.of(context).bodyMedium,),
                                onPressed: () {
                                  logoutCallback();
                              }),
                            ],
                            child: Container(
                              width: 50.0,
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme
                                        .of(context)
                                    .secondaryBackground,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 4.0,
                                    color:
                                        Color(0x33000000),
                                    offset:
                                        Offset(0.0, 2.0),
                                  )
                                ],
                                borderRadius:
                                    BorderRadius.circular(
                                        16.0),
                              ),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(
                                        16.0),
                                child: Image.asset(
                                  'assets/images/logo.png',
                                  fit: BoxFit.fitHeight,
                                  alignment: Alignment(
                                      -0.9, 0.0),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Divider(
          height: 30.0,
          thickness: 2,
          color:
              FlutterFlowTheme.of(context).lineColor,
        ),
      ],
    );
  }
}
