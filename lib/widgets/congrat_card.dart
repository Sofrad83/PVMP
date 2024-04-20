import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pvmp/flutter_flow/flutter_flow_theme.dart';

class CongratCard extends StatelessWidget {
  CongratCard({super.key, required this.volume});
  final double volume;

  final Map<int, Map> comparatif = {
    100: {"desc" : "C'est le poids d'une moto", "img" : "moto.png"},
    200: {"desc" : "C'est le poids d'un piano à queue", "img" : "petit_piano.png"},
    300: {"desc" : "C'est le poids d'une grande statue de jardin en marbre", "img" : "statue.png"},
    400: {"desc" : "C'est le poids d'une petite voiture", "img" : "petite_voiture.png"},
    500: {"desc" : "C'est le poids d'un grand piano à queue", "img" : "piano.png"},
    600: {"desc" : "C'est le poids d'une girafe adulte", "img" : "girafe.png"},
    700: {"desc" : "C'est le poids d'une voiture de taille moyenne", "img" : "voiture.png"},
    800: {"desc" : "C'est le poids d'une camionnette", "img" : "van.png"},
    900: {"desc" : "C'est le poids d'une voiture familiale de grande taille", "img" : "voiture_famille.png"},
    1000: {"desc" : "C'est le poids d'une voiture de sport", "img" : "voiture_sport.png"},
    2000: {"desc" : "C'est le poids d'un rhinocéros adulte", "img" : "rhino.png"},
    3000: {"desc" : "C'est le poids d'un éléphant d'Asie jeune", "img" : "elephant.png"},
    4000: {"desc" : "C'est le poids d'un petit camion", "img" : "camionnette.png"},
    5000: {"desc" : "C'est le poids d'un hippopotame adulte", "img" : "hippo.png"},
    6000: {"desc" : "C'est le poids d'un gros camion de pompiers", "img" : "camion_pompier.png"},
    7000: {"desc" : "C'est le poids d'un bus scolaire", "img" : "bus.png"},
    8000: {"desc" : "C'est le poids d'un T-Rex adulte", "img" : "trex.png"},
    9000: {"desc" : "C'est le poids d'un camion-benne", "img" : "camion_benne.png"},
    10000: {"desc" : "C'est le poids d'un camion de 18 roues (vide)", "img" : "gros_camion.png"},
    11000: {"desc" : "C'est le poids d'un petit hélicoptère", "img" : "helico.png"},
    19000: {"desc" : "C'est le poids d'un gros hélicoptère", "img" : "gros_helico.png"},
    20000: {"desc" : "C'est le poids d'un avion de chasse (vide)", "img" : "avion_chasse.png"},
    99999: {"desc" : "C'est très lourd, tu pourrais soulever une baleine !", "img" : "baleine.png"}
  };

  Map? compare(double poids){
    for (var key in comparatif.keys.toList()..sort()) {
      if (poids <= key) {
        return comparatif[key]!;
      }
    }
    return null;
  }


  @override
  Widget build(BuildContext context) {
    Map? monCompare = compare(volume);
    FlutterFlowTheme theme = FlutterFlowTheme.of(context);
    return Container(
      width: 90.w,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset("assets/images/poids/${monCompare!["img"]}", width: 75.w,)
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  "Bravo ! Tu as soulevé",
                  style: theme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  "${NumberFormat.currency(locale: "fr_FR", symbol: "").format(volume)} kg",
                  style: GoogleFonts.getFont(
                    'Urbanist',
                    fontWeight: FontWeight.w800,
                    fontSize: 35,
                    color: theme.primary
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  monCompare["desc"],
                  style: theme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}