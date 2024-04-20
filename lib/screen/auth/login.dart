// ignore_for_file: use_build_context_synchronously

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:pvmp/bloc/cubit/connexion_cubit.dart';
import 'package:pvmp/bloc/state/connexion_state.dart';
import 'package:pvmp/screen/auth/register.dart';
import 'package:pvmp/screen/home.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  static const routeName = "Login";

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login>{

  final scaffoldKey = GlobalKey<ScaffoldState>();
  
  final mainform = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController(text: "test1@test.fr");
  TextEditingController mdpController = TextEditingController(text: "123456");

  String? email;
  String? mdp;

  bool mdpIsVisible = false;

  bool validateEmail(String mail) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-_]+\.[a-zA-Z]+").hasMatch(mail);
  }

  void callLogin(ConnexionCubit connexionCubit) async{
    bool isValid = mainform.currentState!.validate();
    if(isValid){
      email = emailController.text;
      mdp = mdpController.text;
      await connexionCubit.login(email!, mdp!);
      // try{
      //   email = emailController.text;
      //   mdp = mdpController.text;

      //   Auth _auth = Provider.of<Auth>(context, listen: false);
      //   await _auth.login(email!, mdp!);
      //   Navigator.of(context).pushNamedAndRemoveUntil(HomePageScreen.routeName, (route) => false);
      // } on FormatException catch(e){
      //   print(e);
      //   Flushbar(
      //     messageText: Text(e.message, style: FlutterFlowTheme.of(context).bodyMedium,),
      //     backgroundColor: FlutterFlowTheme.of(context).error,
      //     duration: Duration(seconds: 3),
      //     flushbarPosition: FlushbarPosition.BOTTOM,
      //     flushbarStyle: FlushbarStyle.FLOATING,
      //   ).show(context);
      // }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ConnexionCubit, ConnexionState>(
      listener: (context, state) {

        if(state is ConnexionErrorState) {
          Logger().e(state.error);
        }

      },
      builder: (context, state) {
        if(state is ConnexionErrorState){
          Flushbar(
            messageText: Text(state.error, style: FlutterFlowTheme.of(context).bodyMedium,),
            backgroundColor: FlutterFlowTheme.of(context).error,
            duration: const Duration(seconds: 3),
            flushbarPosition: FlushbarPosition.BOTTOM,
            flushbarStyle: FlushbarStyle.FLOATING,
          ).show(context);
        }
        if(state is ConnexionLoadedState){
          if(state.connexion != null){
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushNamedAndRemoveUntil(HomePageScreen.routeName, (route) => false);
            });
          }
        }
        return SafeArea(
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            body: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset("assets/images/login.png", fit: BoxFit.cover,),
                Form(
                  key: mainform,
                  child: SingleChildScrollView(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 75,),
                              Container(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    'assets/images/logo-transparent.png',
                                    width: 501.0,
                                    height: 200.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                                child: Text(
                                  'Connexion',
                                  style: FlutterFlowTheme.of(context).headlineSmall,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0.0, 40.0, 0.0, 16.0),
                                child: Container(
                                  width: double.infinity,
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Merci de remplir ce champ.';
                                      }
                                      if (validateEmail(value) == false) {
                                        return 'Email invalide';
                                      }
                                      return null;
                                    },
                                    controller: emailController,
                                    autofillHints: [AutofillHints.email],
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Email',
                                      labelStyle:
                                          FlutterFlowTheme.of(context).labelMedium,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context).primaryText,
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context).primary,
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context).error,
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context).error,
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      filled: true,
                                      fillColor: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      contentPadding: EdgeInsets.all(24.0),
                                    ),
                                    style: FlutterFlowTheme.of(context).bodyMedium,
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                                child: Container(
                                  width: double.infinity,
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Merci de remplir ce champ.';
                                      }
                                      return null;
                                    },
                                    controller: mdpController,
                                    autofillHints: [AutofillHints.password],
                                    obscureText: !mdpIsVisible,
                                    decoration: InputDecoration(
                                      labelText: 'Mot de passe',
                                      labelStyle:
                                          FlutterFlowTheme.of(context).labelMedium,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context).primaryText,
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context).primary,
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context).error,
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context).error,
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      filled: true,
                                      fillColor: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      contentPadding: EdgeInsets.all(24.0),
                                      suffixIcon: InkWell(
                                        onTap: () => setState(
                                          () => mdpIsVisible = !mdpIsVisible
                                        ),
                                        focusNode: FocusNode(skipTraversal: true),
                                        child: Icon(
                                          mdpIsVisible
                                              ? Icons.visibility_outlined
                                              : 
                                              Icons.visibility_off_outlined,
                                          color:
                                              FlutterFlowTheme.of(context).secondaryText,
                                          size: 24.0,
                                        ),
                                      ),
                                    ),
                                    style: FlutterFlowTheme.of(context).bodyMedium,
                                    // validator: _model.passwordControllerValidator
                                    //     .asValidator(context),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Padding(
                                  padding:
                                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                                  child: FFButtonWidget(
                                    // onPressed: () async {
                                    //   print("Email : " + emailController.text);
                                    //   print("mdp : " + mdpController.text);
                                    // },
                                    onPressed: () => callLogin(context.read<ConnexionCubit>()),
                                    text: 'Se connecter',
                                    options: FFButtonOptions(
                                      width: 230.0,
                                      height: 52.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 0.0),
                                      iconPadding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 0.0),
                                      color: FlutterFlowTheme.of(context).primary,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily: FlutterFlowTheme.of(context)
                                                .titleSmallFamily,
                                            color: Colors.white,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey(FlutterFlowTheme.of(context)
                                                    .titleSmallFamily),
                                          ),
                                      elevation: 3.0,
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Padding(
                                  padding:
                                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                                  child: FFButtonWidget(
                                    onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(Register.routeName, (route) => false),
                                    text: 'Créer mon compte',
                                    options: FFButtonOptions(
                                      width: 230.0,
                                      height: 44.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 0.0),
                                      iconPadding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 0.0),
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      textStyle: FlutterFlowTheme.of(context).bodyMedium,
                                      elevation: 0.0,
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                ),
                              ),],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                )
              ],
            )
            ),
        );
      },
    );
  }
}
