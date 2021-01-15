import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:game_app_flutter/app.dart';
import 'package:game_app_flutter/config.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';

class Persona {
  final int id;
  final String name;
  final String imageURL;
  final int level;

  const Persona({this.id, this.name, this.imageURL, this.level});

  get power => 0;

  factory Persona.fromJSON(Map<String, dynamic> json) => Persona(
        id: json["id"],
        name: json["name"],
        imageURL: json["image_url"],
        level: json["level"],
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
  final response = await http.get("$SERVER_URL/personas/${store.state.player.id}");
  final decoded = jsonDecode(response.body);
  final personas = List<Persona>.from(decoded.map((m) => Persona.fromJSON(m)));
  store.dispatch(SetPersonaStateAction(PersonaState(personas: personas)));
}

class Personas extends StatelessWidget {
  final AppState state;

  Personas({this.state});

  @override
  Widget build(BuildContext context) {
    return this.state.persona.personas.length > 0
        ? RefreshIndicator(
            color: Colors.red[900],
            onRefresh: _onRefresh,
            child: ListView.builder(
                padding: EdgeInsets.all(8),
                itemCount: this.state.persona.personas.length,
                itemBuilder: (context, index) => Container(
                    height: 80,
                    child: InkWell(
                      splashColor: Colors.red[900],
                      highlightColor: Colors.transparent,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PersonaDetail(
                                  persona: this.state.persona.personas[index],
                                )),
                      ),
                      child: Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                          elevation: 5,
                          child: ListTile(
                            tileColor: Color(0xFF1F1F1F),
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(this.state.persona.personas[index].imageURL),
                            ),
                            title: Text(this.state.persona.personas[index].name),
                            subtitle: Text("level: ${this.state.persona.personas[index].level}"),
                            trailing: Text("power: ${this.state.persona.personas[index].power}"),
                          )),
                    ))),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Text("nenhuma persona aqui...")],
          );
  }
}

class PersonaDetail extends StatelessWidget {
  final Persona persona;

  PersonaDetail({this.persona});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text(persona.name)),
        ),
        body: Center(
          child: Text("RPG"),
        ));
  }
}
