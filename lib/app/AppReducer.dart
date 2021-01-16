import 'package:game_app_flutter/app/AppState.dart';
import 'package:game_app_flutter/personas/PersonaAction.dart';
import 'package:game_app_flutter/personas/PersonaReducer.dart';
import 'package:game_app_flutter/player/PlayerAction.dart';
import 'package:game_app_flutter/player/PlayerReducer.dart';

AppState appReducer(AppState state, dynamic action) {
  if (action is PlayerAction) {
    return state.copyWith(player: playerReducer(state.player, action));
  }
  if (action is PersonaAction) {
    return state.copyWith(persona: personaReducer(state.persona, action));
  }
  return state;
}
