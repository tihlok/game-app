import 'package:flutter/material.dart';

textLine(String text, dynamic value) => Container(
    margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 6.0),
    child: Column(children: [
      Row(
        children: <Widget>[
          Expanded(
            flex: 4, // 20%
            child: Text(text, textAlign: TextAlign.right),
          ),
          SizedBox(width: 10.0),
          Expanded(
            flex: 6, // 60%
            child: Text("${value ?? "-"}", textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      )
    ]));
