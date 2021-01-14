import 'package:flutter/material.dart';

class TabData {
  final IconData icon;
  final Widget page;
  Widget tab;

  TabData({this.icon, this.page}) {
    this.tab = Tab(icon: Icon(this.icon));
  }
}
