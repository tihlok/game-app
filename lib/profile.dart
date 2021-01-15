import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final logoutAction;
  final Map<String, Map<String, dynamic>> player;

  Profile(this.logoutAction, this.player);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red[900], width: 4.0),
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(this.player["profile"]["picture"] ?? ''),
            ),
          ),
        ),
        SizedBox(height: 24.0),
        Text(this.player["idToken"]["name"]),
        SizedBox(height: 48.0),
        // Text(this.player.toString()),
        // SizedBox(height: 48.0),
        RaisedButton(
          onPressed: () {
            logoutAction();
          },
          child: Text('Logout'),
        ),
      ],
    );
  }
}
