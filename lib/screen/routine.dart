import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pvmp/flutter_flow/flutter_flow_widgets.dart';
import 'package:pvmp/models/exercice.dart';
import 'package:pvmp/models/groupe_muscle.dart';
import 'package:pvmp/models/routine.dart';
import 'package:pvmp/widgets/page_header.dart';
import 'package:pvmp/widgets/routine_row.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class RoutineScreen extends StatelessWidget {
  RoutineScreen({Key? key});
  final scaffoldKey = GlobalKey<ScaffoldState>();
  static const routeName = "RoutineScreen";
  List<Routine>? mesRoutines;
  
  @override
  Widget build(BuildContext context) {
    mesRoutines = [
      Routine(nom: "Pecs/Triceps", description: "Une ros", muscles: [GroupeMuscle(nom: "Pecs", img: "pecs.png")], exercices: [Exercice(nom: "Développé couché", description: "DEV COUCHE", muscle: GroupeMuscle(nom: "Pecs", img: "pecs.png"))]),
      Routine(nom: "Pecs/Triceps", description: "Une routine pour les pecs et les triceps", muscles: [GroupeMuscle(nom: "Pecs", img: "pecs.png")], exercices: [Exercice(nom: "Développé couché", description: "DEV COUCHE", muscle: GroupeMuscle(nom: "Pecs", img: "pecs.png"))]),
      Routine(nom: "Pecs/Triceps", description: "Une routine pour les pecs et les triceps", muscles: [GroupeMuscle(nom: "Pecs", img: "pecs.png")], exercices: [Exercice(nom: "Développé couché", description: "DEV COUCHE", muscle: GroupeMuscle(nom: "Pecs", img: "pecs.png"))]),
      Routine(nom: "Pecs/Triceps", description: "Une routine pour les pecs et les triceps", muscles: [GroupeMuscle(nom: "Pecs", img: "pecs.png")], exercices: [Exercice(nom: "Développé couché", description: "DEV COUCHE", muscle: GroupeMuscle(nom: "Pecs", img: "pecs.png"))]),
      Routine(nom: "Pecs/Triceps", description: "Une routine pour les pecs et les triceps", muscles: [GroupeMuscle(nom: "Pecs", img: "pecs.png")], exercices: [Exercice(nom: "Développé couché", description: "DEV COUCHE", muscle: GroupeMuscle(nom: "Pecs", img: "pecs.png"))]),
      Routine(nom: "Pecs/Triceps", description: "Une routine pour les pecs et les triceps", muscles: [GroupeMuscle(nom: "Pecs", img: "pecs.png")], exercices: [Exercice(nom: "Développé couché", description: "DEV COUCHE", muscle: GroupeMuscle(nom: "Pecs", img: "pecs.png"))]),
      Routine(nom: "Pecs/Triceps", description: "Une routine pour les pecs et les triceps", muscles: [GroupeMuscle(nom: "Pecs", img: "pecs.png")], exercices: [Exercice(nom: "Développé couché", description: "DEV COUCHE", muscle: GroupeMuscle(nom: "Pecs", img: "pecs.png"))]),
      Routine(nom: "Pecs/Triceps", description: "Une routine pour les pecs et les triceps", muscles: [GroupeMuscle(nom: "Pecs", img: "pecs.png")], exercices: [Exercice(nom: "Développé couché", description: "DEV COUCHE", muscle: GroupeMuscle(nom: "Pecs", img: "pecs.png"))]),
      Routine(nom: "Pecs/Triceps", description: "Une routine pour les pecs et les triceps", muscles: [GroupeMuscle(nom: "Pecs", img: "pecs.png")], exercices: [Exercice(nom: "Développé couché", description: "DEV COUCHE", muscle: GroupeMuscle(nom: "Pecs", img: "pecs.png"))]),
      Routine(nom: "Pecs/Triceps", description: "Une routine pour les pecs et les triceps", muscles: [GroupeMuscle(nom: "Pecs", img: "pecs.png")], exercices: [Exercice(nom: "Développé couché", description: "DEV COUCHE", muscle: GroupeMuscle(nom: "Pecs", img: "pecs.png"))]),
      Routine(nom: "Pecs/Triceps", description: "Une routine pour les pecs et les triceps", muscles: [GroupeMuscle(nom: "Pecs", img: "pecs.png")], exercices: [Exercice(nom: "Développé couché", description: "DEV COUCHE", muscle: GroupeMuscle(nom: "Pecs", img: "pecs.png"))]),
      Routine(nom: "Pecs/Triceps", description: "Une routine pour les pecs et les triceps", muscles: [GroupeMuscle(nom: "Pecs", img: "pecs.png")], exercices: [Exercice(nom: "Développé couché", description: "DEV COUCHE", muscle: GroupeMuscle(nom: "Pecs", img: "pecs.png"))]),
      Routine(nom: "Pecs/Triceps", description: "Une routine pour les pecs et les triceps", muscles: [GroupeMuscle(nom: "Pecs", img: "pecs.png")], exercices: [Exercice(nom: "Développé couché", description: "DEV COUCHE", muscle: GroupeMuscle(nom: "Pecs", img: "pecs.png"))]),
      Routine(nom: "Pecs/Triceps", description: "Une routine pour les pecs et les triceps", muscles: [GroupeMuscle(nom: "Pecs", img: "pecs.png")], exercices: [Exercice(nom: "Développé couché", description: "DEV COUCHE", muscle: GroupeMuscle(nom: "Pecs", img: "pecs.png"))]),
      Routine(nom: "Pecs/Triceps", description: "Une routine pour les pecs et les triceps", muscles: [GroupeMuscle(nom: "Pecs", img: "pecs.png")], exercices: [Exercice(nom: "Développé couché", description: "DEV COUCHE", muscle: GroupeMuscle(nom: "Pecs", img: "pecs.png"))]),
      Routine(nom: "Pecs/Triceps", description: "Une routine pour les pecs et les triceps", muscles: [GroupeMuscle(nom: "Pecs", img: "pecs.png")], exercices: [Exercice(nom: "Développé couché", description: "DEV COUCHE", muscle: GroupeMuscle(nom: "Pecs", img: "pecs.png"))]),
      Routine(nom: "Pecs/Triceps", description: "Une routine pour les pecs et les triceps", muscles: [GroupeMuscle(nom: "Pecs", img: "pecs.png")], exercices: [Exercice(nom: "Développé couché", description: "DEV COUCHE", muscle: GroupeMuscle(nom: "Pecs", img: "pecs.png"))]),
      Routine(nom: "Pecs/Triceps", description: "Une routine pour les pecs et les triceps", muscles: [GroupeMuscle(nom: "Pecs", img: "pecs.png")], exercices: [Exercice(nom: "Développé couché", description: "DEV COUCHE", muscle: GroupeMuscle(nom: "Pecs", img: "pecs.png"))]),
      Routine(nom: "Pecs/Triceps", description: "Une routine pour les pecs et les triceps", muscles: [GroupeMuscle(nom: "Pecs", img: "pecs.png")], exercices: [Exercice(nom: "Développé couché", description: "DEV COUCHE", muscle: GroupeMuscle(nom: "Pecs", img: "pecs.png"))]),
    ];

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    FlutterFlowTheme theme = FlutterFlowTheme.of(context);
    
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: theme.secondaryBackground,
      body: Stack(
        fit: StackFit.expand,
          children: [
            Image.asset("assets/images/routine.png", fit: BoxFit.cover, opacity: const AlwaysStoppedAnimation(.2),),
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
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 24.0, 16.0, 0.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    PageHeader(headerTitle: "Routines", headerDescription: "Gérez vos routines d'entrainement", logoutCallback: () => print("deco"),),
                                    FFButtonWidget(
                                      text: "Créer une routine", 
                                      onPressed: () {
                                        WoltModalSheet.show(
                                          context: context, 
                                          pageListBuilder: (modalSheetContext) {
                                            return [
                                              WoltModalSheetPage(
                                                child: Container(
                                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                                  height: screenHeight,
                                                  child: Container() ,
                                                ),
                                                topBarTitle: Text('Créer une routine', style: theme.headlineSmall,),
                                                trailingNavBarWidget: IconButton(
                                                  padding: const EdgeInsets.fromLTRB(0,5,15,0),
                                                  icon: FaIcon(FontAwesomeIcons.circleXmark),
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
                                        width: screenWidth*0.9,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 0.0),
                                        iconPadding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 0.0),
                                        color: FlutterFlowTheme.of(context).primary,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: FlutterFlowTheme.of(context)
                                                  .titleSmallFamily,
                                              color: Colors.white,
                                              useGoogleFonts: GoogleFonts.asMap()
                                                  .containsKey(FlutterFlowTheme.of(context)
                                                      .titleSmallFamily),
                                            ),
                                        elevation: 3.0,
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(12.0),
                                      )
                                    ),
                                    SizedBox(height: 10,),
                                    Column(
                                      children: mesRoutines!.map((routine) => RoutineRow(routine: routine)).toList().divide(SizedBox(height: 10,)),
                                    ),
                                    SizedBox(height: 80,)
                                  ]
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
      )
    );
  }
}

// class RoutineScreen extends StatefulWidget {

//   const RoutineScreen({Key? key});
//   static const routeName = "Routine";
//   @override
//   State<RoutineScreen> createState() => _RoutineState();
// }

// class _RoutineState extends State<RoutineScreen> with TickerProviderStateMixin {

//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   List<Routine>? mesRoutines;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isiOS) {
//       SystemChrome.setSystemUIOverlayStyle(
//         SystemUiOverlayStyle(
//           statusBarBrightness: Theme.of(context).brightness,
//           systemStatusBarContrastEnforced: true,
//         ),
//       );
//     }

//     mesRoutines = [
//       Routine(nom: "Pecs/Triceps", description: "Une ros", muscles: [GroupeMuscle(nom: "Pecs", img: "pecs.png")], exercices: [Exercice(nom: "Développé couché", description: "DEV COUCHE", muscle: GroupeMuscle(nom: "Pecs", img: "pecs.png"))]),
//       Routine(nom: "Pecs/Triceps", description: "Une routine pour les pecs et les triceps", muscles: [GroupeMuscle(nom: "Pecs", img: "pecs.png")], exercices: [Exercice(nom: "Développé couché", description: "DEV COUCHE", muscle: GroupeMuscle(nom: "Pecs", img: "pecs.png"))]),
//       Routine(nom: "Pecs/Triceps", description: "Une routine pour les pecs et les triceps", muscles: [GroupeMuscle(nom: "Pecs", img: "pecs.png")], exercices: [Exercice(nom: "Développé couché", description: "DEV COUCHE", muscle: GroupeMuscle(nom: "Pecs", img: "pecs.png"))]),
//       Routine(nom: "Pecs/Triceps", description: "Une routine pour les pecs et les triceps", muscles: [GroupeMuscle(nom: "Pecs", img: "pecs.png")], exercices: [Exercice(nom: "Développé couché", description: "DEV COUCHE", muscle: GroupeMuscle(nom: "Pecs", img: "pecs.png"))]),
//       Routine(nom: "Pecs/Triceps", description: "Une routine pour les pecs et les triceps", muscles: [GroupeMuscle(nom: "Pecs", img: "pecs.png")], exercices: [Exercice(nom: "Développé couché", description: "DEV COUCHE", muscle: GroupeMuscle(nom: "Pecs", img: "pecs.png"))]),
//       Routine(nom: "Pecs/Triceps", description: "Une routine pour les pecs et les triceps", muscles: [GroupeMuscle(nom: "Pecs", img: "pecs.png")], exercices: [Exercice(nom: "Développé couché", description: "DEV COUCHE", muscle: GroupeMuscle(nom: "Pecs", img: "pecs.png"))]),
//       Routine(nom: "Pecs/Triceps", description: "Une routine pour les pecs et les triceps", muscles: [GroupeMuscle(nom: "Pecs", img: "pecs.png")], exercices: [Exercice(nom: "Développé couché", description: "DEV COUCHE", muscle: GroupeMuscle(nom: "Pecs", img: "pecs.png"))]),
//       Routine(nom: "Pecs/Triceps", description: "Une routine pour les pecs et les triceps", muscles: [GroupeMuscle(nom: "Pecs", img: "pecs.png")], exercices: [Exercice(nom: "Développé couché", description: "DEV COUCHE", muscle: GroupeMuscle(nom: "Pecs", img: "pecs.png"))]),
//       Routine(nom: "Pecs/Triceps", description: "Une routine pour les pecs et les triceps", muscles: [GroupeMuscle(nom: "Pecs", img: "pecs.png")], exercices: [Exercice(nom: "Développé couché", description: "DEV COUCHE", muscle: GroupeMuscle(nom: "Pecs", img: "pecs.png"))]),
//       Routine(nom: "Pecs/Triceps", description: "Une routine pour les pecs et les triceps", muscles: [GroupeMuscle(nom: "Pecs", img: "pecs.png")], exercices: [Exercice(nom: "Développé couché", description: "DEV COUCHE", muscle: GroupeMuscle(nom: "Pecs", img: "pecs.png"))]),
//       Routine(nom: "Pecs/Triceps", description: "Une routine pour les pecs et les triceps", muscles: [GroupeMuscle(nom: "Pecs", img: "pecs.png")], exercices: [Exercice(nom: "Développé couché", description: "DEV COUCHE", muscle: GroupeMuscle(nom: "Pecs", img: "pecs.png"))]),
//       Routine(nom: "Pecs/Triceps", description: "Une routine pour les pecs et les triceps", muscles: [GroupeMuscle(nom: "Pecs", img: "pecs.png")], exercices: [Exercice(nom: "Développé couché", description: "DEV COUCHE", muscle: GroupeMuscle(nom: "Pecs", img: "pecs.png"))]),
//       Routine(nom: "Pecs/Triceps", description: "Une routine pour les pecs et les triceps", muscles: [GroupeMuscle(nom: "Pecs", img: "pecs.png")], exercices: [Exercice(nom: "Développé couché", description: "DEV COUCHE", muscle: GroupeMuscle(nom: "Pecs", img: "pecs.png"))]),
//       Routine(nom: "Pecs/Triceps", description: "Une routine pour les pecs et les triceps", muscles: [GroupeMuscle(nom: "Pecs", img: "pecs.png")], exercices: [Exercice(nom: "Développé couché", description: "DEV COUCHE", muscle: GroupeMuscle(nom: "Pecs", img: "pecs.png"))]),
//       Routine(nom: "Pecs/Triceps", description: "Une routine pour les pecs et les triceps", muscles: [GroupeMuscle(nom: "Pecs", img: "pecs.png")], exercices: [Exercice(nom: "Développé couché", description: "DEV COUCHE", muscle: GroupeMuscle(nom: "Pecs", img: "pecs.png"))]),
//       Routine(nom: "Pecs/Triceps", description: "Une routine pour les pecs et les triceps", muscles: [GroupeMuscle(nom: "Pecs", img: "pecs.png")], exercices: [Exercice(nom: "Développé couché", description: "DEV COUCHE", muscle: GroupeMuscle(nom: "Pecs", img: "pecs.png"))]),
//       Routine(nom: "Pecs/Triceps", description: "Une routine pour les pecs et les triceps", muscles: [GroupeMuscle(nom: "Pecs", img: "pecs.png")], exercices: [Exercice(nom: "Développé couché", description: "DEV COUCHE", muscle: GroupeMuscle(nom: "Pecs", img: "pecs.png"))]),
//       Routine(nom: "Pecs/Triceps", description: "Une routine pour les pecs et les triceps", muscles: [GroupeMuscle(nom: "Pecs", img: "pecs.png")], exercices: [Exercice(nom: "Développé couché", description: "DEV COUCHE", muscle: GroupeMuscle(nom: "Pecs", img: "pecs.png"))]),
//       Routine(nom: "Pecs/Triceps", description: "Une routine pour les pecs et les triceps", muscles: [GroupeMuscle(nom: "Pecs", img: "pecs.png")], exercices: [Exercice(nom: "Développé couché", description: "DEV COUCHE", muscle: GroupeMuscle(nom: "Pecs", img: "pecs.png"))]),
//     ];

//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;
//     FlutterFlowTheme theme = FlutterFlowTheme.of(context);
    
//     return Scaffold(
//       key: scaffoldKey,
//       backgroundColor: theme.secondaryBackground,
//       body: Stack(
//         fit: StackFit.expand,
//           children: [
//             Image.asset("assets/images/routine.png", fit: BoxFit.cover, opacity: const AlwaysStoppedAnimation(.2),),
//             Row(
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 Expanded(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       Expanded(
//                         child: SingleChildScrollView(
//                           child: Column(
//                             mainAxisSize: MainAxisSize.max,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsetsDirectional.fromSTEB(
//                                     16.0, 24.0, 16.0, 0.0),
//                                 child: Column(
//                                   mainAxisSize: MainAxisSize.max,
//                                   children: [
//                                     PageHeader(headerTitle: "Routines", headerDescription: "Gérez vos routines d'entrainement", logoutCallback: () => print("deco"),),
//                                     FFButtonWidget(
//                                       text: "Créer une routine", 
//                                       onPressed: () {
//                                         WoltModalSheet.show(
//                                           context: context, 
//                                           pageListBuilder: (modalSheetContext) {
//                                             return [
//                                               WoltModalSheetPage(
//                                                 child: Container(
//                                                   padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
//                                                   height: screenHeight,
//                                                   child: Container() ,
//                                                 ),
//                                                 topBarTitle: Text('Créer une routine', style: theme.headlineSmall,),
//                                                 trailingNavBarWidget: IconButton(
//                                                   padding: const EdgeInsets.fromLTRB(0,5,15,0),
//                                                   icon: FaIcon(FontAwesomeIcons.circleXmark),
//                                                   onPressed: () {
//                                                     Navigator.of(modalSheetContext).pop();
//                                                   },
//                                                 ),
//                                                 isTopBarLayerAlwaysVisible: true,
//                                               )
//                                             ];
//                                           }
//                                         );
//                                       }, 
//                                       options: FFButtonOptions(
//                                         width: screenWidth*0.9,
//                                         padding: EdgeInsetsDirectional.fromSTEB(
//                                             0.0, 0.0, 0.0, 0.0),
//                                         iconPadding: EdgeInsetsDirectional.fromSTEB(
//                                             0.0, 0.0, 0.0, 0.0),
//                                         color: FlutterFlowTheme.of(context).primary,
//                                         textStyle: FlutterFlowTheme.of(context)
//                                             .titleSmall
//                                             .override(
//                                               fontFamily: FlutterFlowTheme.of(context)
//                                                   .titleSmallFamily,
//                                               color: Colors.white,
//                                               useGoogleFonts: GoogleFonts.asMap()
//                                                   .containsKey(FlutterFlowTheme.of(context)
//                                                       .titleSmallFamily),
//                                             ),
//                                         elevation: 3.0,
//                                         borderSide: BorderSide(
//                                           color: Colors.transparent,
//                                           width: 1.0,
//                                         ),
//                                         borderRadius: BorderRadius.circular(12.0),
//                                       )
//                                     ),
//                                     SizedBox(height: 10,),
//                                     Column(
//                                       children: mesRoutines!.map((routine) => RoutineRow(routine: routine)).toList().divide(SizedBox(height: 10,)),
//                                     ),
//                                     SizedBox(height: 80,)
//                                   ]
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//           ),
//         ],
//       )
//     );
//   }
// }
