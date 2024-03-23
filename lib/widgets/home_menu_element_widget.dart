import 'package:flutter/material.dart';

class HomeMenuElementWidget extends StatelessWidget {
  final Function callback;
  final Widget icon;
  final Color iconColor;
  final String title;
  final TextStyle titleStyle;
  final String? description;
  final TextStyle? descriptionStyle;
  
  HomeMenuElementWidget({
    required this.icon, 
    required this.iconColor, 
    required this.title, 
    required this.titleStyle,
    required this.description,
    required this.descriptionStyle, 
    required this.callback
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(
          0.0, 12.0, 0.0, 12.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(16.0),
        splashColor: iconColor.withAlpha(81),
        onTap: () => callback(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(
                color: iconColor.withAlpha(81),
                borderRadius:
                    BorderRadius.circular(16.0),
              ),
              alignment: AlignmentDirectional(
                  0.0, 0.0),
              child: icon,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional
                    .fromSTEB(
                        24.0, 0.0, 0.0, 0.0),
                child: Column(
                  mainAxisSize:
                      MainAxisSize.max,
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: titleStyle,
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
                        description ?? "",
                        style: descriptionStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );                              
  }
}
