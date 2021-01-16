import 'package:flutter/material.dart';
import 'package:game_app_flutter/player.dart';
import 'package:game_app_flutter/theme.dart';

import 'app.dart';

class Profile extends StatelessWidget {
  final AppState state;

  Profile({this.state});

  void _onLogoutPressed() {
    Redux.store.dispatch(playerLogoutAction);
  }

  @override
  Widget build(BuildContext context) {
    final player = state.player;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(color: AppTheme.primary, width: 4.0),
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(player.picture),
            ),
          ),
        ),
        SizedBox(height: 24.0),
        Text(player.id),
        SizedBox(height: 24.0),
        Text(player.name),
        SizedBox(height: 48.0),
        RaisedButton(
          onPressed: () => _onLogoutPressed(),
          child: Text('Logout'),
        ),
      ],
    );
  }
}
