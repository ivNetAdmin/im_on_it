import 'package:flutter/material.dart';

import 'menu_item.dart';


class MenuItems{

  static const List<MenuItem> items = [
    itemSettings,
  ];

  static const itemSettings = MenuItem(
    text: 'Settings',
    icon: Icons.settings,
  );
}