import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pvmp/flutter_flow/flutter_flow_theme.dart';

class Chronometer extends StatefulWidget {
  const Chronometer({super.key});

  @override
  State<Chronometer> createState() => _ChronometerState();
}

class _ChronometerState extends State<Chronometer> {
  Duration duration = Duration();
  Timer? timer;

  void addTime(){
    setState(() {
      duration = Duration(seconds: (duration.inSeconds + 1));
    });
  }

  void startTimer(){
    timer ??= Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }

  void pauseTimer(){
    if(timer != null){
      setState(() {
        timer!.cancel();
      });
    }
  }

  void resetTimer(){
    setState(() {
      duration = Duration();
      if(timer != null){
        timer!.cancel();
      }
      timer = null;
    });
  }

  String twoDigit(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    FlutterFlowTheme theme = FlutterFlowTheme.of(context);
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10,0,10,0),
            child: Text(
              "${twoDigit(duration.inHours.remainder(60))}:${twoDigit(duration.inMinutes.remainder(60))}:${twoDigit(duration.inSeconds.remainder(60))}", 
              textAlign: TextAlign.center,
              style: GoogleFonts.getFont(
                'Urbanist',
                fontWeight: FontWeight.w800,
                fontSize: 45
              ),
            ),
          )
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10,0,10,0),
          child: Row(
            children: [
              IconButton(onPressed: () => startTimer(), icon: FaIcon(FontAwesomeIcons.play, color: theme.primaryText,)),
              IconButton(onPressed: () => pauseTimer(), icon: FaIcon(FontAwesomeIcons.pause, color: theme.primaryText,)),
              IconButton(onPressed: () => resetTimer(), icon: FaIcon(FontAwesomeIcons.solidSquare, color: theme.primaryText,))
            ],
          ),
        )
        
      ],
    );
  }
}