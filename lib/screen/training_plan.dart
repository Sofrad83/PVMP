import 'package:flutter/material.dart';
class TrainingPlanScreen extends StatelessWidget {
  TrainingPlanScreen({Key? key});
  static const routeName = "TrainingPlanScreen";
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: const Scaffold(
        body: Center(child: Text("TrainingPlanScreen")),
      ),
    );
  }
}