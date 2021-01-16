import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:game_app_flutter/app/AppPage.dart';
import 'package:game_app_flutter/app/AppRedux.dart';
import 'package:game_app_flutter/app/AppState.dart';
import 'package:game_app_flutter/components/Tabs.dart';
import 'package:game_app_flutter/login/LoginPage.dart';
import 'package:game_app_flutter/personas/PersonaListPage.dart';
import 'package:game_app_flutter/player/PlayerAction.dart';
import 'package:game_app_flutter/player/PlayerPage.dart';

class AppPageState extends State<AppPage> with TickerProviderStateMixin {
  @override
  void initState() {
    AppRedux.store.dispatch(PlayerAction.playerTryQuickLoginAction);
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
          defaultPage: LoginPage(),
          titleAppBar: "RPG",
          tabs: [
            TabData(icon: Icons.accessibility, page: PersonaListPage()),
            TabData(icon: Icons.settings, page: PlayerPage()),
          ],
        ),
      );
}
