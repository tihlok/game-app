import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:game_app_flutter/app.dart';
import 'package:game_app_flutter/config.dart';
import 'package:game_app_flutter/player.dart';
import 'package:game_app_flutter/theme.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';

import 'components.dart';

class Skill {
  final int id;
  final String name;
  final String type;
  final int basePower;

  const Skill({
    this.id,
    this.name,
    this.type,
    this.basePower,
  });

  get power => this.basePower;

  factory Skill.fromJSON(Map<String, dynamic> json) => Skill(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        basePower: json["base_power"],
      );
}

class Persona {
  final int id;
  final String name;
  final String origin;
  final String imageURL;
  final int level;
  final int maxHP;
  final int currentHP;
  final int tacticalStress;
  final int combatStress;
  final List<Skill> skills;

  const Persona({
    this.id,
    this.name,
    this.origin,
    this.imageURL,
    this.level,
    this.maxHP,
    this.currentHP,
    this.tacticalStress,
    this.combatStress,
    this.skills,
  });

  get power => this.skills.length > 0 ? this.skills.map((m) => m.power).reduce((p, e) => p + e) : 0;

  get title => "[${this.level}] ${this.name}";

  factory Persona.fromJSON(Map<String, dynamic> json) => Persona(
        id: json["id"],
        name: json["name"],
        origin: json["origin"],
        imageURL: json["image_url"],
        level: json["level"],
        maxHP: json["max_hp"],
        currentHP: json["current_hp"],
        tacticalStress: json["tactical_stress"],
        combatStress: json["combat_stress"],
        skills: List<Skill>.from((json["skills"] ?? []).map((m) => Skill.fromJSON(m))) ?? [],
      );
}

@immutable
class PersonaState {
  final List<Persona> personas;

  const PersonaState({
    this.personas,
  });

  factory PersonaState.initial() => PersonaState(
        personas: [],
      );

  PersonaState copyWith({
    @required List<Persona> personas,
  }) =>
      PersonaState(
        personas: personas ?? this.personas,
      );
}

@immutable
class SetPersonaStateAction {
  final PersonaState state;

  SetPersonaStateAction(this.state);
}

personaReducer(PersonaState state, SetPersonaStateAction action) {
  final payload = action.state;
  return state.copyWith(
    personas: payload.personas,
  );
}

Future<void> _onRefresh() async {
  Redux.store.dispatch(loadPersonas);
}

Future<void> loadPersonas(Store<AppState> store) async {
  store.dispatch(SetPlayerStateAction(PlayerState(isLoading: true)));
  final response = await http.get("$SERVER_URL/personas/${store.state.player.id}");
  final decoded = jsonDecode(response.body);
  final personas = List<Persona>.from(decoded.map((m) => Persona.fromJSON(m)));
  store.dispatch(SetPersonaStateAction(PersonaState(personas: personas)));
  store.dispatch(SetPlayerStateAction(PlayerState(isLoading: false)));
}

class Personas extends StatelessWidget {
  final AppState state;

  Personas({this.state});

  @override
  Widget build(BuildContext context) => list(
        data: this.state.persona.personas,
        onRefresh: _onRefresh,
        item: (Persona persona) => listItem(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PersonaDetail(persona: persona))),
          imageURL: persona.imageURL,
          title: "[${persona.level}] ${persona.name}",
          subtitle: "power: ${persona.power}",
          trailing: Icon(Icons.arrow_right_outlined, color: white),
        ),
      );
}

class PersonaDetail extends StatelessWidget {
  final Persona persona;

  const PersonaDetail({this.persona});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Center(child: Text(persona.name))),
        body: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 12.0),
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(persona.imageURL),
                  ),
                ),
              ),
              textLine("Level", persona.level),
              textLine("Power", persona.power),
              textLine("Origem", persona.origin),
              progressLine(persona.currentHP, persona.maxHP, "Vida", hp),
              progressLine(persona.combatStress, 5, "Combate", combat),
              progressLine(persona.tacticalStress, 5, "Tático", tactical),
              list(
                data: persona.skills,
                item: (Skill skill) => listItem(
                  title: "${skill.name}",
                  subtitle: "power: ${skill.power}",
                  trailing: Text(skill.type),
                ),
              )
            ],
          ),
        ));
  }
}
