import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:game_app_flutter/app/AppPage.dart';
import 'package:game_app_flutter/app/AppRedux.dart';
import 'package:game_app_flutter/app/AppState.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: AppRedux.store,
      child: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) => MaterialApp(
          title: 'RPG',
          theme: ThemeData(
              primaryColor: state.theme.primary,
              accentColor: state.theme.white,
              scaffoldBackgroundColor: state.theme.background,
              textTheme: TextTheme(
                subtitle1: TextStyle(color: state.theme.white),
                caption: TextStyle(color: state.theme.white),
                bodyText2: TextStyle(color: state.theme.white),
              ),
              buttonTheme: ButtonThemeData(
                textTheme: ButtonTextTheme.primary,
                buttonColor: state.theme.primary,
              )),
          home: AppPage(title: 'RPG'),
        ),
      ),
    );
  }
}
