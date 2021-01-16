import 'package:game_app_flutter/personas/PersonaAction.dart';
import 'package:game_app_flutter/personas/PersonaState.dart';

personaReducer(PersonaState state, PersonaAction action) {
  final payload = action.state;
  return state.copyWith(
    personas: payload.personas,
  );
}
