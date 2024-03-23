import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pvmp/flutter_flow/flutter_flow_theme.dart';
import 'package:pvmp/models/citation.dart';

class CitationCard extends StatelessWidget {
  final Citation? citation;
  final bool isLoading;
  
  const CitationCard({
    super.key,
    required this.citation,
    required this.isLoading
  });

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    FlutterFlowTheme theme = FlutterFlowTheme.of(context);

    return Container(
      width: screenSize.width * 0.9,
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.lineColor,
          width: 2
        ),
        borderRadius: BorderRadius.circular(20),
        color: theme.secondaryBackground
      ),
      child: isLoading == false ? Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: Center(
              child: Text(
                citation!.texte,
                style: TextStyle(
                  fontSize: 17,
                  fontStyle: FontStyle.italic,
                  fontFamily: theme.bodyMedium.fontFamily,
                  color: theme.bodyMedium.color,
                  letterSpacing: theme.bodyMedium.letterSpacing,
                  decoration: theme.bodyMedium.decoration,
                ),
              )
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 10, 10), 
                child: Text(
                  "- ${citation!.auteur} -",
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: theme.bodyMedium.fontFamily,
                    color: theme.bodyMedium.color,
                    letterSpacing: theme.bodyMedium.letterSpacing,
                    decoration: theme.bodyMedium.decoration,
                  ),
                ),
              )
            ],
          )
        ],
      ) : Padding(
        padding: EdgeInsets.all(30),
        child: Center(child: CircularProgressIndicator(color: theme.primaryText,),),
      ),
    );                              
  }
}
