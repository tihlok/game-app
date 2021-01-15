import 'package:game_app_flutter/player.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

AppState appReducer(AppState state, dynamic action) {
  if (action is SetPlayerStateAction) {
    return state.copyWith(playerState: playerReducer(state.playerState, action));
  }
  return state;
}

@immutable
class AppState {
  final PlayerState playerState;

  AppState({
    @required this.playerState,
  });

  AppState copyWith({
    PlayerState playerState,
  }) =>
      AppState(
        playerState: playerState ?? this.playerState,
      );
}

class Redux {
  static Store<AppState> _store;

  static Store<AppState> get store {
    if (_store == null) throw Exception("store is not initialized");
    return _store;
  }

  static Future<void> init() async {
    _store = Store<AppState>(
      appReducer,
      middleware: [thunkMiddleware],
      initialState: AppState(playerState: PlayerState.initial()),
    );
  }
}
