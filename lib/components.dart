import 'package:flutter/material.dart';
import 'package:game_app_flutter/tab.dart';
import 'package:game_app_flutter/theme.dart';
import 'package:intl/intl.dart';

progressLine(int current, int max, String text, color) {
  final _current = NumberFormat.compactCurrency(decimalDigits: 0, symbol: '').format(current);
  final _max = NumberFormat.compactCurrency(decimalDigits: 0, symbol: '').format(max);
  return Container(
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
                backgroundColor: backgroundLight,
                valueColor: AlwaysStoppedAnimation(color),
                minHeight: 6,
                value: current / max,
              ),
            ),
          ],
        )
      ]));
}

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

imageBanner({String imageURL, height: 200.0}) => Container(
      margin: EdgeInsets.only(bottom: 12.0),
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(imageURL),
        ),
      ),
    );

_list(data, item) => ListView.builder(
      padding: EdgeInsets.all(8),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (context, index) => Container(height: 80, child: item(data[index])),
    );

list<T>({List<T> data, onRefresh, item}) => data.length > 0
    ? onRefresh != null
        ? RefreshIndicator(color: primary, onRefresh: onRefresh, child: _list(data, item))
        : _list(data, item)
    : Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text("nada aqui...")]);

listItem({GestureTapCallback onTap, color, String imageURL, String title, String subtitle, dynamic trailing}) => InkWell(
      splashColor: color ?? primary,
      highlightColor: transparent,
      onTap: onTap ?? () {},
      child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 5,
          child: ListTile(
            tileColor: background,
            leading: imageURL != null ? CircleAvatar(radius: 30, backgroundImage: NetworkImage(imageURL)) : null,
            title: title != null ? Text(title) : null,
            subtitle: subtitle != null ? Text(subtitle) : null,
            trailing: trailing != null ? trailing : null,
          )),
    );

tabs({
  List<TabData> tabs,
  String titleAppBar,
  bool showAppBar = true,
  bool showTabs = true,
  bool isLoading = false,
  dynamic defaultPage
}) =>
    DefaultTabController(
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
        ));
