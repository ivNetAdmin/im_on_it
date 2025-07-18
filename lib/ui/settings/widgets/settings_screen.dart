

import 'package:flutter/material.dart';

import '../../shared_widgets/shared_app_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[100],
        body: SafeArea(
          child: CustomScrollView(
              slivers: <Widget>[
                SharedAppBar(),
              ],
          ),
        )
    );
  }
}