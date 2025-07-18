
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/enums/menu_value_enum.dart';

class SharedAppBar extends StatelessWidget {
  const SharedAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text("I'm On It, Okay"),
      floating: false,
      pinned: true,
      backgroundColor: Colors.blueGrey[100],
      actions: [
        PopupMenuButton<MenuValueEnum>(
            onSelected: (value) {
              switch (value) {
                case MenuValueEnum.home:
                  context.go('/');
                case MenuValueEnum.completedTasks:
                  context.go('/completed-tasks');
                case MenuValueEnum.settings:
                  context.go('/settings');
              }
            },
            itemBuilder: (BuildContext context) =>
            <PopupMenuEntry<MenuValueEnum>>[
              PopupMenuItem<MenuValueEnum>(
                value: MenuValueEnum.home,
                child: ListTile(
                  leading: Icon(Icons.home),
                  title: Text('H O M E'),
                ),
              ),
              PopupMenuItem<MenuValueEnum>(
                value: MenuValueEnum.completedTasks,
                child: ListTile(
                  leading: Icon(Icons.done),
                  title: Text('C O M P L E T E D  T A S K S'),
                ),
              ),
              PopupMenuItem<MenuValueEnum>(
                value: MenuValueEnum.settings,
                child: const ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('S E T T I N G S'),
                ),
              ),
            ]
        )
      ],
    );
  }
}
