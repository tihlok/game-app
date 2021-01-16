import 'package:flutter/material.dart';

class TabData {
  final IconData icon;
  final String title;
  final Widget page;
  Widget tab;

  TabData({this.icon, this.title, this.page}) {
    this.tab = Tab(
      icon: Icon(this.icon),
      text: this.title,
    );
  }
}
