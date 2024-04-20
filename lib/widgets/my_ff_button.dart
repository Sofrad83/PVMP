import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pvmp/flutter_flow/flutter_flow_theme.dart';
import 'package:pvmp/flutter_flow/flutter_flow_widgets.dart';

class MyFfButton extends StatelessWidget {
  final String label;
  final Function onPressed;
  final Color? color;
  final Color? labelColor;
  final double? width;

  const MyFfButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color,
    this.labelColor,
    this.width
  });

  @override
  Widget build(BuildContext context) {
    return FFButtonWidget(
      text: label,
      onPressed: () => onPressed(),
      options: FFButtonOptions(
        width: width,
        padding:
            const EdgeInsets.all(10),
        iconPadding:
            const EdgeInsetsDirectional
                .fromSTEB(
                    0.0,
                    0.0,
                    0.0,
                    0.0),
        color: color ??
            FlutterFlowTheme.of(
                    context)
                .primary,
        textStyle:
            FlutterFlowTheme.of(
                    context)
                .titleSmall
                .override(
                  fontFamily: FlutterFlowTheme.of(
                          context)
                      .titleSmallFamily,
                  color: labelColor ??Colors
                      .white,
                  useGoogleFonts: GoogleFonts
                          .asMap()
                      .containsKey(
                          FlutterFlowTheme.of(
                          context)
                              .titleSmallFamily),
                ),
        elevation: 3.0,
        borderSide: const BorderSide(
          color: Colors
              .transparent,
          width: 1.0,
        ),
        borderRadius:
            BorderRadius
                .circular(12.0),
      ));
  }
}