import 'package:flutter/material.dart';

abstract class ITheme {
  final Color primary;
  final Color hp;
  final Color tactical;
  final Color combat;
  final Color background;
  final Color backgroundLight;
  final Color white;
  final Color transparent;

  ITheme({
    this.primary,
    this.hp,
    this.tactical,
    this.combat,
    this.background,
    this.backgroundLight,
    this.white,
    this.transparent,
  });
}
