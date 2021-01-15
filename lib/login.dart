import 'package:flutter/material.dart';
import 'package:game_app_flutter/app.dart';
import 'package:game_app_flutter/player.dart';

class Login extends StatelessWidget {
  const Login();

  void _onLoginPressed() {
    Redux.store.dispatch(playerLoginAction);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image(
          image: AssetImage("assets/dice.png"),
        ),
        InkWell(
          splashColor: Colors.red[900],
          onTap: () => _onLoginPressed(),
          child: Text("Login"),
        )
      ],
    );
  }
}
