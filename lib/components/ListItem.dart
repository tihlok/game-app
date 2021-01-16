import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:game_app_flutter/app/AppState.dart';

listItem({GestureTapCallback onTap, color, String imageURL, String title, String subtitle, dynamic trailing}) => StoreConnector<AppState, AppState>(
      distinct: true,
      converter: (store) => store.state,
      builder: (context, state) => InkWell(
        splashColor: color ?? state.theme.primary,
        highlightColor: state.theme.transparent,
        onTap: onTap ?? () {},
        child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            elevation: 5,
            child: ListTile(
              tileColor: state.theme.background,
              leading: imageURL != null ? CircleAvatar(radius: 30, backgroundImage: NetworkImage(imageURL)) : null,
              title: title != null ? Text(title) : null,
              subtitle: subtitle != null ? Text(subtitle) : null,
              trailing: trailing != null ? trailing : null,
            )),
      ),
    );
