import 'package:flutter/material.dart';
class MyFriendsScreen extends StatelessWidget {
  MyFriendsScreen({Key? key});
  static const routeName = "MyFriendsScreen";
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: const Scaffold(
        body: Center(child: Text("MyFriendsScreen")),
      ),
    );
  }
}