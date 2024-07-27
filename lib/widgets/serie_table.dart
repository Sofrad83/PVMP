import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pvmp/bloc/cubit/training_cubit.dart';
import 'package:pvmp/flutter_flow/flutter_flow_theme.dart';
import 'package:pvmp/models/json_model.dart';
import 'package:pvmp/utilities/logger.dart';

class SerieTable extends StatelessWidget {
  final Json exercice;
  final TextEditingController repController = TextEditingController();
  final TextEditingController poidsController = TextEditingController();
  final FocusNode repFocus = FocusNode();
  final FocusNode poidsFocus = FocusNode();

  SerieTable({super.key, required this.exercice});

  @override
  Widget build(BuildContext context) {
    FlutterFlowTheme theme = FlutterFlowTheme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(0,8,0,8),
      child: Container(
        width: 95.w,
        decoration: BoxDecoration(
          color: theme.primaryBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: theme.primaryText, width: 2)
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: theme.lineColor, width: 2))),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => context.read<TrainingCubit>().setZoom(zoom: true, zoomUrl: exercice["img_url"]),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
                      child: Image.network(
                        exercice["img_url"],
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            exercice["nom"],
                            style: theme.titleMedium,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: theme.lineColor, width: 2))),
              child: Row(
                children: [
                  Container(
                    width: 15.w,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text("Série", textAlign: TextAlign.center,),
                    ),
                  ),
                  Container(
                    width: 30.w,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text("Rép", textAlign: TextAlign.center,),
                    ),
                  ),
                  Container(
                    width: 30.w,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text("Poids (kg)", textAlign: TextAlign.center,),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(""),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: theme.lineColor, width: 2))),
              child: Column(
                children: exercice["last_series"].map<Widget>(
                  (serie) => SerieRow(
                    serie: serie, 
                    onTap: () {
                      if(serie["done"] == true){
                        context.read<TrainingCubit>().removeSerie(serie: serie);
                      }else{
                        context.read<TrainingCubit>().confirmSerie(serie: serie);
                      }

                    },
                  )
                ).toList(),
              ),
            ),
            Form(
              child: Row(
                children: [
                  Container(
                    width: 15.w,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text("", textAlign: TextAlign.center,),
                    ),
                  ),
                  Container(
                    width: 30.w,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        height: 30,
                        child: TextFormField(
                          onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(poidsFocus),
                          controller: repController,
                          focusNode: repFocus,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 30.w,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        height: 30,
                        child: TextFormField(
                          controller: poidsController,
                          focusNode: poidsFocus,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        context.read<TrainingCubit>().addSerie(
                          serie: {
                            "nb_rep": int.parse(repController.text),
                            'poids': double.parse(poidsController.text),
                            'exercice_id': exercice["id"]
                          }
                        );
                      } ,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(25,0,25,0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Center(child: FaIcon(FontAwesomeIcons.plus, color: Colors.black, size: 15,)),
                          )
                        ),
                      ),
                    )
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SerieRow extends StatelessWidget {
  const SerieRow({super.key, required this.serie, required this.onTap});
  final Json serie;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    FlutterFlowTheme theme = FlutterFlowTheme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: serie["done"] ? theme.success.withAlpha(40) : Colors.transparent,
        border: Border(bottom: BorderSide(color: theme.lineColor))
      ),
      child: Row(
        children: [
          Container(
            width: 15.w,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(serie["serie_number"].toString(), textAlign: TextAlign.center,),
            ),
          ),
          Container(
            width: 30.w,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                height: 30,
                child: serie["done"] ? 
                  Text(serie['nb_rep'].toString(), textAlign: TextAlign.center,) : 
                  TextField(
                  controller: TextEditingController(text: serie['nb_rep'].toString()),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
          ),
          Container(
            width: 30.w,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                height: 30,
                child: serie["done"] ? 
                  Text(serie['poids'].toString(), textAlign: TextAlign.center,) : 
                  TextField(
                  controller: TextEditingController(text: serie['poids'].toString()),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => onTap(),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25,0,25,0),
                child: Container(
                  decoration: BoxDecoration(
                    color: serie["done"] ? theme.tertiary.withAlpha(200) : theme.primaryText,
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Center(
                      child: FaIcon(
                        serie["done"] ? FontAwesomeIcons.xmark : FontAwesomeIcons.check, 
                        color: serie["done"] ? Colors.white : Colors.black, 
                        size: 15,
                      )
                    ),
                  )
                ),
              ),
            )
          ),
        ],
      ),
    );
  }
}