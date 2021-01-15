import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:game_app_flutter/player.dart';

import 'app.dart';

void main() async {
  await Redux.init();
  runApp(RPGApp());
}

class RPGApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RPG',
      theme: ThemeData(
          primaryColor: Colors.red[900],
          accentColor: Colors.white,
          scaffoldBackgroundColor: Color(0xFF1F1F1F),
          textTheme: TextTheme(bodyText2: TextStyle(color: Colors.white)),
          buttonTheme: ButtonThemeData(
            textTheme: ButtonTextTheme.primary,
            buttonColor: Colors.red[900],
          )),
      home: StoreProvider<AppState>(
        store: Redux.store,
        child: AppPage(title: 'RPG'),
      ),
    );
  }
}

class AppPage extends StatefulWidget {
  AppPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  void _onLoginPressed() {
    Redux.store.dispatch(playerLoginAction);
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PlayerState>(
        distinct: true,
        converter: (store) => store.state.playerState,
        builder: (context, player) => Scaffold(
            appBar: AppBar(title: Text(widget.title)),
            body: Column(
              children: <Widget>[
                RaisedButton(
                  child: Text("login"),
                  onPressed: _onLoginPressed,
                ),
                Text("isLoading ${player.isLoading}"),
                Text("isLoggedIn ${player.isLoggedIn}"),
                Text("isError ${player.isError}"),
              ],
            )));
  }
}
