
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:pvmp/bloc/cubit/congrat_cubit.dart';
import 'package:pvmp/bloc/state/congrat_state.dart';
import 'package:pvmp/flutter_flow/flutter_flow_theme.dart';
import 'package:pvmp/screen/home.dart';
import 'package:pvmp/widgets/congrat_card.dart';
import 'package:pvmp/widgets/my_ff_button.dart';
import 'package:pvmp/widgets/page_header.dart';

class CongratScreen extends StatefulWidget {
  CongratScreen({super.key});
  static const routeName = "CongratScreen";

  @override
  State<CongratScreen> createState() => _CongratScreenState();
}

class _CongratScreenState extends State<CongratScreen> {
  final ConfettiController controller =
      ConfettiController(duration: Duration(microseconds: 1));

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller.play();
  }

  @override
  Widget build(BuildContext context) {
    FlutterFlowTheme theme = FlutterFlowTheme.of(context);

    return BlocBuilder<CongratCubit, CongratState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
              backgroundColor: theme.secondaryBackground,
              body: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    "assets/images/bg/2.jpg",
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
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              16.0, 0.0, 16.0, 0.0),
                                      child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            PageHeader(
                                              headerTitle: "Bravo",
                                              headerDescription:
                                                  "Séance terminé",
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Center(
                                              child:
                                                  CongratCard(volume: state.volume),
                                            ),
                                            MyFfButton(
                                              label: "Retour à l'accueil",
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pushReplacementNamed(
                                                        HomePageScreen
                                                            .routeName);
                                              },
                                              width: 90.w,
                                            ),
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: ConfettiWidget(
                                                confettiController: controller,
                                                // blastDirection: -pi / 2,
                                                blastDirectionality:
                                                    BlastDirectionality
                                                        .explosive,
                                                emissionFrequency: 1,
                                                numberOfParticles: 500,
                                                maxBlastForce: 200,
                                                minBlastForce: 199,
                                                gravity: 0.04,
                                                colors: [
                                                  theme.primary,
                                                  theme.secondaryBackground,
                                                  theme.primaryText
                                                ],
                                              ),
                                            ),
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
  }
}
