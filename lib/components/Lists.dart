import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:game_app_flutter/app/AppState.dart';

_lists(data, item) => ListView.builder(
      padding: EdgeInsets.all(8),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (context, index) => Container(height: 80, child: item(data[index])),
    );

lists<T>({List<T> data, onRefresh, item}) => data.length > 0
    ? onRefresh != null
        ? StoreConnector<AppState, AppState>(
            distinct: true,
            converter: (store) => store.state,
            builder: (context, state) => RefreshIndicator(
              color: state.theme.primary,
              onRefresh: onRefresh,
              child: _lists(data, item),
            ),
          )
        : _lists(data, item)
    : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("nada aqui...")],
      );
