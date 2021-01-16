import 'package:flutter/material.dart';

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
