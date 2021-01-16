import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:game_app_flutter/app/AppRedux.dart';
import 'package:game_app_flutter/app/AppState.dart';
import 'package:game_app_flutter/player/PlayerAction.dart';

class LoginPage extends StatelessWidget {
  void _onLoginPressed() {
    AppRedux.store.dispatch(PlayerAction.playerLoginAction);
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      distinct: true,
      converter: (store) => store.state,
      builder: (context, state) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(
            image: AssetImage("assets/dice.png"),
          ),
          InkWell(
            splashColor: state.theme.primary,
            onTap: () => _onLoginPressed(),
            child: Text("Login"),
          )
        ],
      ),
    );
  }
}
