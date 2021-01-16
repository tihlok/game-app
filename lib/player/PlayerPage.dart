import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:game_app_flutter/app/AppRedux.dart';
import 'package:game_app_flutter/app/AppState.dart';
import 'package:game_app_flutter/player/PlayerAction.dart';

class PlayerPage extends StatelessWidget {
  void _onLogoutPressed() {
    AppRedux.store.dispatch(PlayerAction.playerLogoutAction);
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      distinct: true,
      converter: (store) => store.state,
      builder: (context, state) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              border: Border.all(color: state.theme.primary, width: 4.0),
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(state.player.picture),
              ),
            ),
          ),
          SizedBox(height: 24.0),
          Text(state.player.id),
          SizedBox(height: 24.0),
          Text(state.player.name),
          SizedBox(height: 48.0),
          RaisedButton(
            onPressed: () => _onLogoutPressed(),
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }
}
