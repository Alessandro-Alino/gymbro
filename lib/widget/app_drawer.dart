import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gymbro/config/l10n/app_local.dart';
import 'package:gymbro/config/router/router_const.dart';
import 'package:gymbro/widget/theme_dialog.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Header
          const DrawerHeader(
            child: Row(
              children: [
                CircleAvatar(),
              ],
            ),
          ),
          // Program List
          ListTile(
            onTap: () {
              // Call also "pop" to close the Menu Drawer even when navigate to new page
              context
                ..pop()
                ..push(programListPage);
            },
            leading: const Icon(Icons.list_alt),
            title: Text(context.ltr.program_list_page),
          ),
          // Exercise List
          ListTile(
            onTap: () {
              // Call also "pop" to close the Menu Drawer even when navigate to new page
              context
                ..pop()
                ..push(allExerciseListPage);
            },
            leading: const Icon(Icons.featured_play_list_outlined),
            title: Text(context.ltr.exercise_list_page),
          ),
          // Theme
          ListTile(
            onTap: () {
              context.pop();
              showDialog(
                context: context,
                builder: (context) {
                  return const ThemeDialog();
                },
              );
            },
            leading: const Icon(Icons.palette),
            title: Text(context.ltr.theme),
          ),
        ],
      ),
    );
  }
}
