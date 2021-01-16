import 'package:game_app_flutter/personas/Persona.dart';
import 'package:meta/meta.dart';

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
