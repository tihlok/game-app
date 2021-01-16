import 'package:flutter/material.dart';
import 'package:game_app_flutter/themes/ITheme.dart';

class DefaultTheme extends ITheme {
  DefaultTheme()
      : super(
          primary: Colors.red[900],
          hp: Colors.red[500],
          tactical: Colors.yellow[700],
          combat: Colors.green[500],
          background: Color(0xFF1F1F1F),
          backgroundLight: Color(0xFF2F2F2F),
          white: Colors.white,
          transparent: Colors.transparent,
        );
}
