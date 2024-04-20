import 'package:flutter/material.dart';
class MyAccountScreen extends StatelessWidget {
  MyAccountScreen({Key? key});
  static const routeName = "MyAccountScreen";
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: const Scaffold(
        body: Center(child: Text("MyAccountScreen")),
      ),
    );
  }
}