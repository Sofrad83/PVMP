import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pvmp/providers/auth.dart';
import 'package:pvmp/screen/home.dart';

class Splashscreen extends StatefulWidget {
  Splashscreen({Key? key});
  static const routeName = "Splashscreen";

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  final scaffoldKey = GlobalKey<ScaffoldState>();

  void initSession() async{
      var _authP = Provider.of<Auth>(context, listen: false);
      _authP.getSession();
      // Future.delayed(const Duration(seconds: 3), () {
      //   Navigator.of(context).pushReplacementNamed(HomePageScreen.routeName);
      // });
  }

  @override
  void initState() {
    super.initState();
    initSession();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset("assets/images/splashscreen.png", fit: BoxFit.cover,);
  }
}