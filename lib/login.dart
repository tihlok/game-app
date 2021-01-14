import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  final loginAction;
  final String loginError;

  const Login(this.loginAction, this.loginError);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image(
          image: AssetImage("assets/dice.png"),
        ),
        RaisedButton(
          onPressed: () {
            loginAction();
          },
          child: Text("Login"),
        ),
        Text(loginError ?? ""),
        Text(kIsWeb ? "web" : Platform.operatingSystem)
      ],
    );
  }
}
