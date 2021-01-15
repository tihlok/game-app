import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:game_app_flutter/login.dart';
import 'package:game_app_flutter/personas.dart';
import 'package:game_app_flutter/player.dart';
import 'package:game_app_flutter/profile.dart';
import 'package:game_app_flutter/tab.dart';

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
  @override
  void initState() {
    Redux.store.dispatch(playerTryQuickLoginAction);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        distinct: true,
        converter: (store) => store.state,
        builder: (context, state) {
          final tabs = [
            TabData(icon: Icons.accessibility, page: Personas(state: state)),
            TabData(icon: Icons.settings, page: Profile(state: state)),
          ];

          return DefaultTabController(
              length: tabs.length,
              child: Scaffold(
                appBar: state.player.isLoggedIn
                    ? AppBar(
                        title: Center(child: Text("RPG")),
                        bottom: TabBar(tabs: tabs.map((e) => e.tab).toList()),
                      )
                    : null,
                body: Center(
                    child: state.player.isLoading
                        ? CircularProgressIndicator()
                        : state.player.isLoggedIn
                            ? TabBarView(children: tabs.map((e) => e.page).toList())
                            : Login()),
              ));
        });
  }
}
