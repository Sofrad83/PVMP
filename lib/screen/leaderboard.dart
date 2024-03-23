import 'package:flutter/material.dart';
class LeaderBoardScreen extends StatelessWidget {
  LeaderBoardScreen({Key? key});
  static const routeName = "LeaderBoardScreen";
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("LeaderBoardScreen")),
    );
  }
}