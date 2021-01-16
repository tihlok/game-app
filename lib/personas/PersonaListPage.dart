import 'package:flutter/material.dart';
import 'package:game_app_flutter/app.dart';
import 'package:game_app_flutter/components.dart';
import 'package:game_app_flutter/personas/Persona.dart';
import 'package:game_app_flutter/personas/PersonaAction.dart';
import 'package:game_app_flutter/personas/PersonaDetailPage.dart';
import 'package:game_app_flutter/theme.dart';

class PersonaListPage extends StatelessWidget {
  final AppState state;

  PersonaListPage({this.state});

  Future<void> _onRefresh() async {
    Redux.store.dispatch(PersonaAction.loadPersonas);
  }

  @override
  Widget build(BuildContext context) => list(
        data: state.persona.personas,
        onRefresh: _onRefresh,
        item: (Persona persona) => listItem(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PersonaDetailPage(persona: persona),
            ),
          ),
          imageURL: persona.imageURL,
          title: persona.title,
          subtitle: persona.subtitle,
          trailing: Icon(Icons.arrow_right_outlined, color: AppTheme.white),
        ),
      );
}
