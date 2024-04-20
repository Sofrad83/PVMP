import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  static const routeName = "ForgotPassword";

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';

  void _submit() {
    final form = _formKey.currentState;
    if (form != null && form.validate()) {
      form.save();
      // Ici, vous pouvez ajouter votre logique pour gérer la demande de réinitialisation du mot de passe.
      // Par exemple, vous pourriez appeler un provider ou un bloc avec la valeur _email pour envoyer un email de réinitialisation.
      print('Requesting password reset for Email: $_email');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Forgot Password'),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email address',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    // Ajoutez ici d'autres validations si nécessaire, comme la validation du format de l'email.
                    return null;
                  },
                  onSaved: (value) => _email = value ?? '',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: _submit,
                  child: Text('Reset Password'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
