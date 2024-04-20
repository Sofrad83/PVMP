import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pvmp/flutter_flow/flutter_flow_theme.dart';
import 'package:pvmp/models/json_model.dart';

class ExoRow extends StatelessWidget {
  const ExoRow({super.key, required this.exo, required this.onXPressed});
  final Json exo;
  final Function onXPressed;

  @override
  Widget build(BuildContext context) {
    FlutterFlowTheme theme = FlutterFlowTheme.of(context);

    return Container(
      decoration: const BoxDecoration(border: Border(top: BorderSide(width: 0.5, color: Colors.grey), bottom: BorderSide(width: 0.5, color: Colors.grey))),
      child: Row(
        children: [
          Image.network(
            exo["img_url"],
            width: 90,
            height: 90,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exo["nom"],
                    style: theme.titleMedium,
                  ),
                  Container(
                    width: 50.w,
                    child: Text(
                      exo["description"],
                      style: theme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () => onXPressed(),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: FaIcon(FontAwesomeIcons.xmark, color: theme.error,),
            ),
          )
        ],
      ),
    );
  }
}
