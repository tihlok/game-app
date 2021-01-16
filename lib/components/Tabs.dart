import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:game_app_flutter/app/AppState.dart';

class TabData {
  final IconData icon;
  final String title;
  final Widget page;
  Widget tab;

  TabData({this.icon, this.title, this.page}) {
    tab = Tab(
      icon: Icon(icon),
      text: title,
    );
  }
}

tabs({
  List<TabData> tabs,
  String titleAppBar,
  bool showAppBar = true,
  bool showTabs = true,
  bool isLoading = false,
  dynamic defaultPage,
  floatingIcon,
  floatingAction,
}) =>
    StoreConnector<AppState, AppState>(
      distinct: true,
      converter: (store) => store.state,
      builder: (context, state) => DefaultTabController(
          length: (tabs ?? []).length,
          child: Scaffold(
            appBar: showAppBar
                ? AppBar(
                    title: titleAppBar != null ? Center(child: Text(titleAppBar)) : null,
                    bottom: TabBar(tabs: tabs.map((e) => e.tab).toList()),
                  )
                : null,
            body: Center(
                child: isLoading
                    ? CircularProgressIndicator()
                    : showTabs
                        ? TabBarView(children: tabs.map((e) => e.page).toList())
                        : defaultPage),
            floatingActionButton: floatingIcon != null
                ? FloatingActionButton(
                    child: Icon(floatingIcon, color: state.theme.white),
                    backgroundColor: state.theme.primary,
                    onPressed: floatingAction,
                  )
                : null,
          )),
    );
