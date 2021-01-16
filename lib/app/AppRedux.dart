import 'package:game_app_flutter/app/AppReducer.dart';
import 'package:game_app_flutter/app/AppState.dart';
import 'package:game_app_flutter/personas/PersonaState.dart';
import 'package:game_app_flutter/player/PlayerState.dart';
import 'package:game_app_flutter/themes/DefaultTheme.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class AppRedux {
  static Store<AppState> _store;

  static Store<AppState> get store {
    if (_store == null) throw Exception("store is not initialized");
    return _store;
  }

  static Future<void> init() async {
    _store = Store<AppState>(
      appReducer,
      middleware: [thunkMiddleware],
      initialState: AppState(
        theme: DefaultTheme(),
        player: PlayerState.initial(),
        persona: PersonaState.initial(),
      ),
    );
  }
}
