import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:pvmp/bloc/cubit/session_cubit.dart';
import 'package:pvmp/bloc/state/session_state.dart';
import 'package:pvmp/flutter_flow/flutter_flow_theme.dart';
import 'package:pvmp/models/user.dart';
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
  final bool canPop;

  const PageHeader(
      {super.key,
      required this.headerTitle,
      required this.headerDescription,
      this.canPop = true});

  @override
  Widget build(BuildContext context) {
    FlutterFlowTheme theme = FlutterFlowTheme.of(context);
    return BlocBuilder<SessionCubit, SessionState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 12,
                  child: Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Navigator.of(context).canPop() && canPop == true
                            ? InkWell(
                                onTap: () => Navigator.of(context).pop(),
                                child: Container(
                                  width: 50,
                                  child: Center(
                                      child: FaIcon(
                                    FontAwesomeIcons.caretLeft,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 35,
                                  )),
                                ),
                              )
                            : SizedBox(),
                        Expanded(
                          flex: 87,
                          child: Align(
                            alignment: AlignmentDirectional(-1.0, 1.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 16.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    headerTitle,
                                    style: FlutterFlowTheme.of(context)
                                        .displaySmall,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 4.0, 0.0, 0.0),
                                    child: Text(
                                      headerDescription,
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(1.0, -1.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              QudsPopupButton(
                                items: [
                                  QudsPopupMenuWidget(builder: (context) {
                                    User? user = context.read<SessionCubit>().state.connexion!.user;
                                    return Center(child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text(user!.name ?? "PVMP", style: theme.displaySmall,),
                                    ));
                                  },),
                                  QudsPopupMenuDivider(),
                                  QudsPopupMenuItem(
                                      leading: Icon(
                                        Icons.logout,
                                        size: 30,
                                      ),
                                      title: Text(
                                        'Se déconnecter',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium,
                                      ),
                                      onPressed: () {
                                        context.read<SessionCubit>().logout();
                                      }),
                                ],
                                child: Container(
                                  width: 50.0,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 4.0,
                                        color: Color(0x33000000),
                                        offset: Offset(0.0, 2.0),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16.0),
                                    child: Image.asset(
                                      'assets/images/logo.png',
                                      fit: BoxFit.fitHeight,
                                      alignment: Alignment(-0.9, 0.0),
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
              color: FlutterFlowTheme.of(context).lineColor,
            ),
          ],
        );
      },
    );
  }
}
