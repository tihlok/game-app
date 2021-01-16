import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:game_app_flutter/app/AppState.dart';
import 'package:intl/intl.dart';

progressLine(int current, int max, String text, color) {
  final _current = NumberFormat.compactCurrency(decimalDigits: 0, symbol: '').format(current);
  final _max = NumberFormat.compactCurrency(decimalDigits: 0, symbol: '').format(max);
  return StoreConnector<AppState, AppState>(
    distinct: true,
    converter: (store) => store.state,
    builder: (context, state) => Container(
        margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 6.0),
        child: Column(children: [
          Row(
            children: <Widget>[
              Expanded(
                flex: 4, // 20%
                child: Text(
                  "$text $_current / $_max",
                  textAlign: TextAlign.right,
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                flex: 6, // 60%
                child: LinearProgressIndicator(
                  backgroundColor: state.theme.backgroundLight,
                  valueColor: AlwaysStoppedAnimation(color),
                  minHeight: 6,
                  value: current / max,
                ),
              ),
            ],
          )
        ])),
  );
}
