import 'package:flutter/material.dart';
import 'package:game_app_flutter/player.dart';

import 'app.dart';

class Profile extends StatelessWidget {
  final AppState state;

  Profile({this.state});

  void _onLogoutPressed() {
    Redux.store.dispatch(playerLogoutAction);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red[900], width: 4.0),
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(this.state.player.picture),
            ),
          ),
        ),
        SizedBox(height: 24.0),
        Text(this.state.player.id),
        SizedBox(height: 24.0),
        Text(this.state.player.name),
        SizedBox(height: 48.0),
        RaisedButton(
          onPressed: () => _onLogoutPressed(),
          child: Text('Logout'),
        ),
      ],
    );
  }
}
