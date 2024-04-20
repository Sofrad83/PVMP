import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pvmp/flutter_flow/flutter_flow_theme.dart';
import 'package:pvmp/models/json_model.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class ChooseRoutineRow extends StatelessWidget {
  final Json routine;
  final Function onTap;

  
  const ChooseRoutineRow({
    super.key,
    required this.routine,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    FlutterFlowTheme theme = FlutterFlowTheme.of(context);
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        width: 90.w,
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
                Text(routine["nom"], style: theme.titleMedium,),
                Container(width: 50.w, child: Text(routine["description"], style: theme.bodySmall,),)
              ],
            ),
          ],
        ),
      ),
    );                              
  }
}
