import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pvmp/flutter_flow/flutter_flow_theme.dart';
import 'package:pvmp/models/json_model.dart';
import 'package:pvmp/screen/routine_edit.dart';
import 'package:quds_popup_menu/quds_popup_menu.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class RoutineRow extends StatelessWidget {
  final Json routine;
  final Function onThen;
  final Function deleteCallback;

  
  const RoutineRow({
    super.key,
    required this.routine,
    required this.onThen,
    required this.deleteCallback,
  });

  @override
  Widget build(BuildContext context) {
    FlutterFlowTheme theme = FlutterFlowTheme.of(context);
    return Container(
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
              color: theme.info.withAlpha(81),
              borderRadius:
                  BorderRadius.circular(50),
            ),
            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
            alignment: AlignmentDirectional(
                0.0, 0.0),
            child: FaIcon(FontAwesomeIcons.repeat, color: theme.info,),
          ),
          SizedBox(width: 20,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(routine["nom"], style: theme.titleMedium,),
              Container(width: 50.w, child: Text(routine["description"], style: theme.bodySmall,),)
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              QudsPopupButton(
                items: [
                  QudsPopupMenuItem(
                    leading: FaIcon(FontAwesomeIcons.penToSquare, color: theme.primaryText,),
                    title: Text("Modifier", style: FlutterFlowTheme.of(context).bodyMedium,),
                    onPressed: () {
                      Navigator.of(context).pushNamed(RoutineEditScreen.routeName, arguments: routine).then((value) => onThen());
                  }),
                  QudsPopupMenuDivider(),
                  QudsPopupMenuItem(
                    leading: FaIcon(FontAwesomeIcons.xmark, color: theme.error,),
                    title: Text("Supprimer", style: FlutterFlowTheme.of(context).bodyMedium,),
                    onPressed: () {
                      deleteCallback();
                  }),
                ],
                child: Container(
                  height: 75,
                  width: 50,
                  child: Center(child: Icon(Icons.more_vert)),
                )
                ,
              )
            ],
          )
        ],
      ),
    );                              
  }
}
