import 'package:flutter/material.dart';
import 'package:game_app_flutter/components.dart';
import 'package:game_app_flutter/personas/Persona.dart';
import 'package:game_app_flutter/personas/Skill.dart';
import 'package:game_app_flutter/tab.dart';
import 'package:game_app_flutter/theme.dart';

class PersonaDetailPage extends StatelessWidget {
  final Persona persona;

  const PersonaDetailPage({this.persona});

  @override
  Widget build(BuildContext context) => tabs(
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
                  progressLine(persona.currentHP, persona.maxHP, "Vida", AppTheme.hp),
                  progressLine(persona.combatStress, 5, "Combate", AppTheme.combat),
                  progressLine(persona.tacticalStress, 5, "Tático", AppTheme.tactical)
                ],
              ),
            ),
          ),
          TabData(
            icon: Icons.animation,
            title: "Skills",
            page: list(
              data: persona.skills,
              item: (Skill skill) => listItem(
                title: "${skill.name}",
                subtitle: "power: ${skill.power}",
                trailing: Text(skill.type),
              ),
            ),
          ),
        ],
      );
}
