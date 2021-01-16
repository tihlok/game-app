import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:game_app_flutter/app/AppRedux.dart';
import 'package:game_app_flutter/app/AppState.dart';
import 'package:game_app_flutter/components/ListItem.dart';
import 'package:game_app_flutter/components/Lists.dart';
import 'package:game_app_flutter/personas/Persona.dart';
import 'package:game_app_flutter/personas/PersonaAction.dart';
import 'package:game_app_flutter/personas/PersonaDetailPage.dart';

class PersonaListPage extends StatelessWidget {
  Future<void> _onRefresh() async {
    AppRedux.store.dispatch(PersonaAction.loadPersonas);
  }

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, AppState>(
        distinct: true,
        converter: (store) => store.state,
        builder: (context, state) => lists(
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
            trailing: Icon(Icons.arrow_right_outlined, color: state.theme.white),
          ),
        ),
      );
}
