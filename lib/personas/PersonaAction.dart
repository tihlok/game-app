import 'dart:convert';

import 'package:game_app_flutter/app/AppState.dart';
import 'package:game_app_flutter/config.dart';
import 'package:game_app_flutter/personas/Persona.dart';
import 'package:game_app_flutter/personas/PersonaState.dart';
import 'package:game_app_flutter/player/PlayerAction.dart';
import 'package:game_app_flutter/player/PlayerState.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

@immutable
class PersonaAction {
  final PersonaState state;

  PersonaAction(this.state);

  static Future<void> loadPersonas(Store<AppState> store) async {
    store.dispatch(PlayerAction(PlayerState(isLoading: true)));
    final response = await http.get("$SERVER_URL/personas/${store.state.player.id}");
    final decoded = jsonDecode(response.body);
    final personas = List<Persona>.from(decoded.map((m) => Persona.fromJSON(m)));
    store.dispatch(PersonaAction(PersonaState(personas: personas)));
    store.dispatch(PlayerAction(PlayerState(isLoading: false)));
  }
}
