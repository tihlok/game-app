import 'package:flutter/material.dart';
import 'package:game_app_flutter/app/App.dart';
import 'package:game_app_flutter/app/AppRedux.dart';

void main() async {
  await AppRedux.init();
  runApp(App());
}
