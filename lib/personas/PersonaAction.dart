import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:game_app_flutter/app.dart';
import 'package:game_app_flutter/config.dart';
import 'package:game_app_flutter/personas/Persona.dart';
import 'package:game_app_flutter/personas/PersonaState.dart';
import 'package:game_app_flutter/player.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';

@immutable
class PersonaAction {
  final PersonaState state;

  PersonaAction(this.state);

  static Future<void> loadPersonas(Store<AppState> store) async {
    store.dispatch(SetPlayerStateAction(PlayerState(isLoading: true)));
    final response = await http.get("$SERVER_URL/personas/${store.state.player.id}");
    final decoded = jsonDecode(response.body);
    final personas = List<Persona>.from(decoded.map((m) => Persona.fromJSON(m)));
    store.dispatch(PersonaAction(PersonaState(personas: personas)));
    store.dispatch(SetPlayerStateAction(PlayerState(isLoading: false)));
  }
}
