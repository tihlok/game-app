import 'package:game_app_flutter/personas.dart';
import 'package:game_app_flutter/player.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

AppState appReducer(AppState state, dynamic action) {
  if (action is SetPlayerStateAction) {
    return state.copyWith(player: playerReducer(state.player, action));
  }
  if (action is SetPersonaStateAction) {
    return state.copyWith(persona: personaReducer(state.persona, action));
  }
  return state;
}

@immutable
class AppState {
  final PlayerState player;
  final PersonaState persona;

  AppState({
    @required this.player,
    @required this.persona,
  });

  AppState copyWith({
    PlayerState player,
    PersonaState persona,
  }) =>
      AppState(
        player: player ?? this.player,
        persona: persona ?? this.persona,
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
      initialState: AppState(
        player: PlayerState.initial(),
        persona: PersonaState.initial(),
      ),
    );
  }
}
