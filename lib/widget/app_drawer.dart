import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gymbro/config/l10n/app_local.dart';
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
          // Body
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
