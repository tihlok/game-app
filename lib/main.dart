import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:game_app_flutter/components.dart';
import 'package:game_app_flutter/login.dart';
import 'package:game_app_flutter/personas.dart';
import 'package:game_app_flutter/player.dart';
import 'package:game_app_flutter/profile.dart';
import 'package:game_app_flutter/tab.dart';
import 'package:game_app_flutter/theme.dart';

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
          primaryColor: primary,
          accentColor: white,
          scaffoldBackgroundColor: background,
          textTheme: TextTheme(
            subtitle1: TextStyle(color: white),
            caption: TextStyle(color: white),
            bodyText2: TextStyle(color: white),
          ),
          buttonTheme: ButtonThemeData(
            textTheme: ButtonTextTheme.primary,
            buttonColor: primary,
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
  AppPageState createState() => AppPageState();
}

class AppPageState extends State<AppPage> with TickerProviderStateMixin {
  @override
  void initState() {
    Redux.store.dispatch(playerTryQuickLoginAction);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, AppState>(
        distinct: true,
        converter: (store) => store.state,
        builder: (context, state) => tabs(
          isLoading: state.player.isLoading,
          showAppBar: state.player.isLoggedIn,
          showTabs: state.player.isLoggedIn,
          defaultPage: Login(),
          titleAppBar: "RPG",
          tabs: [
            TabData(icon: Icons.accessibility, page: Personas(state: state)),
            TabData(icon: Icons.settings, page: Profile(state: state)),
          ],
        ),
      );
}
