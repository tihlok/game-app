import 'package:flutter/material.dart';
import 'package:game_app_flutter/personas/PersonaState.dart';
import 'package:game_app_flutter/player/PlayerState.dart';
import 'package:game_app_flutter/themes/ITheme.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final ITheme theme;
  final PlayerState player;
  final PersonaState persona;

  AppState({
    @required this.theme,
    @required this.player,
    @required this.persona,
  });

  AppState copyWith({
    ITheme theme,
    PlayerState player,
    PersonaState persona,
  }) =>
      AppState(
        theme: theme ?? this.theme,
        player: player ?? this.player,
        persona: persona ?? this.persona,
      );
}
