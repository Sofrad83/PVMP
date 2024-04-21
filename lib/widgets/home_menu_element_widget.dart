import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pvmp/flutter_flow/flutter_flow_theme.dart';

class HomeMenuElementWidget extends StatelessWidget {
  final Function callback;
  final Widget icon;
  final Color iconColor;
  final String title;
  final TextStyle titleStyle;
  final String? description;
  final TextStyle? descriptionStyle;
  final bool comingSoon;
  
  HomeMenuElementWidget({
    required this.icon, 
    required this.iconColor, 
    required this.title, 
    required this.titleStyle,
    required this.description,
    required this.descriptionStyle, 
    required this.callback,
    this.comingSoon = false
  });

  @override
  Widget build(BuildContext context) {
    FlutterFlowTheme theme = FlutterFlowTheme.of(context);
    return Stack(
      children: [
        Padding(
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
        ),
        Visibility(
          visible: comingSoon,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0,12,0,12),
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(200),
                borderRadius: BorderRadius.circular(16)
              ),
              child: Center(
                child: Text("Bientôt dispo", style: GoogleFonts.getFont(
                  "Urbanist",
                  fontWeight: FontWeight.w700, 
                  color: theme.primary,
                  fontSize: 20
                )),
              ),
            ),
          ),
        )
      ],
    );                              
  }
}
