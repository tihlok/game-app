import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:game_app_flutter/app/AppState.dart';
import 'package:game_app_flutter/components/ImageBanner.dart';
import 'package:game_app_flutter/components/ListItem.dart';
import 'package:game_app_flutter/components/Lists.dart';
import 'package:game_app_flutter/components/ProgressLine.dart';
import 'package:game_app_flutter/components/Tabs.dart';
import 'package:game_app_flutter/components/TextLine.dart';
import 'package:game_app_flutter/personas/Persona.dart';
import 'package:game_app_flutter/personas/Skill.dart';

class PersonaDetailPage extends StatelessWidget {
  final Persona persona;

  const PersonaDetailPage({this.persona});

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, AppState>(
        distinct: true,
        converter: (store) => store.state,
        builder: (context, state) => tabs(
          titleAppBar: persona.name,
          floatingIcon: Icons.edit,
          floatingAction: () {},
          tabs: [
            TabData(
              icon: Icons.sort,
              title: "Atributos",
              page: Center(
                child: Column(
                  children: [
                    imageBanner(imageURL: persona.imageURL),
                    textLine("Level", persona.level),
                    textLine("Power", persona.power),
                    textLine("Origem", persona.origin),
                    progressLine(persona.currentHP, persona.maxHP, "Vida", state.theme.hp),
                    progressLine(persona.combatStress, 5, "Combate", state.theme.combat),
                    progressLine(persona.tacticalStress, 5, "Tático", state.theme.tactical)
                  ],
                ),
              ),
            ),
            TabData(
              icon: Icons.animation,
              title: "Skills",
              page: lists(
                data: persona.skills,
                item: (Skill skill) => listItem(
                  title: "${skill.name}",
                  subtitle: "power: ${skill.power}",
                  trailing: Text(skill.type),
                ),
              ),
            ),
          ],
        ),
      );
}
