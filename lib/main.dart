import 'package:flutter/material.dart';
import 'package:game_app_flutter/home.dart';

void main() => runApp(RPGApp());

class RPGApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RPG',
      theme: ThemeData(
          primaryColor: Colors.red[900],
          accentColor: Colors.amber,
          scaffoldBackgroundColor: Color(0xFF1F1F1F),
          textTheme: TextTheme(bodyText2: TextStyle(color: Colors.white)),
          buttonTheme: ButtonThemeData(
            textTheme: ButtonTextTheme.primary,
            buttonColor: Colors.red[900],
          )),
      home: HomePage(title: 'RPG'),
    );
  }
}
