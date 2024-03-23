import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pvmp/flutter_flow/flutter_flow_theme.dart';
import 'package:pvmp/models/routine.dart';

class RoutineRow extends StatelessWidget {
  final Routine routine;
  
  const RoutineRow({
    super.key,
    required this.routine
  });

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    FlutterFlowTheme theme = FlutterFlowTheme.of(context);
    return Container(
      width: screenSize.width * 0.9,
      padding: EdgeInsets.fromLTRB(10,5,0,5),
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.lineColor,
          width: 1
        ),
        borderRadius: BorderRadius.circular(10),
        color: theme.secondaryBackground
      ),
      child: Row(
        children: [
          Container(
            width: 70.0,
            height: 70.0,
            decoration: BoxDecoration(
              color: theme.primary.withAlpha(81),
              borderRadius:
                  BorderRadius.circular(50),
            ),
            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
            alignment: AlignmentDirectional(
                0.0, 0.0),
            child: FaIcon(FontAwesomeIcons.dumbbell, color: theme.primary,),
          ),
          SizedBox(width: 20,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(routine.nom, style: theme.titleMedium,),
              Container(width: screenSize.width*0.50, child: Text(routine.description, style: theme.bodySmall,),)
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(onPressed: () => print("modif"), icon: FaIcon(FontAwesomeIcons.penToSquare, color: theme.primaryText,)),
              IconButton(onPressed: () => print("delete"), icon: FaIcon(FontAwesomeIcons.xmark, color: theme.error,))
            ],
          )
        ],
      ),
    );                              
  }
}
